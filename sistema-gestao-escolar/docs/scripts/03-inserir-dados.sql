-- ============================================================================
-- Curso de Banco de Dados - Sistema de Gestao Escolar
-- Script: 03-inserir-dados.sql
-- Objetivo: inserir uma carga inicial ficticia, pequena e verificavel.
-- SGBD alvo: MySQL Community 8.0+
-- Pre-requisitos: scripts 00 e 01 executados sem erro.
-- ============================================================================
--
-- IMPORTANTE:
-- 1. Todos os dados sao ficticios.
-- 2. O script foi desenhado para banco vazio e nao e idempotente.
-- 3. IDs explicitos tornam os relacionamentos didaticos e verificaveis.
-- 4. Em producao, IDs gerados devem ser obtidos de forma segura.
-- 5. O modulo de transacoes aprofundara tratamento de falhas.
-- ============================================================================

USE gestao_escolar;

START TRANSACTION;

INSERT INTO curso (
    id_curso,
    codigo,
    nome,
    carga_horaria,
    situacao
) VALUES
    (1, 'WEB-BE-200', 'Desenvolvimento Web Back-End', 200, 'ATIVO'),
    (2, 'CD-INTRO-160', 'Introducao a Ciencia de Dados', 160, 'ATIVO');

INSERT INTO disciplina (
    id_disciplina,
    id_curso,
    codigo,
    nome,
    carga_horaria,
    situacao
) VALUES
    (1, 1, 'BD-060', 'Banco de Dados', 60, 'ATIVA'),
    (2, 1, 'PWEB-040', 'Programacao Web Back-End', 40, 'ATIVA'),
    (3, 2, 'EST-040', 'Estatistica Aplicada', 40, 'ATIVA');

INSERT INTO professor (
    id_professor,
    codigo_funcional,
    nome,
    email_institucional,
    situacao
) VALUES
    (1, 'PROF-001', 'Marina Oliveira', 'marina.oliveira@escola.example', 'ATIVO'),
    (2, 'PROF-002', 'Carlos Mendes', 'carlos.mendes@escola.example', 'ATIVO'),
    (3, 'PROF-003', 'Juliana Rocha', 'juliana.rocha@escola.example', 'ATIVO');

INSERT INTO aluno (
    id_aluno,
    matricula,
    nome,
    nome_social,
    data_nascimento,
    email,
    situacao
) VALUES
    (1, '20260001', 'Ana Souza', NULL, '2007-04-10', 'ana.souza@example.test', 'ATIVO'),
    (2, '20260002', 'Bruno Lima', NULL, '2006-11-22', 'bruno.lima@example.test', 'ATIVO'),
    (3, '20260003', 'Camila Alves', 'Cami Alves', '2007-07-15', 'camila.alves@example.test', 'ATIVO'),
    (4, '20260004', 'Diego Santos', NULL, '2006-02-28', 'diego.santos@example.test', 'ATIVO'),
    (5, '20260005', 'Elisa Moraes', NULL, '2007-09-03', 'elisa.moraes@example.test', 'ATIVO');

INSERT INTO turma (
    id_turma,
    id_disciplina,
    codigo,
    periodo,
    data_inicio,
    data_fim,
    capacidade,
    situacao
) VALUES
    (1, 1, 'A', '2026-2', '2026-08-03', '2026-10-30', 30, 'EM_ANDAMENTO'),
    (2, 2, 'A', '2026-2', '2026-08-03', '2026-09-30', 30, 'EM_ANDAMENTO'),
    (3, 3, 'A', '2026-2', '2026-08-10', '2026-10-16', 25, 'ABERTA');

INSERT INTO turma_professor (
    id_turma_professor,
    id_turma,
    id_professor,
    data_inicio,
    data_fim,
    papel
) VALUES
    (1, 1, 1, '2026-08-03', NULL, 'RESPONSAVEL'),
    (2, 2, 2, '2026-08-03', NULL, 'RESPONSAVEL'),
    (3, 3, 3, '2026-08-10', NULL, 'RESPONSAVEL'),
    (4, 1, 2, '2026-08-03', NULL, 'COLABORADOR');

INSERT INTO matricula (
    id_matricula,
    id_aluno,
    id_turma,
    data_matricula,
    situacao,
    forma_ingresso,
    data_cancelamento
) VALUES
    (1, 1, 1, '2026-07-20', 'ATIVA', 'INSCRICAO', NULL),
    (2, 2, 1, '2026-07-20', 'ATIVA', 'INSCRICAO', NULL),
    (3, 3, 1, '2026-07-21', 'ATIVA', 'INSCRICAO', NULL),
    (4, 4, 1, '2026-07-21', 'ATIVA', 'INSCRICAO', NULL),
    (5, 5, 1, '2026-07-22', 'CANCELADA', 'INSCRICAO', '2026-08-05'),
    (6, 1, 2, '2026-07-20', 'ATIVA', 'INSCRICAO', NULL),
    (7, 2, 2, '2026-07-20', 'ATIVA', 'INSCRICAO', NULL),
    (8, 3, 2, '2026-07-21', 'ATIVA', 'INSCRICAO', NULL);

INSERT INTO avaliacao (
    id_avaliacao,
    id_turma,
    titulo,
    data_avaliacao,
    valor_maximo,
    peso,
    situacao
) VALUES
    (1, 1, 'Atividade de Modelagem', '2026-08-21', 10.00, 0.3000, 'ENCERRADA'),
    (2, 1, 'Avaliacao SQL', '2026-09-18', 10.00, 0.7000, 'PLANEJADA'),
    (3, 2, 'API Inicial', '2026-08-28', 10.00, 0.4000, 'ABERTA'),
    (4, 2, 'Projeto Integrador', '2026-09-25', 10.00, 0.6000, 'PLANEJADA');

INSERT INTO nota (
    id_nota,
    id_matricula,
    id_avaliacao,
    valor,
    observacao
) VALUES
    (1, 1, 1, 8.50, 'Entrega completa'),
    (2, 2, 1, 7.00, NULL),
    (3, 3, 1, 9.20, 'Boa justificativa'),
    (4, 4, 1, 6.50, NULL),
    (5, 6, 3, 8.00, NULL),
    (6, 7, 3, 7.50, NULL),
    (7, 8, 3, 9.00, NULL);

COMMIT;

-- Verificacao rapida da carga.
SELECT 'curso' AS tabela, COUNT(*) AS quantidade FROM curso
UNION ALL
SELECT 'disciplina', COUNT(*) FROM disciplina
UNION ALL
SELECT 'professor', COUNT(*) FROM professor
UNION ALL
SELECT 'aluno', COUNT(*) FROM aluno
UNION ALL
SELECT 'turma', COUNT(*) FROM turma
UNION ALL
SELECT 'turma_professor', COUNT(*) FROM turma_professor
UNION ALL
SELECT 'matricula', COUNT(*) FROM matricula
UNION ALL
SELECT 'avaliacao', COUNT(*) FROM avaliacao
UNION ALL
SELECT 'nota', COUNT(*) FROM nota;
