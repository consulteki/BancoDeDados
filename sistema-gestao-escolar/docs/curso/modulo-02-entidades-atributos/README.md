# Módulo 2 — Entidades, atributos, identificadores e regras de negócio

## Dados da unidade

- Duração sugerida: 4 horas
- Pré-requisito: Módulo 1
- Produto principal: catálogo preliminar de entidades do Sistema de Gestão Escolar
- Ferramentas: editor Markdown, Git e GitHub
- Observação: ainda não serão criadas tabelas SQL

## 1. Objetivos de aprendizagem

Ao concluir esta unidade, o estudante deverá ser capaz de:

- distinguir entidade, ocorrência e atributo;
- reconhecer entidades fortes e associativas;
- classificar atributos;
- definir domínios e obrigatoriedade;
- diferenciar chave candidata, natural, substituta e composta;
- justificar a escolha de identificadores;
- escrever regras de negócio claras e verificáveis;
- produzir um catálogo preliminar de entidades;
- registrar dúvidas sem transformar suposições em requisitos.

## 2. Retomada do Módulo 1

No módulo anterior, o problema escolar foi analisado a partir de atores, dados, operações, requisitos e regras preliminares. Agora esses elementos serão refinados para identificar os objetos relevantes do domínio.

A modelagem não começa com `CREATE TABLE`. Primeiro se busca compreender:

- quais objetos precisam ser representados;
- quais características descrevem cada objeto;
- como uma ocorrência pode ser distinguida de outra;
- quais valores são válidos;
- quais regras restringem o comportamento.

## 3. Entidade

Entidade é um conceito do domínio sobre o qual a organização precisa manter dados.

Exemplos prováveis:

- Aluno;
- Professor;
- Curso;
- Disciplina;
- Turma;
- Matrícula;
- Avaliação.

Uma entidade deve possuir significado para o negócio. Termos como “tela”, “botão”, “formulário” e “endpoint” pertencem à solução tecnológica e não são, por isso, entidades do domínio escolar.

### 3.1 Entidade e ocorrência

**Entidade** representa o conjunto conceitual. **Ocorrência** representa um elemento específico.

| Entidade | Ocorrência |
|---|---|
| Aluno | Ana Souza, matrícula 20260041 |
| Curso | Desenvolvimento Web Back-End |
| Turma | Banco de Dados, período 2026/2, turma A |
| Professor | Alanancy Alves de Souza |

Não se deve usar o nome de uma pessoa específica como nome da entidade.

### 3.2 Critérios para reconhecer uma entidade

Um conceito é candidato a entidade quando:

- possui várias ocorrências;
- tem características próprias;
- precisa ser identificado;
- participa de regras ou processos;
- possui ciclo de vida relevante;
- precisa ser consultado ou mantido separadamente.

### 3.3 Entidade forte

Possui identificação própria e pode existir conceitualmente sem depender da identificação de outra entidade.

Exemplos: Aluno, Professor, Curso e Disciplina.

### 3.4 Entidade associativa

Surge quando um relacionamento possui dados ou significado próprios.

A matrícula relaciona Aluno e Turma, mas também pode possuir:

- data da matrícula;
- situação;
- forma de ingresso;
- data de cancelamento;
- observação.

Por isso, Matrícula tende a ser tratada como entidade associativa.

### 3.5 Entidade fraca

Depende de outra entidade para sua identificação. Esse conceito deve ser usado com cuidado. Nem toda entidade que possui chave estrangeira é fraca.

Exemplo hipotético: ItemDeAvaliacao identificado pelo conjunto `avaliacao + numero_item`.

## 4. Atributo

Atributo é uma propriedade que descreve uma entidade ou relacionamento.

Exemplo para Aluno:

- identificador;
- nome;
- data de nascimento;
- e-mail;
- situação.

Um atributo deve representar uma característica única. O campo genérico `dados_aluno` é inadequado porque mistura conteúdos diferentes.

### 4.1 Atributo simples

Não precisa ser dividido para a finalidade do sistema.

Exemplos: nome_social, data_nascimento e carga_horaria.

### 4.2 Atributo composto

Pode ser decomposto em partes com significado próprio.

Exemplo: endereço pode ser composto por logradouro, número, complemento, bairro, município, UF e CEP.

A decomposição depende das necessidades. Se o sistema nunca consulta partes do endereço, a decisão pode ser diferente; porém, deve ser justificada.

### 4.3 Atributo monovalorado

Possui, no máximo, um valor por ocorrência em determinado momento.

Exemplo: data_nascimento.

### 4.4 Atributo multivalorado

Pode possuir vários valores para a mesma ocorrência.

Exemplo: telefones de um aluno.

Em modelo relacional, atributos multivalorados normalmente exigem estrutura separada, que será estudada nos módulos seguintes.

### 4.5 Atributo derivado

Pode ser calculado a partir de outros dados.

Exemplos:

- idade derivada da data de nascimento;
- média final derivada das notas;
- percentual de frequência derivado das presenças e aulas.

Armazenar valor derivado pode causar inconsistência. A decisão depende de requisitos de desempenho, auditoria e histórico.

### 4.6 Atributo obrigatório e opcional

- Obrigatório: a ocorrência não é válida sem o valor.
- Opcional: o valor pode não existir ou ainda não ser conhecido.

“Não informado” não é necessariamente a mesma coisa que zero, texto vazio ou “não se aplica”.

## 5. Domínio

Domínio é o conjunto de valores admitidos para um atributo.

Exemplos:

| Atributo | Domínio preliminar |
|---|---|
| situação do aluno | ATIVO, INATIVO |
| situação da matrícula | ATIVA, TRANCADA, CANCELADA, CONCLUÍDA |
| nota | número decimal dentro da escala institucional |
| carga horária | inteiro positivo |
| e-mail | texto em formato válido |
| data de nascimento | data válida e não futura |

Um domínio pode ser controlado por tipo, restrição, tabela de referência ou regra da aplicação. A decisão física virá depois.

## 6. Identificadores

Identificador é um atributo ou conjunto de atributos capaz de distinguir uma ocorrência.

### 6.1 Chave candidata

Qualquer conjunto mínimo de atributos que identifica unicamente uma ocorrência.

Para Aluno, candidatos hipotéticos poderiam ser:

- matrícula institucional;
- CPF, se aplicável e permitido;
- identificador interno.

A validade depende das regras reais: unicidade, estabilidade, obrigatoriedade e disponibilidade.

### 6.2 Chave natural

É formada por dado com significado no negócio.

Exemplos possíveis: código institucional do curso ou matrícula do aluno.

Vantagens:

- já possui significado;
- pode impedir duplicidade de negócio.

Riscos:

- pode mudar;
- pode ser sensível;
- pode ser longo;
- pode não existir no momento do cadastro;
- pode ter regras externas.

### 6.3 Chave substituta

É criada pelo sistema apenas para identificação técnica.

Exemplo: `id_aluno`.

Vantagens:

- simples;
- estável;
- não expõe diretamente dado de negócio;
- facilita relacionamentos.

A chave substituta não elimina a necessidade de restrições de unicidade sobre chaves de negócio.

### 6.4 Chave composta

Utiliza mais de um atributo.

Exemplo conceitual: aluno + turma pode identificar unicamente uma matrícula, se a escola proibir rematrícula na mesma turma. A regra deve ser validada antes da decisão.

### 6.5 Critérios de escolha

Um bom identificador deve ser:

- único;
- mínimo;
- estável;
- obrigatório;
- não ambíguo;
- adequado à finalidade;
- protegido quando envolver dado pessoal.

## 7. Regras de negócio

Regra de negócio expressa uma restrição, política, cálculo ou condição do domínio.

### 7.1 Características de uma boa regra

Uma regra deve ser:

- clara;
- específica;
- verificável;
- independente da interface;
- rastreável à necessidade;
- escrita com termos do domínio.

Regra vaga:

> A matrícula deve ser feita corretamente.

Regra verificável:

> Um aluno não pode possuir duas matrículas ativas na mesma turma.

### 7.2 Tipos de regra

| Tipo | Exemplo |
|---|---|
| Integridade | toda matrícula referencia aluno e turma existentes |
| Unicidade | não pode existir duplicidade de matrícula ativa |
| Domínio | situação deve pertencer ao conjunto aprovado |
| Cálculo | média final resulta das avaliações definidas |
| Temporal | lançamento de nota ocorre até o fechamento |
| Autorização | professor lança nota apenas em turma autorizada |

### 7.3 Regra, requisito e implementação

- Requisito funcional: o sistema deve permitir matricular aluno.
- Regra de negócio: o aluno não pode ter matrícula ativa duplicada.
- Implementação futura: restrição `UNIQUE`, validação de serviço e transação.

Não se deve escrever a implementação como se fosse a própria regra.

## 8. Refinamento guiado do domínio escolar

### 8.1 Candidatos iniciais

| Candidato | Justificativa | Situação |
|---|---|---|
| Aluno | possui identificação e ciclo acadêmico | entidade |
| Professor | atua em turmas e possui cadastro | entidade |
| Curso | organiza formação e disciplinas | entidade |
| Disciplina | possui código, nome e carga horária | entidade |
| Turma | representa oferta em período | entidade |
| Matrícula | associa aluno e turma e possui situação | associativa |
| Avaliação | pertence a turma e define atividade | entidade |
| Nota | relaciona matrícula e avaliação | avaliar como entidade/associação |
| Frequência | registra presença por matrícula e aula/data | avaliar |
| Endereço | depende do uso e multiplicidade | validar |
| Relatório | resultado de consulta | não é automaticamente entidade |

### 8.2 Exemplo de catálogo: Aluno

| Campo | Definição preliminar |
|---|---|
| Nome da entidade | Aluno |
| Definição | pessoa vinculada ou candidata a vínculo acadêmico |
| Identificador técnico | id_aluno |
| Chaves de negócio candidatas | matrícula institucional; CPF, se aplicável |
| Atributos | nome, nome social, data de nascimento, e-mail, situação |
| Atributos obrigatórios | nome e situação; demais dependem de validação |
| Regras | identificador único; data não futura; situação em domínio controlado |
| Dúvidas | matrícula nasce no cadastro ou na inscrição? CPF é obrigatório? |

## 9. Prática guiada

### Etapa 1 — Atualizar o repositório

Após a incorporação do material pelo professor:

```bash
git switch main
git pull origin main
git switch -c atividade/modulo-02-seu-nome
```

### Etapa 2 — Copiar a ficha

Use o modelo:

- [Ficha de catálogo de entidade](ficha-catalogo-entidade.md)

Crie:

```text
sistema-gestao-escolar/atividades/modulo-02/catalogo-seu-nome.md
```

### Etapa 3 — Catalogar entidades

Preencha pelo menos:

- Aluno;
- Professor;
- Curso;
- Disciplina;
- Turma;
- Matrícula.

Para cada entidade, registre definição, identificadores candidatos, atributos, domínio, obrigatoriedade, regras e dúvidas.

### Etapa 4 — Revisar

Verifique:

- cada entidade possui significado próprio?
- atributos representam uma única característica?
- identificadores foram justificados?
- dados pessoais foram tratados com cuidado?
- regras são verificáveis?
- dúvidas estão separadas das decisões?

### Etapa 5 — Versionar

```bash
git status
git diff
git add sistema-gestao-escolar/atividades/modulo-02/
git commit -m "docs: elabora catalogo preliminar de entidades"
git push -u origin atividade/modulo-02-seu-nome
```

## 10. Exercício individual

- [Atividade 02 — Catálogo de entidades](../../../atividades/modulo-02/atividade-02-catalogo-entidades.md)

## 11. Desafio

Analise os itens e classifique-os como entidade, atributo, regra, resultado de consulta ou elemento da solução:

- aluno;
- idade;
- relatório de alunos ativos;
- botão salvar;
- matrícula;
- situação da matrícula;
- média final;
- endpoint de alunos;
- professor;
- “nota entre zero e dez”.

Justifique os casos em que a classificação depende dos requisitos.

## 12. Erros frequentes

- nomear entidade no plural;
- usar ocorrência como nome de entidade;
- transformar toda palavra do requisito em entidade;
- colocar vários valores em um atributo;
- usar CPF automaticamente como chave primária;
- criar chave substituta e esquecer a unicidade de negócio;
- armazenar idade sem avaliar derivação;
- confundir ausência de valor com zero;
- escrever regra com detalhes de tela ou framework;
- assumir como validada uma regra apenas provável.

## 13. Checklist

- [ ] diferencio entidade e ocorrência;
- [ ] reconheço entidade associativa;
- [ ] classifico atributos;
- [ ] descrevo domínio e obrigatoriedade;
- [ ] diferencio chaves candidata, natural, substituta e composta;
- [ ] justifico identificadores;
- [ ] escrevo regras verificáveis;
- [ ] separo dúvidas, regras e implementação;
- [ ] produzo o catálogo no formato solicitado;
- [ ] versiono a entrega em branch própria.

## 14. Critérios de avaliação

| Critério | Peso |
|---|---:|
| Identificação e definição das entidades | 20% |
| Qualidade dos atributos e domínios | 20% |
| Identificadores e justificativas | 20% |
| Regras de negócio | 20% |
| Dúvidas e análise crítica | 10% |
| Organização, Markdown e Git | 10% |

## 15. Referências

- RAMAKRISHNAN, R.; GEHRKE, J. *Sistemas de gerenciamento de bancos de dados*. McGraw-Hill, 2008.
- SILBERSCHATZ, A.; KORTH, H. F.; SUDARSHAN, S. *Sistema de banco de dados*. Elsevier, 2012.

## 16. Material do professor

- [Gabarito comentado do Módulo 2](../../gabaritos/modulo-02-gabarito.md)
