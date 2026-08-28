# Gabarito comentado — Módulo 5

> As dependências vêm das regras assumidas. Mudanças nas regras podem alterar chaves e decomposições.

## Parte A — Granularidade e chave

Granularidade:

> Uma tupla representa a nota de um aluno em uma avaliação de uma turma.

Chave candidata preliminar:

```text
(id_aluno, id_turma, id_avaliacao)
```

Com as dependências fornecidas, o fecho inclui dados do aluno, turma, disciplina, curso, matrícula, avaliação e nota. A minimalidade depende de:

- `id_avaliacao` ser global e determinar `id_turma`;
- existir uma matrícula por aluno/turma;
- avaliação pertencer a uma turma.

Se `id_avaliacao -> id_turma`, a chave pode ser reduzida a `(id_aluno,id_avaliacao)` para a relação de nota. O estudante deve perceber essa possibilidade e não repetir cegamente a chave proposta.

## Parte B — Dependências

```text
id_aluno -> matricula_aluno, nome_aluno
id_curso -> nome_curso
id_disciplina -> id_curso, codigo_disciplina, nome_disciplina, carga_horaria
id_turma -> id_disciplina, codigo_turma, periodo
(id_aluno,id_turma) -> data_matricula, situacao_matricula
id_avaliacao -> id_turma, titulo_avaliacao
(id_aluno,id_turma,id_avaliacao) -> nota
```

Aceitar chave diferente para Avaliação se o identificador for apenas local à turma.

## Parte C — Anomalias

### Inserção

- não cadastrar curso sem linha de nota;
- não cadastrar aluno antes de matrícula/avaliação.

### Atualização

- nome de aluno repetido pode divergir;
- nome/carga horária de disciplina pode ser atualizado parcialmente.

### Exclusão

- excluir última nota pode apagar avaliação;
- excluir última linha pode apagar turma/curso.

## Parte D — 1FN

A relação pode estar formalmente em 1FN se todos os valores forem atômicos. Uma lista de telefones viola a estrutura adotada e deve originar:

```text
ALUNO_TELEFONE(id_aluno PK/FK, telefone PK, tipo)
```

1FN não remove dependências parciais nem transitivas.

## Parte E — 2FN

Dependências parciais:

- `id_aluno -> dados do aluno`;
- `id_turma -> dados da turma`;
- `id_avaliacao -> dados da avaliação`;
- `(id_aluno,id_turma) -> dados da matrícula`.

Relações iniciais:

```text
ALUNO(...)
TURMA_ACADEMICA(...)
MATRICULA(...)
AVALIACAO(...)
NOTA(...)
```

Adicionar ID artificial não muda as dependências semânticas. Ocultar uma chave composta não elimina fatos misturados.

## Parte F — 3FN

Dependências transitivas em TURMA_ACADEMICA:

```text
id_turma -> id_disciplina
id_disciplina -> id_curso, dados_disciplina
id_curso -> nome_curso
```

Resultado:

```text
CURSO(id_curso PK, nome)

DISCIPLINA(
  id_disciplina PK,
  id_curso FK,
  codigo,
  nome,
  carga_horaria
)

TURMA(
  id_turma PK,
  id_disciplina FK,
  codigo,
  periodo
)

ALUNO(id_aluno PK, matricula UQ, nome)

MATRICULA(
  id_matricula PK,
  id_aluno FK,
  id_turma FK,
  data_matricula,
  situacao
)

AVALIACAO(
  id_avaliacao PK,
  id_turma FK,
  titulo
)

NOTA(
  id_nota PK,
  id_matricula FK,
  id_avaliacao FK,
  valor,
  UQ(id_matricula,id_avaliacao)
)
```

## Parte G — Sem perda e preservação

Exemplo TURMA/DISCIPLINA:

- atributo comum: `id_disciplina`;
- `id_disciplina` é chave de DISCIPLINA;
- junção por FK recompõe dados associados sem combinações espúrias.

Exemplo DISCIPLINA/CURSO:

- atributo comum: `id_curso`;
- `id_curso` é chave de CURSO.

As dependências principais ficam verificáveis em cada relação. A regra histórica de unicidade de Matrícula precisa ser especificada.

## Parte H — Casos

1. Chave simples: não viola 2FN por dependência parcial, mas pode violar 3FN.
2. 3FN não implica necessariamente BCNF.
3. BCNF implica 3FN.
4. Desnormalização cria redundância e deve ser justificada por medição.
5. Derivado pode ser armazenado por histórico, auditoria ou desempenho, com controle de consistência.
6. Acidental não possui governança; controlada possui finalidade, fonte, sincronização e monitoramento.

## Parte I — ALUNO_CONTATO

Perguntas esperadas:

- um aluno pode ter vários telefones?
- telefone possui tipo?
- “curso_aluno” representa curso atual, histórico ou matrícula?
- responsável é obrigatório?
- um responsável pode atender vários alunos?
- aluno pode ter vários responsáveis?
- quais dados são necessários e autorizados?

Possível decomposição:

```text
ALUNO(id_aluno PK, nome, email)

ALUNO_TELEFONE(
  id_aluno PK/FK,
  telefone PK,
  tipo
)

RESPONSAVEL(
  id_responsavel PK,
  nome
)

RESPONSAVEL_TELEFONE(
  id_responsavel PK/FK,
  telefone PK
)

ALUNO_RESPONSAVEL(
  id_aluno PK/FK,
  id_responsavel PK/FK,
  parentesco,
  responsavel_principal
)

CURSO(id_curso PK, nome)

MATRICULA_CURSO(
  id_matricula PK,
  id_aluno FK,
  id_curso FK,
  data_inicio,
  situacao
)
```

A solução depende das respostas.

## Rubrica

| Nível | Evidência |
|---|---|
| Excelente | dependências justificadas, fecho criticado, decomposição sem perda e resultado coerente |
| Satisfatório | chega à 3FN com pequenas lacunas |
| Insuficiente | divide tabelas sem dependências, perde chaves ou não explica anomalias |

## Sinais de atenção

- chave candidata não mínima;
- dependências inferidas apenas pela amostra;
- ID artificial usado como “solução” de normalização;
- decomposição sem FKs;
- ausência de teste de junção;
- perda de restrições de unicidade;
- 1FN confundida com “ter chave primária”;
- desnormalização proposta sem evidência.
