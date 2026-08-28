-- ============================================================================
-- Curso de Banco de Dados - Sistema de Gestao Escolar
-- Modulo 10: criacao e avaliacao de indices
-- SGBD alvo: MySQL Community 8.0+
-- Pre-requisito: executar primeiro 07-diagnostico-desempenho.sql
--
-- ATENCAO:
-- Este script e DDL e deve ser executado apenas uma vez por base.
-- Para repetir o laboratorio, execute a secao de limpeza ao final e depois
-- execute novamente este arquivo.
-- ============================================================================

USE gestao_escolar;

-- 1. Consulta: turma + situacao + ordenacao por data.
CREATE INDEX idx_matricula_turma_situacao_data
    ON matricula (id_turma, situacao, data_matricula);

-- 2. Consulta: situacao + ordenacao por nome.
CREATE INDEX idx_aluno_situacao_nome
    ON aluno (situacao, nome);

-- 3. Consulta: intervalo por data e filtro adicional por situacao.
CREATE INDEX idx_avaliacao_data_situacao
    ON avaliacao (data_avaliacao, situacao);

-- 4. Atualiza estatisticas do otimizador. Comando especifico do MySQL.
ANALYZE TABLE matricula, aluno, avaliacao;

-- 5. Confirme a existencia, ordem e cardinalidade estimada.
SHOW INDEX FROM matricula
WHERE Key_name = 'idx_matricula_turma_situacao_data';

SHOW INDEX FROM aluno
WHERE Key_name = 'idx_aluno_situacao_nome';

SHOW INDEX FROM avaliacao
WHERE Key_name = 'idx_avaliacao_data_situacao';

-- 6. Repita o plano da consulta principal.
EXPLAIN
SELECT
    id_matricula,
    id_aluno,
    data_matricula
FROM matricula
WHERE id_turma = 1
  AND situacao = 'ATIVA'
ORDER BY data_matricula;

-- O indice composto pode atender aos filtros pelo prefixo esquerdo:
EXPLAIN
SELECT id_matricula, id_aluno
FROM matricula
WHERE id_turma = 1;

EXPLAIN
SELECT id_matricula, id_aluno
FROM matricula
WHERE id_turma = 1
  AND situacao = 'ATIVA';

-- Esta consulta ignora a primeira coluna do indice composto. O indice pode
-- deixar de ser util, dependendo das estatisticas e do custo estimado.
EXPLAIN
SELECT id_matricula, id_aluno
FROM matricula
WHERE situacao = 'ATIVA';

-- ============================================================================
-- LIMPEZA OPCIONAL
-- Remova os comentarios somente para desfazer o laboratorio.
-- DROP INDEX idx_matricula_turma_situacao_data ON matricula;
-- DROP INDEX idx_aluno_situacao_nome ON aluno;
-- DROP INDEX idx_avaliacao_data_situacao ON avaliacao;
-- ============================================================================

-- Observacao: DDL no MySQL provoca COMMIT implicito. ROLLBACK nao desfaz
-- CREATE INDEX ou DROP INDEX como desfaria uma alteracao DML transacional.
