# Gabarito — Módulo 8

As consultas abaixo são uma solução possível.

```sql
USE gestao_escolar;

-- 1
SELECT matricula, nome, email
FROM aluno
ORDER BY nome ASC;

-- 2
SELECT id_aluno, matricula, nome
FROM aluno
WHERE nome LIKE 'C%'
ORDER BY nome;

-- 3
SELECT id_matricula, id_aluno, data_matricula, situacao
FROM matricula
WHERE id_turma = 1
  AND situacao = 'ATIVA'
ORDER BY data_matricula, id_matricula;

-- 4
SELECT id_avaliacao, titulo, data_avaliacao, situacao
FROM avaliacao
WHERE situacao IN ('ABERTA', 'PLANEJADA')
ORDER BY data_avaliacao, id_avaliacao;

-- 5
SELECT id_avaliacao, titulo, data_avaliacao
FROM avaliacao
WHERE data_avaliacao >= '2026-08-01'
  AND data_avaliacao < '2026-09-01'
ORDER BY data_avaliacao;

-- 6
SELECT id_aluno, matricula, nome
FROM aluno
WHERE nome_social IS NULL
ORDER BY nome;

-- 7
SELECT
    matricula,
    nome AS nome_civil,
    COALESCE(nome_social, nome) AS nome_exibicao
FROM aluno
ORDER BY nome_exibicao, id_aluno;

-- 8
SELECT DISTINCT situacao
FROM matricula
ORDER BY situacao;

-- 9
SELECT
    id_nota,
    valor,
    CASE
        WHEN valor >= 9 THEN 'DESTAQUE'
        WHEN valor >= 7 THEN 'SATISFATORIA'
        ELSE 'EM_RECUPERACAO'
    END AS classificacao
FROM nota
ORDER BY valor DESC, id_nota;

-- 10: sintaxe MySQL
SELECT id_aluno, matricula, nome
FROM aluno
ORDER BY id_aluno
LIMIT 2 OFFSET 2;

-- 11
SELECT id_avaliacao, titulo, situacao
FROM avaliacao
WHERE situacao IN ('ABERTA', 'PLANEJADA');
```

## Respostas conceituais

**12. NULL:** `NULL` representa informação desconhecida. A expressão `nome_social = NULL` resulta em desconhecido, não em verdadeiro. Use `IS NULL`.

**13. Ordenação:** uma tabela representa um conjunto sem ordem lógica. O plano de execução, índices ou alterações físicas podem mudar a sequência retornada. Somente `ORDER BY` expressa a ordem requerida.

**14. Portabilidade:** `SELECT`, `FROM`, `WHERE`, `AND`, `OR`, `IN`, `BETWEEN`, `LIKE`, `IS NULL`, `DISTINCT`, `COALESCE`, `CASE` e `ORDER BY` pertencem ao SQL padrão nos usos apresentados. `USE` e a paginação com `LIMIT ... OFFSET` são particularidades do MySQL neste curso.

## Desafio — exemplo

```sql
-- A: todas as turmas do período que estão abertas ou em andamento.
SELECT id_turma, codigo, periodo, situacao
FROM turma
WHERE periodo = '2026-2'
  AND (situacao = 'ABERTA' OR situacao = 'EM_ANDAMENTO');

-- B: turmas do período e abertas, além de qualquer turma em andamento.
SELECT id_turma, codigo, periodo, situacao
FROM turma
WHERE (periodo = '2026-2' AND situacao = 'ABERTA')
   OR situacao = 'EM_ANDAMENTO';
```

Com a carga atual, ambas podem coincidir porque todas as turmas são do mesmo período. A diferença lógica aparece quando existir uma turma `EM_ANDAMENTO` de outro período. Essa observação mostra por que um conjunto pequeno de teste nem sempre revela um erro de precedência.
