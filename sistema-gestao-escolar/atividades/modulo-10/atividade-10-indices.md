# Atividade 10 — Índices e planos de execução

## Cenário

A secretaria relata que a consulta de matrículas ativas por turma poderá ficar lenta quando a escola crescer. Sua tarefa é investigar e propor uma melhoria justificável.

## Preparação

Recrie a base, execute a carga original e não crie índices antes de registrar o plano inicial.

## Tarefas

1. Liste os índices existentes em `matricula`, `aluno` e `avaliacao`.
2. Identifique quais foram originados por PK, UNIQUE ou FK.
3. Execute `EXPLAIN` para a consulta:
   ```sql
   SELECT id_matricula, id_aluno, data_matricula
   FROM matricula
   WHERE id_turma = 1
     AND situacao = 'ATIVA'
   ORDER BY data_matricula;
   ```
4. Registre `type`, `possible_keys`, `key`, `rows` e `Extra`.
5. Proponha a ordem de um índice composto e justifique cada coluna.
6. Crie o índice com um nome descritivo.
7. Atualize as estatísticas e repita o plano.
8. Explique por que o índice pode não ser escolhido na carga atual.
9. Compare:
   - filtro por `id_turma`;
   - filtro por `id_turma` e `situacao`;
   - filtro apenas por `situacao`.
10. Reescreva uma consulta com `YEAR(data_avaliacao)` como intervalo sargable.
11. Explique dois custos de manter índices.
12. Identifique um índice redundante hipotético no esquema e justifique por que não deveria ser criado automaticamente.
13. Remova apenas o índice criado por você e confirme a remoção.

## Desafio

Escolha um relatório do Módulo 9, registre seu plano e proponha um índice. A recomendação pode ser “não criar índice”, desde que seja sustentada por:

- consulta e frequência estimada;
- volume esperado;
- índice já existente;
- plano observado;
- benefício e custo;
- estratégia de validação em produção.

## Critérios de avaliação

| Critério | Pontos |
|---|---:|
| Inventário e identificação dos índices | 1,5 |
| Plano antes e depois | 2,0 |
| Justificativa do índice composto | 2,0 |
| Prefixo esquerdo e sargabilidade | 1,5 |
| Análise crítica do otimizador | 1,5 |
| Custos, limpeza e documentação | 1,5 |
| **Total** | **10,0** |

> Não remova índices de PK, UNIQUE ou FK. Limite a limpeza aos índices criados no laboratório.
