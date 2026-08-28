# Curso guiado de Banco de Dados

## Projeto integrador

O curso utiliza a construção incremental de um **Sistema de Gestão Escolar** para integrar modelagem, SQL, MySQL, Vanilla JavaScript, Node.js, Sequelize e Prisma.

- Carga horária: 60 horas
- Organização: 15 encontros de 4 horas
- SGBD: MySQL Community
- Ferramenta administrativa: MySQL Workbench
- Linguagem SQL: construções ANSI sempre que possível
- Versionamento: Git e GitHub
- ORM principal: Sequelize
- ORM comparativo: Prisma

## Trilha de aprendizagem

| Módulo | Tema | Produto principal |
|---:|---|---|
| 1 | Fundamentos e análise do problema | Mapa inicial do domínio escolar |
| 2 | Entidades, atributos e regras | Catálogo de entidades |
| 3 | Modelo entidade-relacionamento | Diagrama conceitual |
| 4 | Modelo relacional | Esquema lógico |
| 5 | Normalização | Relações em 3FN |
| 6 | DDL | Estrutura física no MySQL |
| 7 | DML | Dados consistentes de teste |
| 8 | Consultas SQL | Consultas básicas |
| 9 | Junções e agregações | Relatórios escolares |
| 10 | Integridade e transações | Matrícula transacional |
| 11 | Vanilla JavaScript | CRUD com dados simulados |
| 12 | Node.js, Express e HTTP | API REST inicial |
| 13 | Sequelize | Persistência principal |
| 14 | Prisma e integração | Laboratório comparativo |
| 15 | Projeto final | Sistema integrado e apresentação |

## Módulos publicados

- [Módulo 1 — Fundamentos e análise do domínio](modulo-01-fundamentos/README.md)
- [Módulo 2 — Entidades, atributos, identificadores e regras](modulo-02-entidades-atributos/README.md)
- [Módulo 3 — Modelo Entidade-Relacionamento e cardinalidades](modulo-03-modelo-entidade-relacionamento/README.md)
- [Módulo 4 — Modelo relacional e mapeamento do MER](modulo-04-modelo-relacional/README.md)
- [Módulo 5 — Normalização, dependências funcionais e anomalias](modulo-05-normalizacao/README.md)
- [Módulo 6 — DDL e construção física no MySQL](modulo-06-ddl-mysql/README.md)

## Estrutura de cada módulo

Cada módulo apresenta:

1. objetivos de aprendizagem;
2. conhecimentos prévios;
3. conceitos essenciais;
4. aplicação no domínio escolar;
5. exemplo guiado;
6. comandos ou procedimentos;
7. prática acompanhada;
8. exercício individual;
9. desafio;
10. erros frequentes;
11. checklist de aprendizagem;
12. critérios de avaliação;
13. referências;
14. ligação para o gabarito do professor.

## Organização dos artefatos

- `docs/curso/`: unidades didáticas.
- `docs/scripts/`: scripts SQL executáveis.
- `docs/diagramas/`: modelos e diagramas.
- `docs/gabaritos/`: respostas comentadas.
- `atividades/`: enunciados entregáveis.
- `src/frontend/`: HTML, CSS e Vanilla JavaScript.
- `src/backend/`: Node.js, Express e ORMs.

## Fluxo recomendado para o estudante

```bash
git switch main
git pull origin main
git switch -c atividade/modulo-01-seu-nome

# desenvolver e conferir os arquivos
git status
git diff

git add .
git commit -m "docs: conclui atividade do modulo 01"
git push -u origin atividade/modulo-01-seu-nome
```

Após o envio, o estudante abre um Pull Request e descreve:

- o que foi realizado;
- decisões tomadas;
- dúvidas restantes;
- evidências de execução;
- arquivos entregues.

## Convenção de commits

| Prefixo | Uso |
|---|---|
| `docs` | documentação e respostas conceituais |
| `feat` | nova funcionalidade |
| `fix` | correção |
| `test` | testes |
| `refactor` | reorganização sem alterar comportamento |
| `chore` | configuração e manutenção |

## Critério de conclusão

Um módulo é considerado concluído quando o estudante:

- estudou os conceitos;
- executou a prática guiada;
- produziu o artefato solicitado;
- respondeu às questões;
- conferiu o checklist;
- realizou o commit;
- submeteu a entrega para revisão.
