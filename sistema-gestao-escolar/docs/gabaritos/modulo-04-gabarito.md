# Gabarito comentado — Módulo 4

> O esquema é uma referência. Aceite alternativas quando preservarem regras, integridade e rastreabilidade.

## Parte A — Fundamentos

1. Relação é a estrutura; tupla é uma ocorrência; atributo é uma propriedade; domínio é o conjunto de valores permitidos.
2. Grau é quantidade de atributos; cardinalidade da relação é quantidade de tuplas.
3. Superchave identifica, mas pode ter excesso; chave candidata é mínima; primária é a escolhida; alternativa é candidata não escolhida.
4. FK referencia uma chave candidata de outra relação e preserva vínculo.
5. A substituta identifica tecnicamente, mas não impede duplicidade de negócio.
6. Entidade: PK única e não nula; referência: FK válida ou nula quando permitido; domínio: valor válido.
7. Vários significados tornam consultas e regras ambíguas.

## Parte B — Relações de referência

```text
ALUNO(id_aluno PK, matricula UQ, nome, nome_social, data_nascimento, email, situacao)

PROFESSOR(id_professor PK, codigo_funcional UQ, nome, email_institucional UQ, situacao)

CURSO(id_curso PK, codigo UQ, nome, carga_horaria, situacao)

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

AVALIACAO(
  id_avaliacao PK,
  id_turma FK -> TURMA.id_turma,
  titulo,
  data_avaliacao,
  valor_maximo,
  peso
)
```

## Parte C — Relacionamentos

- Curso–Disciplina 1:N: `id_curso` em DISCIPLINA.
- Disciplina–Turma 1:N: `id_disciplina` em TURMA.
- Aluno–Matrícula 1:N: `id_aluno` em MATRICULA.
- Turma–Matrícula 1:N: `id_turma` em MATRICULA.
- Professor–Turma N:N: TURMA_PROFESSOR.
- Turma–Avaliação 1:N: `id_turma` em AVALIACAO.
- Matrícula–Nota 1:N: `id_matricula` em NOTA.
- Avaliação–Nota 1:N: `id_avaliacao` em NOTA.

```text
TURMA_PROFESSOR(
  id_turma PK, FK,
  id_professor PK, FK,
  data_inicio,
  data_fim,
  papel
)

MATRICULA(
  id_matricula PK,
  id_aluno FK,
  id_turma FK,
  data_matricula,
  situacao,
  forma_ingresso
)

NOTA(
  id_nota PK,
  id_matricula FK,
  id_avaliacao FK,
  valor,
  data_lancamento,
  UQ(id_matricula, id_avaliacao)
)
```

## Parte D — Casos especiais

### Telefones

```text
ALUNO_TELEFONE(id_aluno PK/FK, telefone PK, tipo)
```

### Pré-requisitos

```text
DISCIPLINA_PREREQUISITO(id_disciplina PK/FK, id_prerequisito PK/FK)
```

Deve impedir autorreferência indevida e ciclos, conforme regra.

### Alocação histórica

TURMA_PROFESSOR com datas e papel. A PK pode incluir data_inicio se a mesma dupla puder ter vários períodos.

### Rematrícula

Se permitida, `UQ(id_aluno,id_turma)` não serve para todo o histórico. Considerar tentativa, período de vínculo ou regra de apenas uma matrícula ativa, que pode exigir mecanismo adicional.

### Nota com histórico

Separar nota vigente de versões ou criar NOTA_HISTORICO com versão, data, autor e motivo. Requisito de auditoria deve ser validado.

### Hierarquia

```text
UNIDADE(id_unidade PK, id_unidade_superior FK -> UNIDADE.id_unidade, nome)
```

## Parte E — Nulidade

- nome_social: pode ser nulo quando não informado/não aplicável, com cuidado semântico.
- data_nascimento: depende da obrigatoriedade institucional.
- data_fim da turma: pode ser desconhecida no planejamento, se permitido.
- data_fim da alocação: nulo pode representar alocação vigente.
- data_cancelamento: nulo quando matrícula não foi cancelada.
- data_avaliacao: pode ser nula enquanto avaliação estiver em planejamento, se a regra permitir.

Não aceitar resposta sem explicação do significado.

## Parte F — Esquema

Deve conter todas as relações, PKs, FKs, unicidades e decisões pendentes. Não exigir tipos MySQL.

## Parte G — Rastreabilidade

Exemplos:

| Regra | MER | Relacional | Preservação |
|---|---|---|---|
| Matrícula exige aluno | Aluno–Matrícula | MATRICULA.id_aluno FK | integridade referencial |
| Sem duplicidade | entidade Matrícula | chave de negócio | UQ conforme regra histórica |
| Professor atua em turma | N:N | TURMA_PROFESSOR | relação associativa |
| Uma nota por avaliação | Matrícula–Avaliação | NOTA | UQ do par |

## Parte H — Problemas

1. Sem PK, tuplas não possuem identificação estável.
2. FK no lado 1 normalmente não representa corretamente as várias ocorrências do lado N.
3. N:N não é representável diretamente por uma FK isolada.
4. Colunas numeradas criam limite artificial e repetição estrutural.
5. Idade e data podem divergir; idade é derivável.
6. IDs diferentes permitiriam duplicar a mesma matrícula de negócio.
7. Texto livre não preserva domínio.
8. Zero não é data nem ausência; usar nulidade com significado definido.

## Rubrica

| Nível | Evidência |
|---|---|
| Excelente | mapeamento completo, chaves justificadas, integridade e rastreabilidade preservadas |
| Satisfatório | esquema coerente com pequenas lacunas |
| Insuficiente | FKs incorretas, N:N não resolvidos ou mistura com modelo físico |

## Sinais de atenção

- toda relação recebe ID artificial sem análise;
- chave de negócio desaparece;
- nulidade indiscriminada;
- FK opcional contradiz participação obrigatória;
- atributo multivalorado permanece em lista;
- `AUTO_INCREMENT` e tipos MySQL tratados como parte do modelo lógico;
- ausência de dúvidas sobre regras ainda abertas.
