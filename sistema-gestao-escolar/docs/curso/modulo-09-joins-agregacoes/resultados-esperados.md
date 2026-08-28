# Resultados esperados dos relatórios

Os valores abaixo pressupõem a carga original de `03-inserir-dados.sql`.

| Consulta | Verificação principal |
|---:|---|
| 1 | 8 vínculos aluno–matrícula |
| 2 | 8 linhas; todas pertencem ao curso `WEB-BE-200` |
| 3 | 4 alocações: 3 responsáveis e 1 colaborador |
| 4 | 9 linhas: 7 notas e 2 avaliações sem nota |
| 5 | avaliações 2 e 4 |
| 6 | turma 1 = 5; turma 2 = 3; turma 3 = 0 |
| 7 | `ATIVA` = 7; `CANCELADA` = 1 |
| 8 | avaliação 1: média 7,80; avaliação 3: média 8,17; avaliações 2 e 4: média nula |
| 9 | turma 1 = 4 ativas; turma 2 = 3 ativas |
| 10 | curso 1 = 5 alunos distintos; curso 2 = 0 |
| 11 | Ana = 8,25; Bruno = 7,25; Cami = 9,10; Diego = 6,50; Elisa = nulo |
| 12 | turma 1: total 5, ativas 4, canceladas 1; turma 2: 3/3/0; turma 3: 0/0/0 |
| 13 | 4 notas acima da média geral: 9,20; 9,00; 8,50; 8,00 |
| 14 | alunos 1, 2, 3 e 4 |
| 15 | avaliações 2 e 4 |
| 16 | turma 1: 5 matrículas e 2 avaliações; turma 2: 3 e 2; turma 3: 0 e 0 |

## Pontos de atenção

- `COUNT(*)` em uma junção externa conta a linha preservada, mesmo sem correspondência. Para contar filhos, use uma coluna não nula da tabela filha, como `COUNT(m.id_matricula)`.
- `AVG`, `MIN` e `MAX` ignoram valores nulos; sem valores, retornam `NULL`.
- Um aluno com várias matrículas deve ser contado com `COUNT(DISTINCT m.id_aluno)` quando a métrica representar pessoas.
- Mudanças persistidas durante exercícios alteram os resultados. Recarregue a base se necessário.
