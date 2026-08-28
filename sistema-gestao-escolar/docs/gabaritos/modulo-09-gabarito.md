# Gabarito — Módulo 9

## Consultas

```sql
USE gestao_escolar;

-- 1
SELECT
    a.matricula,
    COALESCE(a.nome_social, a.nome) AS aluno,
    d.nome AS disciplina,
    t.codigo AS turma,
    m.situacao
FROM aluno AS a
JOIN matricula AS m ON m.id_aluno = a.id_aluno
JOIN turma AS t ON t.id_turma = m.id_turma
JOIN disciplina AS d ON d.id_disciplina = t.id_disciplina
ORDER BY disciplina, turma, aluno;

-- 2
SELECT
    t.id_turma,
    d.nome AS disciplina,
    t.codigo AS turma,
    p.nome AS professor_responsavel
FROM turma AS t
JOIN disciplina AS d ON d.id_disciplina = t.id_disciplina
JOIN turma_professor AS tp
    ON tp.id_turma = t.id_turma
   AND tp.papel = 'RESPONSAVEL'
JOIN professor AS p ON p.id_professor = tp.id_professor
ORDER BY t.id_turma;

-- 3
SELECT
    av.id_avaliacao,
    av.titulo,
    COUNT(n.id_nota) AS notas_lancadas
FROM avaliacao AS av
LEFT JOIN nota AS n ON n.id_avaliacao = av.id_avaliacao
GROUP BY av.id_avaliacao, av.titulo
ORDER BY av.id_avaliacao;

-- 4A
SELECT av.id_avaliacao, av.titulo
FROM avaliacao AS av
LEFT JOIN nota AS n ON n.id_avaliacao = av.id_avaliacao
WHERE n.id_nota IS NULL
ORDER BY av.id_avaliacao;

-- 4B
SELECT av.id_avaliacao, av.titulo
FROM avaliacao AS av
WHERE NOT EXISTS (
    SELECT 1
    FROM nota AS n
    WHERE n.id_avaliacao = av.id_avaliacao
)
ORDER BY av.id_avaliacao;

-- 5
SELECT
    av.id_avaliacao,
    av.titulo,
    COUNT(n.id_nota) AS quantidade,
    ROUND(AVG(n.valor), 2) AS media,
    MIN(n.valor) AS menor,
    MAX(n.valor) AS maior
FROM avaliacao AS av
LEFT JOIN nota AS n ON n.id_avaliacao = av.id_avaliacao
GROUP BY av.id_avaliacao, av.titulo
ORDER BY av.id_avaliacao;

-- 6
SELECT
    t.id_turma,
    COUNT(m.id_matricula) AS matriculas_ativas
FROM turma AS t
LEFT JOIN matricula AS m
    ON m.id_turma = t.id_turma
   AND m.situacao = 'ATIVA'
GROUP BY t.id_turma
HAVING COUNT(m.id_matricula) >= 3
ORDER BY t.id_turma;

-- 7
SELECT
    t.id_turma,
    COUNT(m.id_matricula) AS total,
    SUM(CASE WHEN m.situacao = 'ATIVA' THEN 1 ELSE 0 END) AS ativas,
    SUM(CASE WHEN m.situacao = 'CANCELADA' THEN 1 ELSE 0 END) AS canceladas
FROM turma AS t
LEFT JOIN matricula AS m ON m.id_turma = t.id_turma
GROUP BY t.id_turma
ORDER BY t.id_turma;

-- 8
SELECT
    a.id_aluno,
    COALESCE(a.nome_social, a.nome) AS aluno,
    COUNT(n.id_nota) AS quantidade_notas,
    ROUND(AVG(n.valor), 2) AS media
FROM aluno AS a
LEFT JOIN matricula AS m ON m.id_aluno = a.id_aluno
LEFT JOIN nota AS n ON n.id_matricula = m.id_matricula
GROUP BY a.id_aluno, a.nome_social, a.nome
ORDER BY a.id_aluno;

-- 9
SELECT
    c.id_curso,
    c.nome,
    COUNT(DISTINCT m.id_aluno) AS alunos
FROM curso AS c
LEFT JOIN disciplina AS d ON d.id_curso = c.id_curso
LEFT JOIN turma AS t ON t.id_disciplina = d.id_disciplina
LEFT JOIN matricula AS m ON m.id_turma = t.id_turma
GROUP BY c.id_curso, c.nome
ORDER BY c.id_curso;

-- 10
SELECT id_nota, id_matricula, valor
FROM nota
WHERE valor > (SELECT AVG(valor) FROM nota)
ORDER BY valor DESC, id_nota;

-- 13: diagnostico; turma 1 produz 10 combinacoes e turma 2 produz 6.
SELECT
    t.id_turma,
    m.id_matricula,
    av.id_avaliacao
FROM turma AS t
JOIN matricula AS m ON m.id_turma = t.id_turma
JOIN avaliacao AS av ON av.id_turma = t.id_turma
ORDER BY t.id_turma, m.id_matricula, av.id_avaliacao;

-- 14
SELECT
    t.id_turma,
    (SELECT COUNT(*)
     FROM matricula AS m
     WHERE m.id_turma = t.id_turma) AS matriculas,
    (SELECT COUNT(*)
     FROM avaliacao AS av
     WHERE av.id_turma = t.id_turma) AS avaliacoes
FROM turma AS t
ORDER BY t.id_turma;
```

## Respostas conceituais

**11. COUNT em LEFT JOIN:** a junção preserva a turma e preenche as colunas da matrícula com `NULL`. `COUNT(*)` conta essa linha preservada. `COUNT(m.id_matricula)` ignora o nulo e retorna zero.

**12. ON e WHERE:** a condição no `ON` limita as matrículas correspondentes, mas preserva todas as turmas. No `WHERE`, a condição rejeita a linha nula produzida para uma turma sem matrícula ativa, eliminando-a do resultado.

## Desafio — solução com subconsultas

```sql
SELECT
    d.id_disciplina,
    d.codigo,
    d.nome,
    (SELECT COUNT(*)
     FROM turma AS t
     WHERE t.id_disciplina = d.id_disciplina) AS quantidade_turmas,
    (SELECT COUNT(DISTINCT m.id_aluno)
     FROM turma AS t
     JOIN matricula AS m ON m.id_turma = t.id_turma
     WHERE t.id_disciplina = d.id_disciplina) AS alunos_distintos,
    (SELECT COUNT(*)
     FROM turma AS t
     JOIN avaliacao AS av ON av.id_turma = t.id_turma
     WHERE t.id_disciplina = d.id_disciplina) AS avaliacoes,
    (SELECT ROUND(AVG(n.valor), 2)
     FROM turma AS t
     JOIN avaliacao AS av ON av.id_turma = t.id_turma
     JOIN nota AS n ON n.id_avaliacao = av.id_avaliacao
     WHERE t.id_disciplina = d.id_disciplina) AS media_notas
FROM disciplina AS d
ORDER BY d.id_disciplina;
```

Cada métrica é calculada na sua própria granularidade. Isso evita o produto entre matrículas, avaliações e notas.
