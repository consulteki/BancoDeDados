# Atividade 03 — Modelo conceitual do Sistema de Gestão Escolar

## Objetivo

Construir e justificar um Modelo Entidade-Relacionamento a partir do catálogo de entidades e das regras de negócio.

## Parte A — Conceitos

Responda:

1. Qual é a diferença entre MER e DER?
2. Por que o modelo conceitual deve evitar detalhes específicos do MySQL?
3. Diferencie cardinalidade mínima e máxima.
4. O que significa participação opcional?
5. Quando um relacionamento N:N deve ser transformado conceitualmente em entidade associativa?
6. O que é relacionamento recursivo?
7. Por que a amostra atual de dados não é suficiente para definir cardinalidade?

## Parte B — Matriz de cardinalidades

Preencha a matriz do módulo para:

- Curso–Disciplina;
- Disciplina–Turma;
- Professor–Turma;
- Aluno–Matrícula;
- Turma–Matrícula;
- Turma–Avaliação;
- Matrícula–Nota;
- Avaliação–Nota.

Para cada relacionamento:

- determine mínimo e máximo dos dois lados;
- escreva a leitura bidirecional;
- cite a regra utilizada;
- marque hipótese ou regra validada;
- registre pelo menos uma pergunta relevante.

## Parte C — Modelo em Mermaid

Crie um DER que contenha, no mínimo:

- Aluno;
- Professor;
- Curso;
- Disciplina;
- Turma;
- Matrícula;
- Avaliação;
- Nota.

Requisitos:

- nomes singulares;
- identificadores destacados;
- pelo menos três atributos por entidade;
- relacionamentos nomeados;
- cardinalidades mínima e máxima;
- Matrícula representada como entidade associativa;
- uma seção com dúvidas pendentes.

## Parte D — Leitura do modelo

Escolha cinco relacionamentos e leia cada um nos dois sentidos.

Modelo:

```text
REL01 — Aluno/Matrícula
Aluno: ...
Matrícula: ...
Regra que justifica: ...
```

## Parte E — Análise crítica

Responda:

1. Curso–Disciplina é necessariamente 1:N?
2. Professor–Turma pode ser N:N? Quais atributos poderiam pertencer ao vínculo?
3. Nota deveria ser atributo de Matrícula ou vínculo entre Matrícula e Avaliação?
4. Como representar pré-requisitos de Disciplina?
5. Como o modelo muda se o estudante puder refazer a mesma turma?
6. Frequência deve se relacionar a Matrícula, Turma, Aula ou Data? O que falta saber?

## Parte F — Detecção de erros

Explique o problema:

1. `ALUNO ||--|| MATRICULA` quando um aluno pode ter histórico de várias matrículas.
2. Relacionamento “possui” sem definição da regra.
3. Entidade chamada `TELA_CADASTRO_ALUNO`.
4. Atributo `idade` sem discussão de derivação.
5. Cardinalidade definida porque “na planilha só apareceu um caso”.
6. DER conceitual contendo `VARCHAR(150)`, `AUTO_INCREMENT` e `ENGINE=InnoDB`.

## Entrega

Arquivos:

```text
sistema-gestao-escolar/docs/diagramas/der-conceitual-seu-nome.md
sistema-gestao-escolar/atividades/modulo-03/matriz-seu-nome.md
sistema-gestao-escolar/atividades/modulo-03/respostas-seu-nome.md
```

Versionamento:

```bash
git status
git diff
git add sistema-gestao-escolar/docs/diagramas/
git add sistema-gestao-escolar/atividades/modulo-03/
git commit -m "docs: modela relacionamentos e cardinalidades"
git push -u origin atividade/modulo-03-seu-nome
```

Abra um Pull Request com:

- imagem renderizada ou confirmação de renderização do Mermaid;
- regras adotadas;
- hipóteses;
- dúvidas que precisam de validação.

## Critérios

| Critério | Peso |
|---|---:|
| Fundamentos conceituais | 15% |
| Matriz de cardinalidades | 25% |
| DER e notação | 30% |
| Leituras bidirecionais | 10% |
| Análise crítica | 10% |
| Organização e Git | 10% |
