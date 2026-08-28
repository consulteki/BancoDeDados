-- Módulo 7 — Laboratório DML reversível
-- SGBD: MySQL Community 8+
-- Pré-requisito: executar 01-criar-banco.sql, 02-criar-tabelas.sql e
-- 03-inserir-dados.sql, nessa ordem.
--
-- Este laboratório termina com ROLLBACK: nenhuma alteração será persistida.
-- Execute o arquivo inteiro no MySQL Workbench.

USE gestao_escolar;

START TRANSACTION;

-- ============================================================
-- 1. INSERT — sempre informe as colunas
-- ============================================================

INSERT INTO aluno (
    matricula,
    nome,
    data_nascimento,
    email,
    telefone,
    data_ingresso,
    situacao
) VALUES (
    '20269999',
    'Estudante Temporário',
    '2005-08-10',
    'temporario@example.test',
    '11999990000',
    CURRENT_DATE,
    'ATIVO'
);

-- Recurso específico do MySQL: recupera o AUTO_INCREMENT gerado
-- pela última inserção desta conexão.
SET @aluno_temporario_id = LAST_INSERT_ID();

SELECT *
FROM aluno
WHERE id = @aluno_temporario_id;

-- ============================================================
-- 2. UPDATE — faça um SELECT antes e use uma chave no WHERE
-- ============================================================

SELECT id, matricula, email, telefone
FROM aluno
WHERE id = @aluno_temporario_id;

UPDATE aluno
SET email = 'temporario.atualizado@example.test',
    telefone = '11988880000'
WHERE id = @aluno_temporario_id;

-- ROW_COUNT() é específico do MySQL.
SELECT ROW_COUNT() AS linhas_atualizadas;

SELECT id, matricula, email, telefone
FROM aluno
WHERE id = @aluno_temporario_id;

-- Exemplo perigoso — NÃO EXECUTE:
-- UPDATE aluno SET situacao = 'INATIVO';
-- Sem WHERE, todos os alunos seriam alterados.

-- ============================================================
-- 3. DELETE — confirme dependências antes de excluir
-- ============================================================

SELECT COUNT(*) AS matriculas_dependentes
FROM matricula
WHERE aluno_id = @aluno_temporario_id;

-- Como o aluno temporário não possui matrícula, a exclusão física é segura.
DELETE FROM aluno
WHERE id = @aluno_temporario_id;

SELECT ROW_COUNT() AS linhas_excluidas;

-- Para registros históricos, prefira mudar o estado:
-- UPDATE aluno SET situacao = 'INATIVO' WHERE id = ?;
-- As FKs do projeto usam ON DELETE RESTRICT e impedem apagar pais referenciados.
-- Exemplo que falharia caso o aluno 1 possua matrículas:
-- DELETE FROM aluno WHERE id = 1;

-- ============================================================
-- 4. Encerrar sem persistir
-- ============================================================

ROLLBACK;

-- A matrícula temporária não deve existir após o ROLLBACK.
SELECT COUNT(*) AS aluno_temporario_apos_rollback
FROM aluno
WHERE matricula = '20269999';
