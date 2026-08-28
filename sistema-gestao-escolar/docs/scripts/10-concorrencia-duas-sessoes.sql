-- Modulo 11 - Execute blocos em duas abas/conexoes do MySQL Workbench.
-- Nunca execute o arquivo inteiro como um unico script.

USE gestao_escolar;

-- ============================================================
-- EXPERIMENTO 1 - BLOQUEIO
-- SESSAO A
-- ============================================================
-- SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- START TRANSACTION;
-- SELECT id_turma, capacidade FROM turma WHERE id_turma = 1 FOR UPDATE;
-- Mantenha a transacao aberta e passe para a sessao B.

-- SESSAO B
-- SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- START TRANSACTION;
-- SELECT id_turma, capacidade FROM turma WHERE id_turma = 1 FOR UPDATE;
-- A consulta aguardara a liberacao do bloqueio.

-- SESSAO A
-- COMMIT;

-- SESSAO B
-- A consulta termina apos a liberacao.
-- ROLLBACK;

-- ============================================================
-- EXPERIMENTO 2 - ATUALIZACAO PERDIDA EVITADA
-- ============================================================
-- Use SELECT ... FOR UPDATE antes de ler e alterar a capacidade.
-- SESSAO A: bloqueie turma 1, atualize capacidade = capacidade + 1 e COMMIT.
-- SESSAO B: tente bloquear a mesma linha; aguarde e depois leia o valor novo.

-- ============================================================
-- EXPERIMENTO 3 - DEADLOCK CONTROLADO
-- ============================================================
-- SESSAO A
-- START TRANSACTION;
-- SELECT * FROM turma WHERE id_turma = 1 FOR UPDATE;
-- Depois que B bloquear turma 2:
-- SELECT * FROM turma WHERE id_turma = 2 FOR UPDATE;

-- SESSAO B
-- START TRANSACTION;
-- SELECT * FROM turma WHERE id_turma = 2 FOR UPDATE;
-- Depois que A bloquear turma 1:
-- SELECT * FROM turma WHERE id_turma = 1 FOR UPDATE;

-- O MySQL abortara uma das transacoes como vitima do deadlock.
-- Em ambas as sessoes, finalize com ROLLBACK se ainda houver transacao aberta.

-- Diagnostico MySQL:
-- SHOW ENGINE INNODB STATUS;
