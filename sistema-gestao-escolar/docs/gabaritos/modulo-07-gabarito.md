# Gabarito — Módulo 7

Uma solução possível é apresentada abaixo. Os dados são fictícios.

```sql
USE gestao_escolar;

START TRANSACTION;

INSERT INTO aluno (
    matricula,
    nome,
    data_nascimento,
    email,
    telefone,
    data_ingresso,
    situacao
) VALUES (
    '20260020',
    'Aluna Piloto',
    '2006-02-14',
    'piloto@example.test',
    '11970000020',
    CURRENT_DATE,
    'ATIVO'
);

SELECT id, matricula, nome, email
FROM aluno
WHERE matricula = '20260020';

UPDATE aluno
SET email = 'piloto.atualizado@example.test'
WHERE matricula = '20260020';

INSERT INTO matricula (
    aluno_id,
    turma_id,
    data_matricula,
    situacao,
    data_cancelamento
)
SELECT
    a.id,
    1,
    CURRENT_DATE,
    'ATIVA',
    NULL
FROM aluno AS a
WHERE a.matricula = '20260020';

SELECT
    m.id,
    a.nome AS aluno,
    t.codigo AS turma,
    m.situacao
FROM matricula AS m
JOIN aluno AS a ON a.id = m.aluno_id
JOIN turma AS t ON t.id = m.turma_id
WHERE a.matricula = '20260020'
  AND t.id = 1;

UPDATE matricula
SET situacao = 'CANCELADA',
    data_cancelamento = CURRENT_DATE
WHERE aluno_id = (
    SELECT id
    FROM aluno
    WHERE matricula = '20260020'
)
AND turma_id = 1;

-- A exclusão do aluno falharia enquanto a matrícula o referenciar,
-- pois a FK usa ON DELETE RESTRICT.

DELETE FROM matricula
WHERE aluno_id = (
    SELECT id
    FROM aluno
    WHERE matricula = '20260020'
)
AND turma_id = 1;

DELETE FROM aluno
WHERE matricula = '20260020';

ROLLBACK;

SELECT COUNT(*) AS aluno_apos_rollback
FROM aluno
WHERE matricula = '20260020';
```

## Observações

- A inserção da matrícula usa `INSERT ... SELECT`, evitando depender de um ID conhecido.
- O cancelamento preenche a data porque a restrição exige coerência entre situação e `data_cancelamento`.
- Primeiro excluímos o filho (`matricula`) e depois o pai (`aluno`).
- Depois do `ROLLBACK`, a contagem final deve ser zero porque o aluno não existia antes da transação.

## Portabilidade

| Recurso | Classificação |
|---|---|
| `CURRENT_DATE` | SQL padrão |
| `LAST_INSERT_ID()` | Específico do MySQL |
| `ROW_COUNT()` | Específico do MySQL |
| `USE` | Comando específico do ecossistema MySQL nesta forma |

Uma solução que usa `LAST_INSERT_ID()` para guardar o ID do aluno também é válida no MySQL, desde que explique a perda de portabilidade.
