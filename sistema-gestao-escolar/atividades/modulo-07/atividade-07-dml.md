# Atividade 07 — DML no sistema escolar

## Cenário

A escola abrirá uma turma piloto e precisa cadastrar os envolvidos, corrigir um contato e cancelar uma matrícula sem apagar seu histórico.

## Preparação

Execute os scripts `01-criar-banco.sql`, `02-criar-tabelas.sql` e `03-inserir-dados.sql`. Faça toda a atividade entre `START TRANSACTION` e `ROLLBACK`.

## Tarefas

1. Cadastre um aluno fictício com matrícula `20260020`, situação `ATIVO` e os demais dados válidos.
2. Consulte o aluno pela matrícula para comprovar a inserção.
3. Atualize somente o e-mail desse aluno.
4. Cadastre-o na turma de ID 1 com situação `ATIVA`. Não informe manualmente o ID da matrícula.
5. Consulte a matrícula criada, exibindo seu ID, o nome do aluno e o código da turma.
6. Cancele a matrícula criada: altere a situação para `CANCELADA` e preencha `data_cancelamento`.
7. Tente explicar, sem executar, por que `DELETE FROM aluno WHERE matricula = '20260020'` falharia nesse momento.
8. Escreva o comando que excluiria primeiro a matrícula criada e depois o aluno. Execute apenas dentro da transação.
9. Finalize com `ROLLBACK` e comprove que o aluno não existe mais.
10. Classifique como SQL ANSI/portável ou específico do MySQL cada recurso usado: `CURRENT_DATE`, `LAST_INSERT_ID()`, `ROW_COUNT()` e `USE`.

## Critérios de avaliação

| Critério | Pontos |
|---|---:|
| Inserções com lista explícita de colunas | 2,0 |
| Filtros seguros em UPDATE e DELETE | 2,0 |
| Respeito às FKs e à ordem pai/filho | 2,0 |
| Cancelamento coerente com a restrição da matrícula | 1,5 |
| Uso correto de transação e ROLLBACK | 1,5 |
| Classificação de portabilidade | 1,0 |
| **Total** | **10,0** |

> Use apenas dados fictícios. Não copie informações pessoais reais para o repositório.
