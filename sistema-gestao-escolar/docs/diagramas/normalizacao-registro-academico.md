# Normalização do registro acadêmico — exemplo de referência

## 1. Relação original

Granularidade: uma linha representa a nota de um aluno em uma avaliação de uma turma.

```text
REGISTRO_ACADEMICO(
  id_aluno,
  matricula_aluno,
  nome_aluno,
  id_turma,
  codigo_turma,
  periodo,
  id_disciplina,
  codigo_disciplina,
  nome_disciplina,
  carga_horaria_disciplina,
  id_curso,
  nome_curso,
  data_matricula,
  situacao_matricula,
  id_avaliacao,
  titulo_avaliacao,
  nota
)
```

Chave candidata preliminar:

```text
(id_aluno, id_turma, id_avaliacao)
```

## 2. Dependências consideradas

```text
id_aluno -> matricula_aluno, nome_aluno

id_curso -> nome_curso

id_disciplina ->
  id_curso,
  codigo_disciplina,
  nome_disciplina,
  carga_horaria_disciplina

id_turma ->
  id_disciplina,
  codigo_turma,
  periodo

(id_aluno, id_turma) ->
  data_matricula,
  situacao_matricula

id_avaliacao ->
  id_turma,
  titulo_avaliacao

(id_aluno, id_turma, id_avaliacao) -> nota
```

## 3. Anomalias

### Inserção

- curso não pode ser cadastrado sem uma linha acadêmica;
- disciplina não pode existir antes de turma e avaliação;
- aluno sem nota não aparece.

### Atualização

- nome de aluno repete-se em várias avaliações;
- nome do curso repete-se em várias disciplinas, turmas e notas;
- alteração parcial gera inconsistência.

### Exclusão

- apagar a última nota pode eliminar informação de avaliação;
- apagar a última matrícula pode eliminar a única ocorrência da turma;
- excluir linha acadêmica pode apagar informação cadastral.

## 4. Primeira Forma Normal

Assumindo valores atômicos e ausência de listas, a relação satisfaz formalmente a 1FN. Estar em 1FN não elimina redundância.

## 5. Segunda Forma Normal

Existem dependências de partes da chave composta:

- `id_aluno -> dados do aluno`;
- `id_turma -> dados da turma/disciplina/curso`;
- `id_avaliacao -> dados da avaliação`;
- `(id_aluno,id_turma) -> dados da matrícula`.

Decomposição:

```text
ALUNO(id_aluno PK, matricula_aluno UQ, nome_aluno)

MATRICULA(
  id_aluno PK/FK,
  id_turma PK/FK,
  data_matricula,
  situacao_matricula
)

AVALIACAO(
  id_avaliacao PK,
  id_turma,
  titulo_avaliacao
)

NOTA(
  id_aluno PK,
  id_turma PK,
  id_avaliacao PK,
  nota
)

TURMA_ACADEMICA(
  id_turma PK,
  codigo_turma,
  periodo,
  id_disciplina,
  codigo_disciplina,
  nome_disciplina,
  carga_horaria_disciplina,
  id_curso,
  nome_curso
)
```

TURMA_ACADEMICA ainda possui dependências transitivas.

## 6. Terceira Forma Normal

```text
id_turma -> id_disciplina
id_disciplina -> id_curso, codigo_disciplina, nome_disciplina, carga_horaria
id_curso -> nome_curso
```

Decomposição:

```text
CURSO(
  id_curso PK,
  nome_curso
)

DISCIPLINA(
  id_disciplina PK,
  id_curso FK -> CURSO.id_curso,
  codigo_disciplina,
  nome_disciplina,
  carga_horaria_disciplina
)

TURMA(
  id_turma PK,
  id_disciplina FK -> DISCIPLINA.id_disciplina,
  codigo_turma,
  periodo
)
```

## 7. Resultado completo

```text
ALUNO(id_aluno PK, matricula UQ, nome)

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
  UQ(id_matricula, id_avaliacao)
)
```

## 8. Rastreabilidade

| Dependência | Relação responsável |
|---|---|
| id_aluno -> dados do aluno | ALUNO |
| id_curso -> dados do curso | CURSO |
| id_disciplina -> dados da disciplina | DISCIPLINA |
| id_turma -> dados da turma | TURMA |
| aluno + turma -> dados da matrícula | MATRICULA e regra histórica |
| id_avaliacao -> dados da avaliação | AVALIACAO |
| matrícula + avaliação -> nota | NOTA |

## 9. Pontos de validação

- `id_avaliacao` é global?
- uma matrícula pode ser repetida para a mesma turma?
- a nota pode possuir versões?
- código de disciplina é único globalmente ou por curso?
- disciplina pertence a curso ou a matriz curricular?
- exclusão é física ou mudança de situação?

## 10. Conclusão

A decomposição elimina fatos misturados, reduz anomalias e converge com o modelo produzido semanticamente pelo MER. Isso não prova que todas as regras estejam completas; validação institucional continua necessária.
