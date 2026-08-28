-- ============================================================================
-- Curso de Banco de Dados - Sistema de Gestao Escolar
-- Script: 01-criar-tabelas.sql
-- Objetivo: implementar o esquema fisico inicial.
-- SGBD alvo: MySQL Community 8.0.16+
-- Pre-requisito: executar 00-criar-banco.sql.
-- ============================================================================
--
-- PORTABILIDADE:
-- A maior parte de CREATE TABLE, PK, FK, UNIQUE, NOT NULL, DEFAULT e CHECK
-- segue conceitos padronizados. AUTO_INCREMENT, ENGINE e alguns detalhes de
-- tipos/constraints sao especificos do MySQL.
--
-- DECISOES:
-- 1. Nomes em snake_case e tabelas no singular.
-- 2. Chaves tecnicas inteiras com AUTO_INCREMENT (MySQL).
-- 3. Chaves de negocio preservadas com UNIQUE.
-- 4. ENUM foi evitado; dominios usam VARCHAR + CHECK.
-- 5. Exclusoes em cascata foram evitadas para proteger historico escolar.
-- 6. A regra "uma matricula ativa por aluno/turma" nao cabe em UNIQUE simples
--    quando o historico e mantido; sera tratada em modulo de transacoes/regras.
-- ============================================================================

USE gestao_escolar;

CREATE TABLE aluno (
    id_aluno BIGINT NOT NULL AUTO_INCREMENT,
    matricula VARCHAR(30) NOT NULL,
    nome VARCHAR(150) NOT NULL,
    nome_social VARCHAR(150) NULL,
    data_nascimento DATE NULL,
    email VARCHAR(254) NULL,
    situacao VARCHAR(20) NOT NULL DEFAULT 'ATIVO',
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_aluno PRIMARY KEY (id_aluno),
    CONSTRAINT uq_aluno_matricula UNIQUE (matricula),
    CONSTRAINT uq_aluno_email UNIQUE (email),
    CONSTRAINT ck_aluno_nome CHECK (CHAR_LENGTH(TRIM(nome)) >= 2),
    CONSTRAINT ck_aluno_situacao
        CHECK (situacao IN ('ATIVO', 'INATIVO'))
) ENGINE = InnoDB;

CREATE TABLE professor (
    id_professor BIGINT NOT NULL AUTO_INCREMENT,
    codigo_funcional VARCHAR(30) NOT NULL,
    nome VARCHAR(150) NOT NULL,
    email_institucional VARCHAR(254) NULL,
    situacao VARCHAR(20) NOT NULL DEFAULT 'ATIVO',
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_professor PRIMARY KEY (id_professor),
    CONSTRAINT uq_professor_codigo UNIQUE (codigo_funcional),
    CONSTRAINT uq_professor_email UNIQUE (email_institucional),
    CONSTRAINT ck_professor_nome CHECK (CHAR_LENGTH(TRIM(nome)) >= 2),
    CONSTRAINT ck_professor_situacao
        CHECK (situacao IN ('ATIVO', 'INATIVO'))
) ENGINE = InnoDB;

CREATE TABLE curso (
    id_curso BIGINT NOT NULL AUTO_INCREMENT,
    codigo VARCHAR(30) NOT NULL,
    nome VARCHAR(150) NOT NULL,
    carga_horaria INTEGER NOT NULL,
    situacao VARCHAR(20) NOT NULL DEFAULT 'ATIVO',
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_curso PRIMARY KEY (id_curso),
    CONSTRAINT uq_curso_codigo UNIQUE (codigo),
    CONSTRAINT ck_curso_nome CHECK (CHAR_LENGTH(TRIM(nome)) >= 2),
    CONSTRAINT ck_curso_carga_horaria CHECK (carga_horaria > 0),
    CONSTRAINT ck_curso_situacao
        CHECK (situacao IN ('ATIVO', 'INATIVO'))
) ENGINE = InnoDB;

CREATE TABLE disciplina (
    id_disciplina BIGINT NOT NULL AUTO_INCREMENT,
    id_curso BIGINT NOT NULL,
    codigo VARCHAR(30) NOT NULL,
    nome VARCHAR(150) NOT NULL,
    carga_horaria INTEGER NOT NULL,
    situacao VARCHAR(20) NOT NULL DEFAULT 'ATIVA',
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_disciplina PRIMARY KEY (id_disciplina),
    CONSTRAINT uq_disciplina_curso_codigo UNIQUE (id_curso, codigo),
    CONSTRAINT ck_disciplina_nome CHECK (CHAR_LENGTH(TRIM(nome)) >= 2),
    CONSTRAINT ck_disciplina_carga_horaria CHECK (carga_horaria > 0),
    CONSTRAINT ck_disciplina_situacao
        CHECK (situacao IN ('ATIVA', 'INATIVA')),
    CONSTRAINT fk_disciplina_curso
        FOREIGN KEY (id_curso)
        REFERENCES curso (id_curso)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE TABLE turma (
    id_turma BIGINT NOT NULL AUTO_INCREMENT,
    id_disciplina BIGINT NOT NULL,
    codigo VARCHAR(30) NOT NULL,
    periodo VARCHAR(20) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NULL,
    capacidade INTEGER NULL,
    situacao VARCHAR(20) NOT NULL DEFAULT 'PLANEJADA',
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_turma PRIMARY KEY (id_turma),
    CONSTRAINT uq_turma_disciplina_codigo_periodo
        UNIQUE (id_disciplina, codigo, periodo),
    CONSTRAINT ck_turma_periodo CHECK (CHAR_LENGTH(TRIM(periodo)) >= 4),
    CONSTRAINT ck_turma_datas
        CHECK (data_fim IS NULL OR data_fim >= data_inicio),
    CONSTRAINT ck_turma_capacidade
        CHECK (capacidade IS NULL OR capacidade > 0),
    CONSTRAINT ck_turma_situacao
        CHECK (situacao IN (
            'PLANEJADA', 'ABERTA', 'EM_ANDAMENTO', 'ENCERRADA', 'CANCELADA'
        )),
    CONSTRAINT fk_turma_disciplina
        FOREIGN KEY (id_disciplina)
        REFERENCES disciplina (id_disciplina)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE TABLE turma_professor (
    id_turma_professor BIGINT NOT NULL AUTO_INCREMENT,
    id_turma BIGINT NOT NULL,
    id_professor BIGINT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NULL,
    papel VARCHAR(30) NOT NULL DEFAULT 'RESPONSAVEL',

    CONSTRAINT pk_turma_professor PRIMARY KEY (id_turma_professor),
    CONSTRAINT uq_turma_professor_inicio
        UNIQUE (id_turma, id_professor, data_inicio),
    CONSTRAINT ck_turma_professor_datas
        CHECK (data_fim IS NULL OR data_fim >= data_inicio),
    CONSTRAINT ck_turma_professor_papel
        CHECK (papel IN ('RESPONSAVEL', 'COLABORADOR', 'SUBSTITUTO')),
    CONSTRAINT fk_turma_professor_turma
        FOREIGN KEY (id_turma)
        REFERENCES turma (id_turma)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
    CONSTRAINT fk_turma_professor_professor
        FOREIGN KEY (id_professor)
        REFERENCES professor (id_professor)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE TABLE matricula (
    id_matricula BIGINT NOT NULL AUTO_INCREMENT,
    id_aluno BIGINT NOT NULL,
    id_turma BIGINT NOT NULL,
    data_matricula DATE NOT NULL,
    situacao VARCHAR(20) NOT NULL DEFAULT 'ATIVA',
    forma_ingresso VARCHAR(30) NULL,
    data_cancelamento DATE NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_matricula PRIMARY KEY (id_matricula),
    CONSTRAINT uq_matricula_aluno_turma_data
        UNIQUE (id_aluno, id_turma, data_matricula),
    CONSTRAINT ck_matricula_situacao
        CHECK (situacao IN (
            'ATIVA', 'TRANCADA', 'CANCELADA', 'CONCLUIDA', 'REPROVADA'
        )),
    CONSTRAINT ck_matricula_cancelamento
        CHECK (
            (situacao = 'CANCELADA' AND data_cancelamento IS NOT NULL)
            OR
            (situacao <> 'CANCELADA' AND data_cancelamento IS NULL)
        ),
    CONSTRAINT fk_matricula_aluno
        FOREIGN KEY (id_aluno)
        REFERENCES aluno (id_aluno)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
    CONSTRAINT fk_matricula_turma
        FOREIGN KEY (id_turma)
        REFERENCES turma (id_turma)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE TABLE avaliacao (
    id_avaliacao BIGINT NOT NULL AUTO_INCREMENT,
    id_turma BIGINT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    data_avaliacao DATE NULL,
    valor_maximo DECIMAL(6,2) NOT NULL DEFAULT 10.00,
    peso DECIMAL(5,4) NULL,
    situacao VARCHAR(20) NOT NULL DEFAULT 'PLANEJADA',
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_avaliacao PRIMARY KEY (id_avaliacao),
    CONSTRAINT uq_avaliacao_turma_titulo UNIQUE (id_turma, titulo),
    CONSTRAINT ck_avaliacao_titulo CHECK (CHAR_LENGTH(TRIM(titulo)) >= 2),
    CONSTRAINT ck_avaliacao_valor_maximo CHECK (valor_maximo > 0),
    CONSTRAINT ck_avaliacao_peso
        CHECK (peso IS NULL OR (peso > 0 AND peso <= 1)),
    CONSTRAINT ck_avaliacao_situacao
        CHECK (situacao IN ('PLANEJADA', 'ABERTA', 'ENCERRADA', 'CANCELADA')),
    CONSTRAINT fk_avaliacao_turma
        FOREIGN KEY (id_turma)
        REFERENCES turma (id_turma)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE TABLE nota (
    id_nota BIGINT NOT NULL AUTO_INCREMENT,
    id_matricula BIGINT NOT NULL,
    id_avaliacao BIGINT NOT NULL,
    valor DECIMAL(6,2) NOT NULL,
    data_lancamento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    observacao VARCHAR(500) NULL,

    CONSTRAINT pk_nota PRIMARY KEY (id_nota),
    CONSTRAINT uq_nota_matricula_avaliacao
        UNIQUE (id_matricula, id_avaliacao),
    CONSTRAINT ck_nota_valor_nao_negativo CHECK (valor >= 0),
    CONSTRAINT fk_nota_matricula
        FOREIGN KEY (id_matricula)
        REFERENCES matricula (id_matricula)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
    CONSTRAINT fk_nota_avaliacao
        FOREIGN KEY (id_avaliacao)
        REFERENCES avaliacao (id_avaliacao)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
) ENGINE = InnoDB;

-- A regra valor <= avaliacao.valor_maximo envolve outra tabela e nao pode ser
-- expressa por CHECK simples no MySQL. Sera tratada na camada de servico e,
-- se necessario, por mecanismo adicional discutido em modulo posterior.
