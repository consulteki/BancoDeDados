# Módulo 5 — Normalização, dependências funcionais e anomalias

## Dados da unidade

- Duração sugerida: 4 horas
- Pré-requisitos: Módulos 1 a 4
- Produto principal: relatório de normalização até a Terceira Forma Normal
- Nível: modelo lógico
- Estratégia: decomposição orientada por dependências funcionais e regras do domínio

## 1. Objetivos de aprendizagem

Ao concluir esta unidade, o estudante deverá ser capaz de:

- explicar a finalidade da normalização;
- reconhecer anomalias de inserção, atualização e exclusão;
- identificar dependências funcionais;
- diferenciar dependência total, parcial e transitiva;
- determinar chaves candidatas com apoio de dependências;
- verificar Primeira, Segunda e Terceira Formas Normais;
- decompor uma relação preservando significado;
- avaliar junção sem perda e preservação de dependências;
- reconhecer quando desnormalização é uma decisão posterior e controlada;
- documentar cada etapa do processo.

## 2. Por que normalizar

Normalização é um processo de organização do esquema relacional para reduzir redundância inadequada e anomalias, preservando dependências e significado.

Ela não consiste simplesmente em “criar muitas tabelas”. O processo deve responder:

- quais fatos estão misturados?
- de que atributos cada fato depende?
- qual é a chave?
- quais atualizações podem gerar inconsistência?
- a decomposição permite reconstruir os dados corretamente?
- as regras importantes continuam verificáveis?

## 3. Relação problemática de partida

Considere:

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

Chave candidata preliminar para uma linha de nota:

```text
(id_aluno, id_turma, id_avaliacao)
```

A relação mistura fatos sobre:

- aluno;
- curso;
- disciplina;
- turma;
- matrícula;
- avaliação;
- nota.

## 4. Anomalias

### 4.1 Anomalia de inserção

Não é possível cadastrar um Curso sem inventar Aluno, Turma, Matrícula e Avaliação, caso todos os fatos estejam na mesma relação.

### 4.2 Anomalia de atualização

O nome do Curso aparece em várias linhas. Alterá-lo em apenas parte das linhas cria versões conflitantes.

### 4.3 Anomalia de exclusão

Excluir a última nota de uma Turma pode remover também os únicos registros da Turma, Disciplina ou Curso.

### 4.4 Redundância

Nome do aluno, nome do curso e dados da disciplina repetem-se para cada avaliação. A repetição amplia custo e risco de inconsistência.

## 5. Dependência funcional

Uma dependência funcional `X -> Y` significa que, em toda instância válida, valores iguais de X determinam valores iguais de Y.

Exemplo:

```text
id_aluno -> matricula_aluno, nome_aluno
```

Se duas tuplas possuem o mesmo `id_aluno`, devem possuir a mesma matrícula e o mesmo nome, conforme a regra considerada.

A dependência deriva da semântica do domínio, não de coincidência nos dados atuais.

### 5.1 Determinante

Em `X -> Y`, X é o determinante.

### 5.2 Dependência trivial

É trivial quando Y está contido em X.

```text
(id_aluno, id_turma) -> id_aluno
```

### 5.3 Dependência não trivial

Y não está contido em X.

```text
id_aluno -> nome_aluno
```

## 6. Conjunto preliminar de dependências

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

Essas dependências são hipóteses. Se `id_avaliacao` não for global, sua chave pode incluir `id_turma`.

## 7. Fecho de atributos

O fecho de X, representado por `X+`, é o conjunto de atributos determinados por X usando as dependências.

Uso:

- verificar se X é superchave;
- testar chaves candidatas;
- entender dependências transitivas.

Procedimento:

1. iniciar `X+` com X;
2. aplicar dependências cujo lado esquerdo esteja contido no fecho;
3. adicionar os atributos determinados;
4. repetir até não haver mudança.

Se `X+` contém todos os atributos da relação, X é superchave.

## 8. Dependência total, parcial e transitiva

### 8.1 Dependência total

Y depende do conjunto inteiro da chave composta e não de uma parte.

```text
(id_aluno, id_turma) -> data_matricula
```

Se nenhum dos atributos isolados determina a data, a dependência é total.

### 8.2 Dependência parcial

Um atributo não-chave depende de apenas parte de uma chave composta.

Para chave `(id_aluno, id_turma, id_avaliacao)`:

```text
id_aluno -> nome_aluno
```

Nome depende de parte da chave.

### 8.3 Dependência transitiva

A chave determina X e X determina Y, sendo Y atributo não-chave.

```text
id_turma -> id_disciplina
id_disciplina -> nome_disciplina
```

Logo, dados da disciplina dependem transitivamente de `id_turma`.

## 9. Primeira Forma Normal — 1FN

Uma relação está em 1FN quando:

- cada atributo possui valores atômicos segundo a finalidade;
- não existem grupos repetitivos;
- cada posição representa um valor do domínio.

Violação:

```text
ALUNO(id_aluno, nome, telefones)
telefones = "62999990000;62988880000"
```

Decomposição:

```text
ALUNO(id_aluno PK, nome, ...)
ALUNO_TELEFONE(id_aluno PK/FK, telefone PK, tipo)
```

Atomicidade depende do uso. Um endereço pode ser um texto único em um contexto e composto em outro.

## 10. Segunda Forma Normal — 2FN

Uma relação está em 2FN quando:

1. está em 1FN;
2. todo atributo não-primo depende totalmente de cada chave candidata.

2FN é especialmente relevante quando há chave candidata composta.

Na relação problemática, `nome_aluno` depende apenas de `id_aluno`, parte da chave. Dados da Turma dependem de `id_turma`, e dados da Avaliação dependem de `id_avaliacao`.

Decomposição inicial:

```text
ALUNO(id_aluno PK, matricula_aluno UQ, nome_aluno)

TURMA(
  id_turma PK,
  id_disciplina,
  codigo_turma,
  periodo
)

AVALIACAO(
  id_avaliacao PK,
  id_turma,
  titulo_avaliacao
)

MATRICULA(
  id_aluno PK/FK,
  id_turma PK/FK,
  data_matricula,
  situacao_matricula
)

NOTA(
  id_aluno PK,
  id_turma PK,
  id_avaliacao PK,
  nota
)
```

Ainda podem existir dependências transitivas.

## 11. Terceira Forma Normal — 3FN

Uma relação está em 3FN quando:

1. está em 2FN;
2. atributos não-chave não dependem transitivamente de chave por meio de outro atributo não-chave.

Forma formal: para toda dependência não trivial `X -> A`, X é superchave ou A é atributo primo.

Exemplo de violação:

```text
TURMA(id_turma, id_disciplina, nome_disciplina)
```

```text
id_turma -> id_disciplina
id_disciplina -> nome_disciplina
```

Decomposição:

```text
TURMA(id_turma PK, id_disciplina FK, ...)
DISCIPLINA(id_disciplina PK, nome_disciplina, ...)
```

## 12. Resultado de referência em 3FN

```text
ALUNO(
  id_aluno PK,
  matricula UQ,
  nome
)

CURSO(
  id_curso PK,
  nome
)

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
  situacao,
  UQ conforme regra histórica
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

O resultado converge com o mapeamento do MER. Isso é uma forma de validação cruzada: análise semântica e dependências levam a estruturas coerentes.

## 13. Forma Normal de Boyce-Codd — BCNF

Introdução:

Uma relação está em BCNF quando todo determinante de dependência funcional não trivial é superchave.

BCNF é mais restritiva que 3FN. Neste curso, o objetivo obrigatório é 3FN; BCNF será usada para análise adicional, não como decomposição automática.

## 14. Decomposição sem perda

Uma decomposição deve permitir reconstruir a relação original por junções naturais sem criar combinações espúrias.

Para decompor R em R1 e R2, uma condição suficiente é que a interseção determine R1 ou R2.

Exemplo coerente:

```text
ALUNO(id_aluno, nome)
MATRICULA(id_matricula, id_aluno, ...)
```

O atributo compartilhado `id_aluno` é chave de ALUNO.

## 15. Preservação de dependências

Uma decomposição preserva dependências quando as regras podem ser verificadas nas relações decompostas sem reconstruir toda a relação por junção.

Nem toda decomposição em BCNF preserva todas as dependências. Por isso, não se normaliza de forma cega.

## 16. Normalização e desempenho

Normalização prioriza consistência e manutenção. Desnormalização é uma decisão física posterior, fundamentada em:

- medição;
- perfil de consultas;
- custo de junções;
- requisitos de disponibilidade;
- estratégia de sincronização;
- responsabilidade pela consistência.

Não se desnormaliza “porque JOIN é lento” sem evidência.

## 17. Procedimento sistemático

1. Definir a relação e a granularidade de cada tupla.
2. Listar atributos.
3. Identificar chaves candidatas.
4. Levantar dependências a partir das regras.
5. Verificar 1FN.
6. Identificar dependências parciais.
7. Decompor para 2FN.
8. Identificar dependências transitivas.
9. Decompor para 3FN.
10. Definir PKs, FKs e unicidades.
11. Verificar junção sem perda.
12. Avaliar preservação de dependências.
13. Comparar com MER e requisitos.
14. Documentar dúvidas e decisões.

Use a [planilha de dependências e normalização](roteiro-normalizacao.md).

## 18. Prática guiada

### Etapa 1 — Branch

```bash
git switch main
git pull origin main
git switch -c atividade/modulo-05-seu-nome
```

### Etapa 2 — Relação não normalizada

Copie a relação REGISTRO_ACADEMICO e declare a granularidade:

> Uma tupla representa a nota de um aluno, em uma avaliação, dentro de uma matrícula/turma.

### Etapa 3 — Anomalias

Registre pelo menos duas anomalias de cada tipo.

### Etapa 4 — Dependências

Liste determinantes e atributos determinados. Marque hipóteses.

### Etapa 5 — Chave

Calcule o fecho da chave candidata proposta e revise minimalidade.

### Etapa 6 — Formas normais

Documente:

- situação inicial;
- violação;
- decomposição;
- relação resultante;
- chave;
- dependências preservadas.

### Etapa 7 — Verificação

Confira:

- junção sem perda;
- dependências;
- rastreabilidade;
- coerência com o MER.

### Etapa 8 — Versionar

```bash
git status
git diff
git add sistema-gestao-escolar/atividades/modulo-05/
git add sistema-gestao-escolar/docs/diagramas/
git commit -m "docs: normaliza modelo escolar ate a terceira forma normal"
git push -u origin atividade/modulo-05-seu-nome
```

## 19. Exercício individual

- [Atividade 05 — Normalização do registro acadêmico](../../../atividades/modulo-05/atividade-05-normalizacao.md)

## 20. Desafio

Analise:

1. uma relação com chave simples pode violar 2FN?
2. toda tabela com ID artificial está automaticamente em 2FN?
3. adicionar ID substituto corrige dependências parciais?
4. uma relação pode estar em 3FN e não em BCNF?
5. toda decomposição reduz risco sem criar custo?
6. quando uma redundância pode ser controlada e intencional?

## 21. Erros frequentes

- normalizar sem declarar granularidade;
- inferir dependências apenas pelos dados atuais;
- confundir repetição visual com dependência;
- criar ID artificial e declarar 2FN automaticamente;
- decompor sem definir PK/FK;
- perder regra de unicidade;
- produzir junções espúrias;
- ignorar dependências não preservadas;
- tratar 3FN como “uma tabela para cada assunto”;
- desnormalizar sem medição.

## 22. Checklist

- [ ] identifico anomalias;
- [ ] escrevo dependências funcionais;
- [ ] determino determinantes;
- [ ] calculo fecho básico;
- [ ] justifico chave candidata;
- [ ] verifico 1FN;
- [ ] reconheço dependência parcial;
- [ ] reconheço dependência transitiva;
- [ ] decomponho até 3FN;
- [ ] defino chaves e referências;
- [ ] verifico junção sem perda;
- [ ] avalio preservação de dependências;
- [ ] comparo o resultado com o MER;
- [ ] documento hipóteses.

## 23. Critérios de avaliação

| Critério | Peso |
|---|---:|
| Anomalias e granularidade | 15% |
| Dependências funcionais | 20% |
| Chaves e fechos | 15% |
| 1FN e 2FN | 15% |
| 3FN | 15% |
| Sem perda e preservação | 10% |
| Documentação e Git | 10% |

## 24. Referências

- CODD, E. F. Further Normalization of the Data Base Relational Model. 1971.
- RAMAKRISHNAN, R.; GEHRKE, J. *Sistemas de gerenciamento de bancos de dados*. McGraw-Hill, 2008.
- SILBERSCHATZ, A.; KORTH, H. F.; SUDARSHAN, S. *Sistema de banco de dados*. Elsevier, 2012.

## 25. Material do professor

- [Gabarito comentado do Módulo 5](../../gabaritos/modulo-05-gabarito.md)
