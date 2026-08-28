# Curso guiado de Banco de Dados

## Projeto integrador

O curso utiliza a construção incremental de um **Sistema de Gestão Escolar** para integrar modelagem, SQL, MySQL, Vanilla JavaScript, Node.js, Sequelize e Prisma.

- Carga horária da formação principal: 60 horas
- Organização principal: 15 encontros de 4 horas
- Trilha complementar sugerida: 3 módulos adicionais, com 12 horas
- SGBD: MySQL Community
- Ferramenta administrativa: MySQL Workbench
- Linguagem SQL: construções ANSI sempre que possível
- Versionamento: Git e GitHub
- ORM principal: Sequelize
- ORM comparativo: Prisma

## Organização do percurso

Os módulos 1 a 15 constituem a formação principal de 60 horas. O Módulo 15 encerra formalmente esse percurso com integração, revisão e considerações finais.

Os módulos 16 a 18 formam a **Trilha Complementar de Aprofundamento e Projeto Profissional**: conteúdos adicionais orientados à aplicação integrada dos conhecimentos em um projeto com arquitetura, ferramentas e práticas contemporâneas adotadas no mercado de trabalho.

A trilha complementar pode ser oferecida como projeto de extensão, oficina, atividade extraclasse, desafio de portfólio ou preparação para estágio e primeiro emprego. Ela não integra as 60 horas obrigatórias.

## Formação principal — 60 horas

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
| 10 | Índices, desempenho e planos de execução | Experimento com EXPLAIN |
| 11 | Transações, concorrência e integridade | Matrícula transacional |
| 12 | Vanilla JavaScript | CRUD com dados simulados |
| 13 | Node.js, Express, HTTP e acesso seguro ao MySQL | API REST inicial |
| 14 | Sequelize, migrations e persistência | API integrada ao banco |
| 15 | Integração, revisão e considerações finais | Síntese da formação de 60 horas |

## Trilha Complementar de Aprofundamento e Projeto Profissional

| Módulo | Tema | Produto profissional |
|---:|---|---|
| 16 | Prisma e arquitetura moderna de persistência | Comparação Sequelize × Prisma |
| 17 | Qualidade, segurança e operação profissional | Testes, Docker, OpenAPI, backup e observabilidade |
| 18 | Projeto profissional e portfólio | Sistema documentado, reproduzível e demonstrável |

### Finalidade dos módulos complementares

- aproximar o protótipo didático de um produto de software;
- apresentar ferramentas e práticas atuais do mercado;
- fortalecer portfólio e empregabilidade;
- desenvolver autonomia para avaliar tecnologias;
- consolidar documentação, testes, segurança e operação;
- preparar uma demonstração técnica profissional.

## Módulos publicados

- [Módulo 1 — Fundamentos e análise do domínio](modulo-01-fundamentos/README.md)
- [Módulo 2 — Entidades, atributos, identificadores e regras](modulo-02-entidades-atributos/README.md)
- [Módulo 3 — Modelo Entidade-Relacionamento e cardinalidades](modulo-03-modelo-entidade-relacionamento/README.md)
- [Módulo 4 — Modelo relacional e mapeamento do MER](modulo-04-modelo-relacional/README.md)
- [Módulo 5 — Normalização, dependências funcionais e anomalias](modulo-05-normalizacao/README.md)
- [Módulo 6 — DDL e construção física no MySQL](modulo-06-ddl-mysql/README.md)
- [Módulo 7 — Manipulação de dados com DML](modulo-07-dml-dados/README.md)
- [Módulo 8 — Consultas SQL básicas](modulo-08-consultas-sql/README.md)
- [Módulo 9 — Junções, agregações e relatórios escolares](modulo-09-joins-agregacoes/README.md)
- [Módulo 10 — Índices, desempenho e planos de execução](modulo-10-indices-desempenho/README.md)

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
- `tests/`: testes introduzidos na etapa de profissionalização.

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

A conclusão do Módulo 15 certifica pedagogicamente o encerramento da formação principal. Os módulos 16 a 18 representam continuidade opcional orientada à profissionalização e à construção de portfólio.
