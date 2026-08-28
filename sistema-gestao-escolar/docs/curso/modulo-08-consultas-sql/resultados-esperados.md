# Resultados esperados das consultas

Este guia permite conferir as consultas sobre a carga de dados do Módulo 7. Ele não substitui a execução no MySQL Workbench.

| Consulta | Resultado esperado |
|---:|---|
| 1 | 5 alunos |
| 4 | 5 alunos ativos |
| 5 | somente o curso `WEB-BE-200` |
| 6 | 4 matrículas ativas na turma 1 |
| 7 | 3 turmas |
| 8 | 3 avaliações abertas ou planejadas |
| 9 | 2 avaliações em agosto de 2026 |
| 10 | `Ana Souza` |
| 11 | disciplina `BD-060` |
| 12 | somente `Camila Alves`, cujo nome social é `Cami Alves` |
| 14 | situações `ATIVA` e `CANCELADA` |
| 16 | 5 linhas; Camila é exibida como `Cami Alves` |
| 17 | 7 notas classificadas |
| 18 | alunos de IDs 1, 2 e 3 |
| 19 | alunos de IDs 3 e 4 |
| 20 | as mesmas 2 avaliações de agosto |

## Diagnóstico de divergências

Se o resultado for diferente:

1. confirme que está conectado ao schema `gestao_escolar`;
2. verifique se a carga `03-inserir-dados.sql` terminou com `COMMIT`;
3. confirme que o laboratório do Módulo 7 terminou com `ROLLBACK`;
4. recrie a base caso tenha persistido alterações durante exercícios;
5. execute uma consulta por vez e leia mensagens de erro e quantidade de linhas.

A ordem das linhas só é garantida quando a consulta contém `ORDER BY`.
