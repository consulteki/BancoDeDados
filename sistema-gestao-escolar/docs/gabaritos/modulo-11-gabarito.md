# Gabarito — Módulo 11

A solução deve manter uma conexão e delimitar toda a operação:

```sql
START TRANSACTION;

SELECT id_turma, capacidade, situacao
FROM turma WHERE id_turma = 2 FOR UPDATE;

SAVEPOINT turma_validada;

INSERT INTO matricula (
  id_aluno, id_turma, data_matricula, situacao, forma_ingresso
)
SELECT 5, 2, CURRENT_DATE, 'ATIVA', 'INSCRICAO'
WHERE EXISTS (
  SELECT 1 FROM turma
  WHERE id_turma = 2 AND situacao IN ('ABERTA','EM_ANDAMENTO')
)
AND NOT EXISTS (
  SELECT 1 FROM matricula
  WHERE id_aluno = 5 AND id_turma = 2 AND situacao = 'ATIVA'
);

SELECT ROW_COUNT() AS criadas;
ROLLBACK TO SAVEPOINT turma_validada;
ROLLBACK;
```

A política da API deve repetir apenas erros transitórios conhecidos, com limite de tentativas, atraso curto e operação idempotente. Erros de validação não devem ser repetidos. A ordem de bloqueio deve ser estável para reduzir deadlocks.
