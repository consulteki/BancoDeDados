# Módulo 4 — Modelo relacional e mapeamento do MER

## Dados da unidade

- Duração sugerida: 4 horas
- Pré-requisitos: Módulos 1, 2 e 3
- Produto principal: esquema lógico relacional do Sistema de Gestão Escolar
- Nível: modelo lógico
- Observação: a implementação física em MySQL será realizada em módulo posterior

## 1. Objetivos de aprendizagem

Ao concluir esta unidade, o estudante deverá ser capaz de:

- explicar relação, tupla, atributo e domínio;
- diferenciar esquema relacional e instância;
- reconhecer superchaves, chaves candidatas, primárias, alternativas, estrangeiras e compostas;
- mapear entidades e atributos para relações;
- converter relacionamentos 1:1, 1:N e N:N;
- mapear entidades associativas, atributos multivalorados e relacionamentos recursivos;
- identificar integridade de entidade, domínio e referência;
- representar o esquema lógico com notação consistente;
- distinguir decisões conceituais, lógicas e físicas;
- produzir uma matriz de rastreabilidade do MER para o modelo relacional.

## 2. Do modelo conceitual ao modelo lógico

O Modelo Entidade-Relacionamento descreve o domínio. O modelo relacional define como esse domínio será organizado em relações compatíveis com um SGBD relacional.

```text
MER/DER -> mapeamento -> relações -> chaves -> restrições lógicas -> SQL
```

O mapeamento não deve ser mecânico. Cada transformação precisa preservar:

- significado;
- cardinalidade;
- obrigatoriedade;
- unicidade;
- histórico;
- regras de negócio.

## 3. Fundamentos do modelo relacional

### 3.1 Relação

Relação é uma estrutura composta por atributos e tuplas. Na implementação, costuma corresponder a uma tabela, mas o conceito lógico é mais rigoroso que a simples aparência tabular.

Exemplo:

```text
ALUNO(id_aluno, matricula, nome, data_nascimento, situacao)
```

### 3.2 Tupla

Tupla é uma ocorrência registrada em uma relação.

```text
(1, "20260041", "Ana Souza", "2008-04-10", "ATIVO")
```

No modelo relacional teórico, tuplas não possuem ordem significativa.

### 3.3 Atributo

Atributo é uma coluna lógica da relação. Cada atributo possui nome e domínio.

### 3.4 Domínio

Domínio é o conjunto de valores permitidos.

Exemplos:

- `situacao_aluno`: ATIVO ou INATIVO;
- `carga_horaria`: inteiro positivo;
- `data_nascimento`: data válida e não futura;
- `nota`: valor dentro da escala institucional.

O tipo físico contribui, mas não representa sozinho o domínio. Um `VARCHAR` não impede situações inválidas sem restrições adicionais.

### 3.5 Grau e cardinalidade da relação

- Grau: quantidade de atributos.
- Cardinalidade da relação: quantidade de tuplas em uma instância.

Não confundir essa cardinalidade com a cardinalidade dos relacionamentos do MER.

### 3.6 Esquema e instância

- Esquema relacional: definição das relações, atributos e restrições.
- Instância: conjunto de tuplas existente em determinado momento.

## 4. Propriedades fundamentais

Em uma relação conceitualmente adequada:

- cada célula possui valor atômico segundo o domínio;
- tuplas são distinguíveis;
- a ordem das linhas não tem significado;
- a ordem dos atributos não altera o significado;
- cada atributo possui domínio definido;
- ausência de valor deve ter significado controlado.

A atomicidade será retomada na normalização.

## 5. Chaves

### 5.1 Superchave

Qualquer conjunto de atributos que identifica uma tupla unicamente, mesmo contendo atributos desnecessários.

### 5.2 Chave candidata

Superchave mínima: nenhum atributo pode ser removido sem perder unicidade.

### 5.3 Chave primária — PK

Chave candidata escolhida para identificar as tuplas.

Exemplo:

```text
ALUNO(
  id_aluno PK,
  matricula UQ,
  nome,
  data_nascimento,
  situacao
)
```

### 5.4 Chave alternativa

Chave candidata não escolhida como primária. Pode exigir restrição de unicidade.

### 5.5 Chave estrangeira — FK

Atributo ou conjunto de atributos que referencia chave candidata de outra relação.

```text
TURMA(
  id_turma PK,
  id_disciplina FK -> DISCIPLINA.id_disciplina,
  codigo,
  periodo,
  situacao
)
```

### 5.6 Chave composta

Formada por dois ou mais atributos.

Exemplo possível:

```text
TURMA_PROFESSOR(
  id_turma PK, FK,
  id_professor PK, FK,
  data_inicio
)
```

Também é possível usar identificador substituto e manter uma restrição única sobre o par. A escolha precisa ser justificada.

## 6. Integridade

### 6.1 Integridade de entidade

A chave primária:

- identifica unicamente;
- não pode ser nula;
- deve permanecer estável.

### 6.2 Integridade referencial

Uma FK deve:

- corresponder a uma chave existente; ou
- ser nula quando a participação for opcional e a regra permitir.

Exemplo: não deve existir Matrícula para Aluno inexistente.

### 6.3 Integridade de domínio

Valores devem respeitar formato, intervalo, conjunto e significado.

### 6.4 Integridade de negócio

Inclui regras que ultrapassam PK, FK e tipos:

- não permitir matrícula ativa duplicada;
- respeitar escala da avaliação;
- impedir transições inválidas de situação;
- proteger histórico acadêmico.

## 7. Regras de mapeamento

### 7.1 Entidade forte

Para cada entidade forte:

1. criar uma relação;
2. incluir atributos simples;
3. escolher PK;
4. registrar chaves alternativas;
5. não armazenar atributos derivados sem justificativa.

```text
CURSO(id_curso PK, codigo UQ, nome, carga_horaria, situacao)
```

### 7.2 Atributo composto

Decompor em atributos simples relevantes.

```text
ENDERECO(logradouro, numero, complemento, bairro, cep)
```

Não criar uma coluna única se as partes precisam ser pesquisadas, validadas ou atualizadas separadamente.

### 7.3 Atributo multivalorado

Criar relação separada.

```text
ALUNO_TELEFONE(
  id_aluno PK, FK -> ALUNO.id_aluno,
  telefone PK,
  tipo
)
```

### 7.4 Atributo derivado

Preferir cálculo.

Exemplo: idade deriva de data_nascimento. Se armazenada, será necessário controlar atualização e referência temporal.

### 7.5 Relacionamento 1:N

A FK normalmente fica no lado N.

Conceitual:

> Disciplina origina Turma.

Lógico:

```text
DISCIPLINA(id_disciplina PK, ...)
TURMA(id_turma PK, id_disciplina FK, ...)
```

Se a participação de Turma for obrigatória, `id_disciplina` será logicamente obrigatório.

### 7.6 Relacionamento 1:1

A FK pode ficar em um dos lados, considerando:

- participação obrigatória;
- risco de nulos;
- dependência;
- ciclo de vida;
- segurança;
- possibilidade de fusão das relações.

A FK deve ser única para preservar 1:1.

### 7.7 Relacionamento N:N

Criar relação associativa.

Conceitual:

> Professor atua em Turma.

Lógico:

```text
TURMA_PROFESSOR(
  id_turma PK, FK -> TURMA.id_turma,
  id_professor PK, FK -> PROFESSOR.id_professor,
  data_inicio,
  data_fim,
  papel
)
```

### 7.8 Entidade associativa

Mapear como relação própria.

```text
MATRICULA(
  id_matricula PK,
  id_aluno FK -> ALUNO.id_aluno,
  id_turma FK -> TURMA.id_turma,
  data_matricula,
  situacao,
  forma_ingresso,
  UQ(id_aluno, id_turma, ...)
)
```

A restrição única exata depende da regra de rematrícula e histórico.

### 7.9 Relacionamento recursivo 1:N

A relação referencia a si própria.

Exemplo hipotético:

```text
UNIDADE(
  id_unidade PK,
  id_unidade_superior FK -> UNIDADE.id_unidade,
  nome
)
```

A FK pode ser opcional para a raiz.

### 7.10 Relacionamento recursivo N:N

Criar relação associativa com papéis claros.

```text
DISCIPLINA_PREREQUISITO(
  id_disciplina PK, FK -> DISCIPLINA.id_disciplina,
  id_prerequisito PK, FK -> DISCIPLINA.id_disciplina
)
```

### 7.11 Relacionamento ternário

Criar relação contendo FKs para as entidades participantes e determinar a chave com base na regra de unicidade. Não decompor automaticamente em três relações binárias, pois isso pode admitir combinações inexistentes.

## 8. Nulidade e opcionalidade

Valor nulo pode significar:

- desconhecido;
- ainda não informado;
- não aplicável;
- temporariamente indisponível.

Misturar significados reduz qualidade. Antes de permitir nulo:

1. qual significado terá?
2. a ausência é válida?
3. existe valor padrão legítimo?
4. a informação pertence a outra relação?
5. a obrigatoriedade muda conforme situação?

Não substituir ausência por `0`, texto vazio ou data fictícia.

## 9. Esquema lógico de referência

```text
ALUNO(
  id_aluno PK,
  matricula UQ,
  nome,
  nome_social,
  data_nascimento,
  email,
  situacao
)

PROFESSOR(
  id_professor PK,
  codigo_funcional UQ,
  nome,
  email_institucional,
  situacao
)

CURSO(
  id_curso PK,
  codigo UQ,
  nome,
  carga_horaria,
  situacao
)

DISCIPLINA(
  id_disciplina PK,
  id_curso FK -> CURSO.id_curso,
  codigo,
  nome,
  carga_horaria,
  situacao,
  UQ(id_curso, codigo)
)

TURMA(
  id_turma PK,
  id_disciplina FK -> DISCIPLINA.id_disciplina,
  codigo,
  periodo,
  data_inicio,
  data_fim,
  capacidade,
  situacao,
  UQ(id_disciplina, codigo, periodo)
)

TURMA_PROFESSOR(
  id_turma PK, FK -> TURMA.id_turma,
  id_professor PK, FK -> PROFESSOR.id_professor,
  data_inicio,
  data_fim,
  papel
)

MATRICULA(
  id_matricula PK,
  id_aluno FK -> ALUNO.id_aluno,
  id_turma FK -> TURMA.id_turma,
  data_matricula,
  situacao,
  forma_ingresso
)

AVALIACAO(
  id_avaliacao PK,
  id_turma FK -> TURMA.id_turma,
  titulo,
  data_avaliacao,
  valor_maximo,
  peso
)

NOTA(
  id_nota PK,
  id_matricula FK -> MATRICULA.id_matricula,
  id_avaliacao FK -> AVALIACAO.id_avaliacao,
  valor,
  data_lancamento,
  UQ(id_matricula, id_avaliacao)
)
```

## 10. Questões ainda abertas

- Disciplina pertence a um Curso ou a uma Matriz Curricular?
- Código da Disciplina é global ou único dentro do Curso?
- Aluno pode refazer a mesma Turma?
- Professor pode ser removido mantendo histórico de alocação?
- Nota pode ter várias versões?
- Avaliação pode ser reaproveitada entre turmas?
- Frequência depende de Aula/Encontro ainda não modelado?
- Quais dados pessoais são indispensáveis?

## 11. Matriz de rastreabilidade

Cada elemento conceitual deve ter destino lógico.

| Elemento do MER | Regra | Resultado lógico |
|---|---|---|
| Aluno | entidade forte | ALUNO |
| Disciplina–Turma | 1:N | FK em TURMA |
| Professor–Turma | N:N com atributos | TURMA_PROFESSOR |
| Aluno–Turma | Matrícula associativa | MATRICULA |
| Matrícula–Avaliação | resultado Nota | NOTA |

Use o [roteiro de mapeamento](roteiro-mapeamento.md) para registrar todas as decisões.

## 12. Prática guiada

### Etapa 1 — Preparar branch

```bash
git switch main
git pull origin main
git switch -c atividade/modulo-04-seu-nome
```

### Etapa 2 — Revisar o DER

Confirme:

- entidades;
- identificadores;
- atributos;
- cardinalidades;
- obrigatoriedade;
- atributos dos vínculos;
- hipóteses.

### Etapa 3 — Mapear uma entidade

Comece por CURSO:

```text
CURSO(id_curso PK, codigo UQ, nome, carga_horaria, situacao)
```

Justifique PK, chave alternativa, obrigatoriedade e domínios.

### Etapa 4 — Mapear 1:N

Mapeie Disciplina–Turma colocando a FK no lado N.

### Etapa 5 — Mapear N:N

Mapeie Professor–Turma com TURMA_PROFESSOR.

### Etapa 6 — Mapear entidade associativa

Mapeie MATRÍCULA e discuta a regra de unicidade.

### Etapa 7 — Registrar rastreabilidade

Para cada transformação, registre origem, regra e destino.

### Etapa 8 — Versionar

```bash
git status
git diff
git add sistema-gestao-escolar/atividades/modulo-04/
git add sistema-gestao-escolar/docs/diagramas/
git commit -m "docs: converte modelo conceitual em relacional"
git push -u origin atividade/modulo-04-seu-nome
```

## 13. Exercício individual

- [Atividade 04 — Mapeamento para o modelo relacional](../../../atividades/modulo-04/atividade-04-modelo-relacional.md)

## 14. Desafio

Avalie:

1. Onde colocar a FK em um relacionamento 1:1 opcional de ambos os lados?
2. Uma chave substituta deve substituir toda chave composta?
3. Como preservar a regra de não duplicar Matrícula?
4. Qual é o risco de colocar telefones em `telefone1`, `telefone2` e `telefone3`?
5. Como mapear pré-requisitos de Disciplina?
6. Por que três FKs isoladas nem sempre substituem corretamente um relacionamento ternário?

## 15. Erros frequentes

- criar FK no lado errado do 1:N;
- esquecer unicidade no mapeamento 1:1;
- manter N:N sem relação associativa;
- escolher PK sem preservar chave de negócio;
- usar nulo sem significado;
- colocar listas em uma coluna;
- armazenar atributo derivado sem justificativa;
- confundir relação e planilha;
- inserir tipos MySQL antes da etapa física;
- produzir esquema sem rastreabilidade ao MER.

## 16. Checklist

- [ ] diferencio relação, tupla, atributo e domínio;
- [ ] diferencio cardinalidade relacional e cardinalidade do MER;
- [ ] reconheço tipos de chave;
- [ ] mapeio entidade forte;
- [ ] mapeio atributo multivalorado;
- [ ] posiciono FK no lado N;
- [ ] preservo 1:1 com unicidade;
- [ ] resolvo N:N;
- [ ] mapeio recursividade;
- [ ] documento nulidade;
- [ ] preservo chaves de negócio;
- [ ] rastreio cada transformação;
- [ ] separo modelo lógico de SQL físico.

## 17. Critérios de avaliação

| Critério | Peso |
|---|---:|
| Fundamentos relacionais | 15% |
| Relações e atributos | 15% |
| Chaves e integridade | 20% |
| Mapeamento 1:1 e 1:N | 15% |
| Mapeamento N:N e associativas | 15% |
| Rastreabilidade e justificativas | 10% |
| Organização e Git | 10% |

## 18. Referências

- CODD, E. F. A Relational Model of Data for Large Shared Data Banks. *Communications of the ACM*, 1970.
- RAMAKRISHNAN, R.; GEHRKE, J. *Sistemas de gerenciamento de bancos de dados*. McGraw-Hill, 2008.
- SILBERSCHATZ, A.; KORTH, H. F.; SUDARSHAN, S. *Sistema de banco de dados*. Elsevier, 2012.

## 19. Material do professor

- [Gabarito comentado do Módulo 4](../../gabaritos/modulo-04-gabarito.md)
