# Atividade 01 — Diagnóstico do domínio escolar

## Contexto

Uma escola utiliza planilhas independentes para controlar alunos, cursos, turmas, professores, notas e frequência. Os arquivos apresentam duplicidades, divergências e dificuldade para gerar relatórios.

## Objetivo

Produzir um diagnóstico inicial do domínio antes da criação do banco de dados.

## Orientações

1. Leia o Módulo 1.
2. Não crie tabelas nesta atividade.
3. Descreva o problema em termos do funcionamento da escola.
4. Diferencie necessidade do usuário e solução técnica.
5. Registre dúvidas quando uma regra não estiver clara.

## Parte A — Conceitos

Responda com suas palavras:

1. Qual é a diferença entre dado e informação?
2. Qual é a diferença entre banco de dados e SGBD?
3. Qual é a função do MySQL Workbench?
4. Diferencie esquema e instância.
5. Apresente três exemplos de metadados do cadastro de aluno.
6. Por que persistência é importante?
7. O que pode acontecer quando dados são repetidos sem controle?

## Parte B — Atores

Identifique pelo menos quatro atores. Para cada um, informe:

| Ator | Responsabilidade | Dados consultados | Dados alterados |
|---|---|---|---|

## Parte C — Requisitos

Escreva:

- pelo menos cinco requisitos funcionais;
- pelo menos três requisitos não funcionais;
- pelo menos cinco regras de negócio;
- pelo menos três dúvidas que devem ser validadas com a escola.

Use identificadores:

```text
RF01 — ...
RNF01 — ...
RN01 — ...
DV01 — ...
```

## Parte D — Cenário de matrícula

Descreva o fluxo de matrícula desde a identificação do aluno até a confirmação. Indique:

- dados de entrada;
- validações;
- resultado esperado;
- situações de erro;
- dados que precisam ser persistidos.

## Parte E — Reflexão

Explique por que seria inadequado:

1. conectar o navegador diretamente ao banco;
2. armazenar todos os dados escolares em uma tabela;
3. guardar senhas no código;
4. excluir uma turma sem verificar matrículas, notas e frequência;
5. iniciar a implementação sem validar as regras.

## Entrega

Crie:

```text
sistema-gestao-escolar/atividades/modulo-01/resposta-seu-nome.md
```

Inclua identificação, respostas e conclusão. Depois:

```bash
git status
git diff
git add sistema-gestao-escolar/atividades/modulo-01/
git commit -m "docs: conclui diagnostico do dominio escolar"
git push -u origin atividade/modulo-01-seu-nome
```

Abra um Pull Request para revisão.

## Critérios

- correção conceitual;
- aderência ao domínio escolar;
- separação entre requisitos e soluções;
- clareza das regras;
- completude do fluxo de matrícula;
- organização do Markdown;
- uso adequado do Git.
