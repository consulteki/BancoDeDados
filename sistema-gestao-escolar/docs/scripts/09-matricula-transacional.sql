-- Modulo 11 - Matricula transacional (MySQL 8+)
USE gestao_escolar;

START TRANSACTION;

-- Bloqueia a turma durante a verificacao de capacidade.
SELECT id_turma, capacidade, situacao
FROM turma
WHERE id_turma = 1
FOR UPDATE;

-- Confira vagas ativas antes de executar o INSERT.
SELECT
    t.capacidade,
    COUNT(m.id_matricula) AS ocupadas
FROM turma AS t
LEFT JOIN matricula AS m
    ON m.id_turma = t.id_turma
   AND m.situacao = 'ATIVA'
WHERE t.id_turma = 1
GROUP BY t.id_turma, t.capacidade;

-- Exemplo didatico com aluno 5, que ainda nao possui matricula ativa na turma 2.
INSERT INTO matricula (
    id_aluno, id_turma, data_matricula, situacao, forma_ingresso
)
SELECT 5, 2, CURRENT_DATE, 'ATIVA', 'INSCRICAO'
WHERE EXISTS (
    SELECT 1 FROM turma
    WHERE id_turma = 2 AND situacao IN ('ABERTA', 'EM_ANDAMENTO')
)
AND NOT EXISTS (
    SELECT 1 FROM matricula
    WHERE id_aluno = 5 AND id_turma = 2 AND situacao = 'ATIVA'
);

-- MySQL: ROW_COUNT() permite validar se uma linha foi criada.
SELECT ROW_COUNT() AS matriculas_criadas;

-- No laboratorio, desfaça para permitir repeticao.
ROLLBACK;

SELECT COUNT(*) AS deve_ser_zero
FROM matricula
WHERE id_aluno = 5 AND id_turma = 2 AND situacao = 'ATIVA';
