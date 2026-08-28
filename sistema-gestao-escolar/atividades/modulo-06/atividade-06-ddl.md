# Atividade 06 — DDL e validação estrutural

## Objetivo

Executar, inspecionar e testar a implementação física inicial do Sistema de Gestão Escolar no MySQL 8.

## Parte A — Preparação

Registre:

- versão do MySQL;
- versão do Workbench;
- sistema operacional;
- data;
- modo de execução: Workbench ou CLI.

Não registre senha.

## Parte B — Execução

Execute:

1. `00-criar-banco.sql`;
2. `01-criar-tabelas.sql`;
3. `02-verificar-estrutura.sql`.

Informe:

- banco selecionado;
- quantidade de tabelas;
- nomes das tabelas;
- engine;
- collation;
- erros e correções.

## Parte C — Leitura do DDL

Para três tabelas, documente:

| Tabela | PK | Chaves alternativas | FKs | CHECKs | Nulos relevantes |
|---|---|---|---|---|---|
| | | | | | |

## Parte D — Portabilidade

Classifique:

| Recurso | ANSI/amplamente portável | Específico/variável no MySQL | Estratégia em outro SGBD |
|---|---|---|---|
| PRIMARY KEY | | | |
| FOREIGN KEY | | | |
| AUTO_INCREMENT | | | |
| ENGINE=InnoDB | | | |
| utf8mb4_0900_ai_ci | | | |
| CHECK | | | |
| CURRENT_TIMESTAMP | | | |
| SHOW CREATE TABLE | | | |

## Parte E — Testes negativos

Execute testes que devem falhar:

1. Curso com carga horária `-10`.
2. Aluno com situação `PENDENTE`.
3. Turma com capacidade zero.
4. Disciplina para Curso inexistente.
5. Nota negativa.
6. Duas Notas para a mesma Matrícula/Avaliação.

Para cada teste:

- SQL executado;
- constraint esperada;
- mensagem recebida;
- interpretação;
- estado do banco após o teste.

Não desative constraints.

## Parte F — Análise

Responda:

1. Por que `AUTO_INCREMENT` reduz portabilidade?
2. Por que CPF, telefone e matrícula não devem ser numéricos por padrão?
3. Por que o projeto evita `ENUM`?
4. Por que as constraints são nomeadas?
5. Por que foi usado `RESTRICT` em lugar de `CASCADE`?
6. Por que a regra nota <= valor_maximo não está em `CHECK`?
7. Como tratar “uma matrícula ativa por aluno/turma” mantendo histórico?
8. O que significa commit implícito de DDL no MySQL?

## Parte G — ALTER TABLE seguro

Proponha, sem executar no banco oficial, um ALTER para adicionar `descricao` a Curso.

Inclua:

- SQL de alteração;
- efeito sobre linhas existentes;
- nulidade;
- valor padrão;
- plano de reversão;
- impacto em documentação, API e ORM.

## Entrega

```text
sistema-gestao-escolar/atividades/modulo-06/evidencias-seu-nome.md
sistema-gestao-escolar/atividades/modulo-06/respostas-seu-nome.md
```

Versionamento:

```bash
git status
git diff
git add sistema-gestao-escolar/atividades/modulo-06/
git commit -m "test: valida criacao fisica do banco escolar"
git push -u origin atividade/modulo-06-seu-nome
```

## Critérios

| Critério | Peso |
|---|---:|
| Execução e evidências | 20% |
| Leitura estrutural | 15% |
| Portabilidade | 15% |
| Testes negativos | 25% |
| Análise técnica | 15% |
| ALTER seguro | 5% |
| Git e organização | 5% |
