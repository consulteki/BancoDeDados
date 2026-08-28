# Atividade 04 — Conversão para o modelo relacional

## Objetivo

Converter o DER do Sistema de Gestão Escolar em esquema lógico relacional, preservando cardinalidades, identificadores e regras.

## Parte A — Fundamentos

Responda:

1. Diferencie relação, tupla, atributo e domínio.
2. Diferencie grau e cardinalidade de uma relação.
3. Diferencie superchave, chave candidata, primária e alternativa.
4. O que é chave estrangeira?
5. Por que uma chave substituta não elimina chaves de negócio?
6. Explique integridade de entidade, referência e domínio.
7. Por que valor nulo não deve ter vários significados?

## Parte B — Entidades fortes

Mapeie:

- Aluno;
- Professor;
- Curso;
- Disciplina;
- Turma;
- Avaliação.

Para cada relação, informe:

- atributos;
- PK;
- chaves candidatas;
- chave alternativa;
- atributos obrigatórios;
- domínios preliminares;
- atributos derivados que não serão armazenados.

## Parte C — Relacionamentos

Mapeie e justifique:

1. Curso–Disciplina;
2. Disciplina–Turma;
3. Aluno–Matrícula;
4. Turma–Matrícula;
5. Professor–Turma;
6. Turma–Avaliação;
7. Matrícula–Nota;
8. Avaliação–Nota.

Registre onde ficará cada FK e quais relações associativas serão criadas.

## Parte D — Casos especiais

Apresente solução lógica para:

- vários telefones por aluno;
- pré-requisitos de disciplina;
- alocação histórica de professor;
- rematrícula do aluno na mesma turma;
- nota retificada com histórico;
- unidade organizacional com hierarquia.

## Parte E — Nulidade

Analise se deve permitir nulo:

| Relação | Atributo | Permite? | Significado | Justificativa |
|---|---|---|---|---|
| ALUNO | nome_social | | | |
| ALUNO | data_nascimento | | | |
| TURMA | data_fim | | | |
| TURMA_PROFESSOR | data_fim | | | |
| MATRICULA | data_cancelamento | | | |
| AVALIACAO | data_avaliacao | | | |

Não invente valores padrão para substituir ausência.

## Parte F — Esquema final

Produza o esquema em notação textual:

```text
RELACAO(
  atributo PK,
  atributo FK -> OUTRA_RELACAO.atributo,
  atributo UQ,
  atributo
)
```

Inclua uma seção de restrições e outra de decisões ainda pendentes.

## Parte G — Rastreabilidade

Preencha o roteiro do módulo ligando:

- requisito/regra;
- elemento do MER;
- relação ou restrição lógica;
- justificativa.

## Parte H — Detecção de problemas

Explique:

1. relação sem PK;
2. FK no lado 1 de um relacionamento 1:N sem justificativa;
3. Professor e Turma mantidos em N:N sem relação intermediária;
4. `telefone1`, `telefone2`, `telefone3`;
5. idade armazenada junto com data de nascimento;
6. chave substituta sem unicidade de matrícula;
7. coluna `situacao` aceitando qualquer texto;
8. uso de `0` para representar data desconhecida.

## Entrega

Arquivos:

```text
sistema-gestao-escolar/docs/diagramas/esquema-logico-seu-nome.md
sistema-gestao-escolar/atividades/modulo-04/mapeamento-seu-nome.md
sistema-gestao-escolar/atividades/modulo-04/respostas-seu-nome.md
```

Versionamento:

```bash
git status
git diff
git add sistema-gestao-escolar/docs/diagramas/
git add sistema-gestao-escolar/atividades/modulo-04/
git commit -m "docs: converte modelo conceitual em relacional"
git push -u origin atividade/modulo-04-seu-nome
```

## Critérios

| Critério | Peso |
|---|---:|
| Fundamentos | 15% |
| Mapeamento de entidades | 20% |
| Chaves e integridade | 20% |
| Mapeamento de relacionamentos | 20% |
| Casos especiais e nulidade | 10% |
| Rastreabilidade | 10% |
| Organização e Git | 5% |
