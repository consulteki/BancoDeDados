# Atividade 05 — Normalização do registro acadêmico

## Objetivo

Analisar uma relação escolar com múltiplos fatos, identificar dependências e anomalias e decompô-la até a 3FN.

## Parte A — Granularidade e chave

Use a relação REGISTRO_ACADEMICO apresentada no módulo.

1. Declare o significado de uma tupla.
2. Proponha chave candidata.
3. Justifique unicidade e minimalidade.
4. Calcule o fecho da chave usando as dependências fornecidas.
5. Registre hipóteses que podem alterar a chave.

## Parte B — Dependências funcionais

Para cada grupo de atributos, escreva as dependências:

- dados do aluno;
- dados do curso;
- dados da disciplina;
- dados da turma;
- dados da matrícula;
- dados da avaliação;
- nota.

Para cada dependência, indique:

- determinante;
- atributos determinados;
- origem da regra;
- situação: validada ou hipótese;
- exemplo de violação.

## Parte C — Anomalias

Apresente pelo menos:

- duas anomalias de inserção;
- duas de atualização;
- duas de exclusão.

Explique qual redundância permite cada problema.

## Parte D — Primeira Forma Normal

1. A relação está em 1FN?
2. O que mudaria se `telefones_aluno` contivesse lista separada por vírgulas?
3. Como mapear o atributo multivalorado?
4. Por que 1FN não elimina todas as anomalias?

## Parte E — Segunda Forma Normal

1. Identifique atributos que dependem apenas de parte da chave.
2. Separe as relações necessárias.
3. Defina PKs e FKs.
4. Indique quais dependências permanecem problemáticas.
5. Explique por que adicionar um ID artificial não corrige automaticamente a violação.

## Parte F — Terceira Forma Normal

1. Identifique dependências transitivas.
2. Decomponha as relações.
3. Defina PKs, FKs e chaves alternativas.
4. Apresente o esquema final.
5. Compare com o esquema lógico do Módulo 4.

## Parte G — Sem perda e preservação

Para duas decomposições realizadas:

- identifique os atributos comuns;
- explique por que a junção é sem perda;
- indique onde cada dependência pode ser verificada;
- registre dependência que exija atenção adicional.

## Parte H — Casos para análise

Responda:

1. Relação com chave simples pode violar 2FN?
2. 3FN implica BCNF?
3. BCNF implica 3FN?
4. Por que desnormalização deve ocorrer depois de medição?
5. Em que situação um dado derivado pode ser armazenado?
6. Qual é a diferença entre redundância acidental e controlada?

## Parte I — Novo cenário

Normalize:

```text
ALUNO_CONTATO(
  id_aluno,
  nome_aluno,
  curso_aluno,
  telefones,
  email,
  nome_responsavel,
  telefone_responsavel
)
```

Antes de decompor, liste perguntas necessárias. Não assuma que todo aluno possui responsável nem que um responsável pertence a um único aluno.

## Entrega

```text
sistema-gestao-escolar/atividades/modulo-05/normalizacao-seu-nome.md
sistema-gestao-escolar/docs/diagramas/esquema-3fn-seu-nome.md
```

Versionamento:

```bash
git status
git diff
git add sistema-gestao-escolar/atividades/modulo-05/
git add sistema-gestao-escolar/docs/diagramas/
git commit -m "docs: normaliza modelo escolar ate a terceira forma normal"
git push -u origin atividade/modulo-05-seu-nome
```

## Critérios

| Critério | Peso |
|---|---:|
| Granularidade, chave e fecho | 15% |
| Dependências funcionais | 20% |
| Anomalias | 10% |
| 1FN | 10% |
| 2FN | 15% |
| 3FN | 15% |
| Sem perda e preservação | 10% |
| Organização e Git | 5% |
