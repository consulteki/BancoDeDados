# Atividade 08 — Consultas básicas do sistema escolar

## Cenário

A secretaria escolar precisa responder perguntas operacionais usando somente consultas de uma tabela por vez. Junções e agregações serão estudadas no próximo módulo.

## Preparação

Execute os scripts de criação e a carga `03-inserir-dados.sql`. Salve suas respostas em um novo arquivo `resposta-atividade-08.sql`; não altere a carga oficial.

## Tarefas

Escreva uma consulta para cada requisito:

1. listar matrícula, nome e e-mail de todos os alunos, em ordem alfabética;
2. listar alunos cujo nome começa com a letra `C`;
3. listar matrículas ativas da turma 1, ordenadas por data e ID;
4. listar avaliações abertas ou planejadas;
5. listar avaliações realizadas entre 1º de agosto e 31 de agosto de 2026;
6. localizar alunos que não possuem nome social;
7. exibir matrícula, nome civil e um `nome_exibicao`, priorizando o nome social;
8. listar as situações distintas existentes em `matricula`;
9. exibir notas em ordem decrescente e classificá-las como:
   - `DESTAQUE`: valor maior ou igual a 9;
   - `SATISFATORIA`: valor maior ou igual a 7 e menor que 9;
   - `EM_RECUPERACAO`: valor menor que 7;
10. retornar a segunda página de alunos, considerando duas linhas por página e ordem por `id_aluno`;
11. reescrever `situacao = 'ABERTA' OR situacao = 'PLANEJADA'` usando `IN`;
12. explicar por que `nome_social = NULL` está incorreto;
13. explicar por que uma consulta sem `ORDER BY` não garante a ordem;
14. identificar quais recursos usados são SQL padrão e qual recurso de paginação é específico do MySQL.

## Desafio

Produza duas consultas logicamente diferentes por causa dos parênteses, usando `AND` e `OR`. Explique em linguagem natural quais linhas cada uma pretende selecionar antes de executá-las.

## Critérios de avaliação

| Critério | Pontos |
|---|---:|
| Projeção e aliases adequados | 1,5 |
| Filtros corretos | 2,0 |
| Tratamento de NULL | 1,5 |
| Ordenação determinística | 1,0 |
| DISTINCT, COALESCE e CASE | 2,0 |
| Paginação e portabilidade | 1,0 |
| Justificativas conceituais | 1,0 |
| **Total** | **10,0** |

> Use somente dados fictícios e inclua comentários SQL numerando as respostas.
