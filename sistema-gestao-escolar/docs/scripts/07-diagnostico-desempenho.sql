-- ============================================================================
-- Curso de Banco de Dados - Sistema de Gestao Escolar
-- Modulo 10: diagnostico de desempenho
-- SGBD alvo: MySQL Community 8.0+
-- Pre-requisito: executar os scripts ate 03-inserir-dados.sql
-- Este arquivo nao cria nem remove indices.
-- ============================================================================

USE gestao_escolar;

-- 1. Conhecer o volume antes de interpretar o plano.
SELECT 'aluno' AS tabela, COUNT(*) AS linhas FROM aluno
UNION ALL
SELECT 'matricula', COUNT(*) FROM matricula
UNION ALL
SELECT 'avaliacao', COUNT(*) FROM avaliacao
UNION ALL
SELECT 'nota', COUNT(*) FROM nota;

-- 2. Inventario de indices. SHOW INDEX e especifico do MySQL.
SHOW INDEX FROM aluno;
SHOW INDEX FROM matricula;
SHOW INDEX FROM avaliacao;
SHOW INDEX FROM nota;

-- 3. Filtro que pode se beneficiar de indice composto:
-- igualdade nas duas primeiras colunas e ordenacao pela terceira.
EXPLAIN
SELECT
    id_matricula,
    id_aluno,
    data_matricula
FROM matricula
WHERE id_turma = 1
  AND situacao = 'ATIVA'
ORDER BY data_matricula;

-- 4. Pesquisa por situacao e nome.
EXPLAIN
SELECT
    id_aluno,
    matricula,
    nome
FROM aluno
WHERE situacao = 'ATIVO'
ORDER BY nome;

-- 5. Intervalo de datas seguido de filtro de situacao.
EXPLAIN
SELECT
    id_avaliacao,
    titulo,
    data_avaliacao,
    situacao
FROM avaliacao
WHERE data_avaliacao >= '2026-08-01'
  AND data_avaliacao < '2026-09-01'
  AND situacao IN ('ABERTA', 'ENCERRADA')
ORDER BY data_avaliacao;

-- 6. Junção e agregação do relatório de notas.
EXPLAIN
SELECT
    av.id_avaliacao,
    av.titulo,
    COUNT(n.id_nota) AS quantidade,
    AVG(n.valor) AS media
FROM avaliacao AS av
LEFT JOIN nota AS n
    ON n.id_avaliacao = av.id_avaliacao
GROUP BY av.id_avaliacao, av.titulo
ORDER BY av.id_avaliacao;

-- 7. Exemplo sargable: a coluna nao e envolvida por funcao.
EXPLAIN
SELECT id_avaliacao, titulo, data_avaliacao
FROM avaliacao
WHERE data_avaliacao >= '2026-08-01'
  AND data_avaliacao < '2026-09-01';

-- 8. Exemplo potencialmente nao sargable: YEAR() atua sobre a coluna.
-- YEAR() e especifico do MySQL. Compare o plano com a consulta anterior.
EXPLAIN
SELECT id_avaliacao, titulo, data_avaliacao
FROM avaliacao
WHERE YEAR(data_avaliacao) = 2026
  AND MONTH(data_avaliacao) = 8;

-- 9. MySQL 8.0.18+: EXPLAIN ANALYZE executa a consulta e mede o plano real.
-- Execute conscientemente. Esta consulta e somente leitura.
EXPLAIN ANALYZE
SELECT
    id_matricula,
    id_aluno,
    data_matricula
FROM matricula
WHERE id_turma = 1
  AND situacao = 'ATIVA'
ORDER BY data_matricula;

-- Depois de executar 08-criar-indices-laboratorio.sql, repita as consultas
-- 3, 4, 5 e 9 e registre as diferencas.
