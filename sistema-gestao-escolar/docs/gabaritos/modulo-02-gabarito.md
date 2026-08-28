# Gabarito comentado — Módulo 2

> Material do professor. O gabarito apresenta soluções plausíveis, não uma única modelagem definitiva. Respostas alternativas devem ser aceitas quando forem coerentes e justificadas.

## Parte A — Classificação

| Item | Classificação esperada | Comentário |
|---|---|---|
| Aluno | entidade | possui ocorrências, atributos e ciclo de vida |
| Nome do aluno | atributo | descreve Aluno |
| Matrícula | entidade associativa | relaciona Aluno e Turma e possui dados próprios |
| Data da matrícula | atributo | descreve Matrícula |
| Média final | atributo derivado/resultado | depende das avaliações e da regra de cálculo |
| Relatório de reprovados | resultado de consulta | é produzido a partir dos dados |
| Botão “Cadastrar” | elemento da solução | pertence à interface |
| Professor | entidade | possui cadastro e participa das turmas |
| Nota entre 0 e 10 | regra/domínio | restringe o valor, se essa for a escala validada |
| Telefone do aluno | atributo multivalorado candidato | pode exigir estrutura separada |

## Parte B — Catálogo resumido

### Aluno

- Definição: pessoa vinculada ou candidata a vínculo acadêmico.
- Identificador técnico: `id_aluno`.
- Chaves candidatas: matrícula institucional; CPF apenas após validação.
- Atributos possíveis: nome, nome_social, data_nascimento, email, situacao.
- Regras: identificadores únicos; data não futura; situação em domínio; coleta mínima.
- Dúvidas: quando nasce a matrícula? CPF é necessário? pode haver mais de um e-mail?

### Professor

- Identificador técnico: `id_professor`.
- Candidatos naturais: matrícula funcional ou outro código institucional.
- Atributos: nome, e-mail institucional, situação, formação.
- Regras: código institucional único; apenas professor ativo pode ser alocado, se validado.
- Dúvidas: uma turma pode ter vários professores? existe substituição temporal?

### Curso

- Identificador técnico: `id_curso`.
- Candidato natural: código institucional.
- Atributos: código, nome, carga_horaria_total, situação.
- Regras: código único; carga horária positiva.
- Dúvidas: o curso possui versões de matriz curricular?

### Disciplina

- Identificador técnico: `id_disciplina`.
- Atributos: código, nome, carga_horaria, ementa, situação.
- Regras: código único no escopo definido; carga horária positiva.
- Dúvidas: disciplina pode pertencer a vários cursos? código é global?

### Turma

- Identificador técnico: `id_turma`.
- Candidato natural composto possível: disciplina + período + código da turma.
- Atributos: código, período, data_inicio, data_fim, capacidade, situação.
- Regras: datas coerentes; capacidade positiva; oferta ligada a disciplina.
- Dúvidas: há mais de um professor? pode haver turma sem capacidade definida?

### Matrícula

- Identificador técnico: `id_matricula`.
- Chave de negócio possível: aluno + turma, dependendo da rematrícula.
- Atributos: data_matricula, situação, data_cancelamento, forma_ingresso.
- Regras: aluno e turma existentes; evitar duplicidade ativa; transições válidas.
- Dúvidas: aluno cancelado pode ser rematriculado? histórico é preservado?

## Parte C — Identificadores

### 1. CPF como chave primária

Não deve ser automático porque pode ser sensível, ausente, alterado/corrigido, sujeito a regras externas e desnecessário em alguns contextos. A coleta e o uso precisam de finalidade. Mesmo quando único, pode ser melhor como chave alternativa protegida.

### 2. Chave substituta e unicidade

Não elimina. `id_aluno` distingue linhas tecnicamente, mas duas linhas poderiam representar a mesma matrícula institucional. Uma restrição de negócio continua necessária.

### 3. Chave composta de Matrícula

Aluno + turma poderia identificar Matrícula se houver no máximo uma matrícula por aluno na mesma turma ao longo de todo o histórico. Se rematrícula ou reabertura gerar nova ocorrência, a regra precisa incluir outro componente ou usar identificador substituto com restrições adequadas.

### 4. Matrícula institucional mutável

Relacionamentos baseados diretamente nela exigiriam atualizações e poderiam perder rastreabilidade. Um identificador técnico estável reduz o acoplamento, mantendo a matrícula como chave alternativa quando aplicável.

### 5. Critérios

Unicidade, minimalidade, estabilidade, obrigatoriedade, disponibilidade, tamanho, sensibilidade, significado e governança.

## Parte D — Regras reescritas

Soluções possíveis:

1. Nome do aluno é obrigatório e deve possuir entre 2 e 150 caracteres, após validação do limite.
2. Nota deve pertencer à escala institucional vigente associada à avaliação.
3. Um aluno não pode possuir duas matrículas ativas na mesma turma.
4. Apenas usuário com papel autorizado pode alterar dados cadastrais do aluno.
5. Turma ativa deve possuir ao menos um professor responsável antes do início, se essa política for confirmada.

Avaliar se o estudante assinalou o que ainda depende de validação.

## Parte E — Atributos problemáticos

- `nome_endereco_telefone`: mistura características; deve ser decomposto.
- `telefones`: potencialmente multivalorado; avaliar entidade/estrutura própria.
- `idade`: muda com o tempo; preferir data de nascimento e derivação.
- `situacao`: precisa de domínio e significado explícito.
- `observacao`: pode virar depósito de dados não estruturados; restringir finalidade.
- `cpf`: verificar necessidade, base de uso, acesso, unicidade e proteção.

## Parte F — Elementos esperados

A resposta deve:

- explicar que sem identificador não há referência inequívoca;
- aplicar minimização de dados;
- reconhecer atributos derivados;
- distinguir integridade estrutural do banco e regra de fluxo da aplicação;
- reconhecer que regras críticas podem exigir defesa em mais de uma camada;
- listar decisões que dependem de validação institucional.

## Rubrica

| Nível | Evidência |
|---|---|
| Excelente | classificações justificadas, domínios claros, identificadores criticados e regras verificáveis |
| Satisfatório | catálogo completo com pequenas imprecisões |
| Insuficiente | lista campos sem definições, confunde entidade/atributo ou trata hipótese como fato |

## Sinais de atenção

- entidade nomeada com verbo de interface;
- CPF adotado sem justificativa;
- atributos genéricos;
- domínio descrito apenas como “texto”;
- regra vaga;
- chave substituta usada para ignorar duplicidade;
- dados pessoais reais nos exemplos;
- ausência de dúvidas de validação.
