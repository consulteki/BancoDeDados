-- ============================================================================
-- Curso de Banco de Dados - Sistema de Gestao Escolar
-- Modulo 9: JOIN, agregacoes, GROUP BY, HAVING e subconsultas
-- SGBD alvo: MySQL Community 8.0+
-- Pre-requisito: executar os scripts ate 03-inserir-dados.sql
-- Todos os comandos deste arquivo sao somente leitura.
-- ============================================================================

USE gestao_escolar;

-- 1. INNER JOIN: alunos e suas matriculas.
-- Retorna somente linhas que possuem correspondencia nos dois lados.
SELECT
    a.matricula,
    a.nome AS aluno,
    m.id_turma,
    m.situacao AS situacao_matricula
FROM aluno AS a
INNER JOIN matricula AS m
    ON m.id_aluno = a.id_aluno
ORDER BY a.nome, m.id_turma;

-- 2. Relatorio atravessando cinco tabelas.
SELECT
    a.matricula,
    COALESCE(a.nome_social, a.nome) AS aluno,
    c.codigo AS curso,
    d.codigo AS disciplina,
    t.codigo AS turma,
    m.situacao AS situacao_matricula
FROM aluno AS a
INNER JOIN matricula AS m
    ON m.id_aluno = a.id_aluno
INNER JOIN turma AS t
    ON t.id_turma = m.id_turma
INNER JOIN disciplina AS d
    ON d.id_disciplina = t.id_disciplina
INNER JOIN curso AS c
    ON c.id_curso = d.id_curso
ORDER BY c.codigo, d.codigo, t.codigo, aluno;

-- 3. Professores alocados por turma, incluindo o papel.
SELECT
    d.nome AS disciplina,
    t.codigo AS turma,
    p.nome AS professor,
    tp.papel
FROM turma_professor AS tp
INNER JOIN turma AS t
    ON t.id_turma = tp.id_turma
INNER JOIN disciplina AS d
    ON d.id_disciplina = t.id_disciplina
INNER JOIN professor AS p
    ON p.id_professor = tp.id_professor
ORDER BY d.nome, t.codigo, tp.papel DESC, p.nome;

-- 4. LEFT JOIN: todas as avaliacoes, mesmo sem nota.
SELECT
    av.id_avaliacao,
    av.titulo,
    n.id_nota,
    n.valor
FROM avaliacao AS av
LEFT JOIN nota AS n
    ON n.id_avaliacao = av.id_avaliacao
ORDER BY av.id_avaliacao, n.id_nota;

-- 5. Avaliacoes que ainda nao possuem qualquer nota.
SELECT
    av.id_avaliacao,
    av.titulo,
    av.situacao
FROM avaliacao AS av
LEFT JOIN nota AS n
    ON n.id_avaliacao = av.id_avaliacao
WHERE n.id_nota IS NULL
ORDER BY av.id_avaliacao;

-- 6. Quantidade de matriculas por turma, incluindo turma sem matricula.
SELECT
    t.id_turma,
    d.nome AS disciplina,
    t.codigo AS turma,
    COUNT(m.id_matricula) AS quantidade_matriculas
FROM turma AS t
INNER JOIN disciplina AS d
    ON d.id_disciplina = t.id_disciplina
LEFT JOIN matricula AS m
    ON m.id_turma = t.id_turma
GROUP BY t.id_turma, d.nome, t.codigo
ORDER BY t.id_turma;

-- 7. Quantidade por situacao de matricula.
SELECT
    situacao,
    COUNT(*) AS quantidade
FROM matricula
GROUP BY situacao
ORDER BY situacao;

-- 8. Estatisticas de notas por avaliacao, preservando avaliacoes sem nota.
SELECT
    av.id_avaliacao,
    av.titulo,
    COUNT(n.id_nota) AS notas_lancadas,
    ROUND(AVG(n.valor), 2) AS media,
    MIN(n.valor) AS menor_nota,
    MAX(n.valor) AS maior_nota
FROM avaliacao AS av
LEFT JOIN nota AS n
    ON n.id_avaliacao = av.id_avaliacao
GROUP BY av.id_avaliacao, av.titulo
ORDER BY av.id_avaliacao;

-- 9. HAVING filtra grupos: turmas com pelo menos 3 matriculas ativas.
SELECT
    t.id_turma,
    d.nome AS disciplina,
    COUNT(m.id_matricula) AS matriculas_ativas
FROM turma AS t
INNER JOIN disciplina AS d
    ON d.id_disciplina = t.id_disciplina
LEFT JOIN matricula AS m
    ON m.id_turma = t.id_turma
   AND m.situacao = 'ATIVA'
GROUP BY t.id_turma, d.nome
HAVING COUNT(m.id_matricula) >= 3
ORDER BY matriculas_ativas DESC, t.id_turma;

-- 10. Alunos distintos por curso, incluindo curso sem matricula.
SELECT
    c.id_curso,
    c.nome AS curso,
    COUNT(DISTINCT m.id_aluno) AS alunos_distintos
FROM curso AS c
LEFT JOIN disciplina AS d
    ON d.id_curso = c.id_curso
LEFT JOIN turma AS t
    ON t.id_disciplina = d.id_disciplina
LEFT JOIN matricula AS m
    ON m.id_turma = t.id_turma
GROUP BY c.id_curso, c.nome
ORDER BY c.id_curso;

-- 11. Media por aluno, incluindo aluno sem nota.
SELECT
    a.id_aluno,
    COALESCE(a.nome_social, a.nome) AS aluno,
    COUNT(n.id_nota) AS notas_lancadas,
    ROUND(AVG(n.valor), 2) AS media
FROM aluno AS a
LEFT JOIN matricula AS m
    ON m.id_aluno = a.id_aluno
LEFT JOIN nota AS n
    ON n.id_matricula = m.id_matricula
GROUP BY a.id_aluno, a.nome_social, a.nome
ORDER BY a.id_aluno;

-- 12. Agregacao condicional com CASE.
SELECT
    t.id_turma,
    d.nome AS disciplina,
    COUNT(m.id_matricula) AS total,
    SUM(CASE WHEN m.situacao = 'ATIVA' THEN 1 ELSE 0 END) AS ativas,
    SUM(CASE WHEN m.situacao = 'CANCELADA' THEN 1 ELSE 0 END) AS canceladas
FROM turma AS t
INNER JOIN disciplina AS d
    ON d.id_disciplina = t.id_disciplina
LEFT JOIN matricula AS m
    ON m.id_turma = t.id_turma
GROUP BY t.id_turma, d.nome
ORDER BY t.id_turma;

-- 13. Subconsulta escalar: notas acima da media geral.
SELECT
    id_nota,
    id_matricula,
    valor
FROM nota
WHERE valor > (
    SELECT AVG(valor)
    FROM nota
)
ORDER BY valor DESC, id_nota;

-- 14. EXISTS: alunos com pelo menos uma matricula ativa.
SELECT
    a.id_aluno,
    a.matricula,
    a.nome
FROM aluno AS a
WHERE EXISTS (
    SELECT 1
    FROM matricula AS m
    WHERE m.id_aluno = a.id_aluno
      AND m.situacao = 'ATIVA'
)
ORDER BY a.id_aluno;

-- 15. NOT EXISTS: avaliacoes sem notas.
SELECT
    av.id_avaliacao,
    av.titulo
FROM avaliacao AS av
WHERE NOT EXISTS (
    SELECT 1
    FROM nota AS n
    WHERE n.id_avaliacao = av.id_avaliacao
)
ORDER BY av.id_avaliacao;

-- 16. Relatorio resumido sem multiplicar matriculas por avaliacoes.
-- As subconsultas agregam cada medida de forma independente.
SELECT
    t.id_turma,
    d.nome AS disciplina,
    (
        SELECT COUNT(*)
        FROM matricula AS m
        WHERE m.id_turma = t.id_turma
    ) AS matriculas,
    (
        SELECT COUNT(*)
        FROM avaliacao AS av
        WHERE av.id_turma = t.id_turma
    ) AS avaliacoes
FROM turma AS t
INNER JOIN disciplina AS d
    ON d.id_disciplina = t.id_disciplina
ORDER BY t.id_turma;

-- Exemplo incorreto: ligar matricula e avaliacao somente pela turma gera
-- uma linha para cada combinacao matricula x avaliacao e infla contagens.
-- Nao execute como relatorio final:
--
-- SELECT t.id_turma, COUNT(m.id_matricula), COUNT(av.id_avaliacao)
-- FROM turma t
-- JOIN matricula m ON m.id_turma = t.id_turma
-- JOIN avaliacao av ON av.id_turma = t.id_turma
-- GROUP BY t.id_turma;
