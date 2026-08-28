# Atividade 09 — Relatórios escolares

## Cenário

A coordenação escolar precisa de relatórios que combinem cadastros, matrículas, turmas, avaliações e notas. As consultas devem preservar registros sem filhos quando o requisito solicitar.

## Preparação

Execute os scripts até `03-inserir-dados.sql`. Salve as respostas em `resposta-atividade-09.sql`, numeradas com comentários.

## Tarefas

1. Liste matrícula, nome de exibição do aluno, disciplina, turma e situação da matrícula.
2. Liste cada turma com seu professor responsável. Não inclua colaboradores.
3. Liste todas as avaliações e a quantidade de notas lançadas, incluindo avaliações com zero notas.
4. Liste somente as avaliações sem nenhuma nota de duas formas:
   - `LEFT JOIN ... IS NULL`;
   - `NOT EXISTS`.
5. Calcule, por avaliação, quantidade, média, menor e maior nota.
6. Liste turmas com pelo menos três matrículas ativas.
7. Apresente, por turma, total de matrículas, quantidade ativa e quantidade cancelada.
8. Calcule a média de notas por aluno, incluindo alunos sem nota.
9. Conte alunos distintos por curso, incluindo cursos sem alunos.
10. Liste notas superiores à média geral.
11. Explique por que `COUNT(*)` pode retornar 1 para uma turma sem matrícula em um `LEFT JOIN`.
12. Explique a diferença entre colocar `m.situacao = 'ATIVA'` no `ON` e no `WHERE`.
13. Demonstre, com uma consulta diagnóstica, a multiplicação de linhas ao unir matrículas e avaliações pela turma. Não use essa consulta como relatório final.
14. Produza a versão correta que informe, por turma, a quantidade de matrículas e avaliações.

## Desafio

Crie um relatório por disciplina contendo:

- código e nome da disciplina;
- quantidade de turmas;
- quantidade de alunos distintos;
- quantidade de avaliações;
- média das notas.

O relatório deve incluir disciplinas sem turma e evitar métricas infladas. Você pode usar subconsultas correlacionadas ou agregações prévias.

## Critérios de avaliação

| Critério | Pontos |
|---|---:|
| Junções e condições ON corretas | 2,0 |
| Preservação de linhas com LEFT JOIN | 1,5 |
| Agregações e GROUP BY | 2,0 |
| WHERE e HAVING | 1,0 |
| Subconsultas e EXISTS | 1,0 |
| Controle da granularidade | 1,5 |
| Portabilidade, legibilidade e comentários | 1,0 |
| **Total** | **10,0** |

> Use apenas dados fictícios. Antes de agregar, execute uma versão que permita observar as linhas combinadas.
