# Módulo 1 — Fundamentos de Banco de Dados e análise do domínio escolar

## Dados da unidade

- Duração sugerida: 4 horas
- Modalidade: exposição dialogada, demonstração e prática
- Produto: mapa inicial do domínio do Sistema de Gestão Escolar
- Pré-requisito: noções básicas de informática e organização de arquivos

## 1. Objetivos de aprendizagem

Ao concluir esta unidade, o estudante deverá ser capaz de:

- diferenciar dado, informação e conhecimento;
- explicar o que é banco de dados e SGBD;
- reconhecer problemas de armazenamento sem controle centralizado;
- diferenciar esquema, instância e metadados;
- identificar usuários e operações do domínio escolar;
- levantar requisitos iniciais sem antecipar tabelas;
- reconhecer o papel do banco nas camadas de uma aplicação web;
- preparar um fluxo básico de trabalho com Git.

## 2. Situação-problema

Uma escola controla alunos em uma planilha, turmas em outra e notas em arquivos mantidos por diferentes professores. Alguns alunos aparecem com nomes divergentes, matrículas são duplicadas e relatórios exigem conferência manual.

Questão norteadora:

> Como organizar os dados escolares para que diferentes operações utilizem informações consistentes, relacionadas, seguras e recuperáveis?

## 3. Conceitos essenciais

### 3.1 Dado

Dado é uma representação elementar de um fato. Isoladamente, pode não responder a uma pergunta.

Exemplos:

- `20260041`;
- `Ana Souza`;
- `8,5`;
- `2026-08-28`.

O valor `8,5`, sem contexto, não informa se representa nota, frequência, média ou carga horária.

### 3.2 Informação

Informação é o dado interpretado em um contexto.

Exemplo:

> A estudante Ana Souza obteve nota 8,5 na avaliação de Banco de Dados.

A informação resulta da associação entre aluno, disciplina, avaliação e valor.

### 3.3 Conhecimento

Conhecimento surge quando informações são analisadas para compreender uma situação ou orientar uma decisão.

Exemplo:

> Estudantes com frequência inferior a 75% apresentaram maior incidência de baixo desempenho.

A afirmação exige informações organizadas, regras de interpretação e análise.

### 3.4 Banco de dados

Banco de dados é uma coleção estruturada e relacionada de dados, mantida para atender finalidades definidas. No sistema escolar, deve permitir registrar e recuperar alunos, cursos, disciplinas, turmas, matrículas, avaliações, notas e frequências.

Um banco não é apenas um conjunto de arquivos. Ele incorpora:

- estrutura;
- relacionamentos;
- restrições;
- regras de integridade;
- mecanismos de consulta;
- controle de acesso;
- persistência;
- recuperação.

### 3.5 Sistema Gerenciador de Banco de Dados

O SGBD é o software responsável por criar, armazenar, consultar, proteger e administrar bancos de dados.

No curso:

- MySQL Community é o SGBD;
- MySQL Workbench é uma ferramenta cliente;
- SQL é a linguagem utilizada para interagir com o banco;
- o banco de dados é a estrutura persistida pelo SGBD.

Não confundir MySQL com MySQL Workbench. É possível o Workbench estar instalado sem que o servidor MySQL esteja ativo.

### 3.6 Esquema

Esquema é a definição relativamente estável da estrutura do banco:

- tabelas;
- colunas;
- tipos;
- chaves;
- relacionamentos;
- restrições.

Exemplo conceitual:

```text
aluno(id_aluno, nome, cpf, data_nascimento, situacao)
```

### 3.7 Instância

Instância é o conjunto de valores armazenados em determinado momento.

```text
1 | Ana Souza  | 000... | 2008-04-10 | ATIVO
2 | Bruno Lima | 111... | 2007-11-22 | ATIVO
```

O esquema pode permanecer igual enquanto a instância muda continuamente.

### 3.8 Metadados

Metadados são dados que descrevem outros dados.

Exemplos:

- nome da coluna;
- tipo;
- tamanho máximo;
- possibilidade de valor nulo;
- descrição do campo;
- origem;
- responsável;
- regra de validação.

No projeto, o dicionário de dados será um artefato de metadados.

### 3.9 Persistência

Persistência é a capacidade de manter dados após o encerramento do programa. Um array JavaScript existe apenas durante a execução, salvo se houver mecanismo adicional de armazenamento. O banco oferece persistência controlada.

### 3.10 Integridade

Integridade significa manter dados válidos e coerentes.

Exemplos de regras:

- toda matrícula deve estar associada a um aluno existente;
- um aluno não pode ter duas matrículas na mesma turma;
- uma nota deve pertencer a uma avaliação existente;
- a nota deve respeitar a escala adotada;
- campos obrigatórios não podem ficar vazios.

### 3.11 Redundância e inconsistência

Redundância é repetição de dados. Nem toda repetição é automaticamente errada, mas repetições não controladas aumentam o risco de inconsistência.

Exemplo: o telefone de um aluno registrado em cinco planilhas pode ser atualizado em apenas duas. O sistema passa a possuir versões conflitantes do mesmo fato.

### 3.12 Usuários e papéis

O levantamento deve considerar quem utiliza o sistema e para qual finalidade.

| Papel | Operações esperadas |
|---|---|
| Secretaria | cadastrar alunos e efetuar matrículas |
| Coordenação | organizar cursos, disciplinas e turmas |
| Professor | consultar turmas e lançar notas/frequência |
| Estudante | consultar dados acadêmicos autorizados |
| Administração | configurar acessos, auditar e recuperar dados |

Papéis não são tabelas automaticamente. Primeiro representam atores e responsabilidades; a modelagem será feita nos módulos seguintes.

## 4. Banco de dados na aplicação web

Fluxo simplificado:

```text
Navegador -> API Node.js -> regra de negócio -> acesso a dados -> MySQL
```

Responsabilidades:

- o navegador apresenta e coleta dados;
- a API recebe requisições HTTP;
- a camada de negócio verifica regras;
- a camada de acesso executa operações de persistência;
- o MySQL mantém os dados e aplica restrições.

O navegador não deve receber credenciais do banco nem conectar diretamente ao MySQL.

## 5. Levantamento inicial do domínio

Antes de criar tabelas, investigar o funcionamento do ambiente.

### 5.1 Perguntas orientadoras

- Quem cadastra um aluno?
- Qual atributo identifica o aluno institucionalmente?
- Um aluno pode participar de mais de um curso?
- Uma disciplina pode ser ofertada em vários períodos?
- Uma turma pode ter mais de um professor?
- Como ocorre matrícula e cancelamento?
- Qual é a escala de notas?
- Como a frequência é registrada?
- Quais relatórios são necessários?
- Quem pode consultar e alterar cada informação?
- Por quanto tempo os registros devem ser mantidos?

### 5.2 Requisitos funcionais iniciais

Exemplos:

- RF01 — cadastrar aluno;
- RF02 — atualizar dados do aluno;
- RF03 — cadastrar curso;
- RF04 — cadastrar disciplina;
- RF05 — criar turma;
- RF06 — matricular aluno em turma;
- RF07 — lançar avaliação e nota;
- RF08 — registrar frequência;
- RF09 — emitir relatório de desempenho.

### 5.3 Requisitos não funcionais iniciais

Exemplos:

- RNF01 — proteger credenciais de acesso;
- RNF02 — impedir perda de dados confirmados;
- RNF03 — registrar erros sem revelar dados sensíveis;
- RNF04 — permitir execução em ambiente documentado;
- RNF05 — manter nomenclatura consistente;
- RNF06 — versionar scripts e documentação.

### 5.4 Regras de negócio preliminares

- RN01 — uma matrícula deve relacionar aluno e turma válidos;
- RN02 — não pode existir matrícula duplicada na mesma turma;
- RN03 — uma nota deve estar dentro da escala definida;
- RN04 — a situação do aluno deve pertencer a um domínio controlado;
- RN05 — a frequência deve estar associada a uma aula ou data válida.

Estas regras são hipóteses iniciais. Devem ser validadas antes da implementação.

## 6. Prática guiada

### Etapa 1 — Verificar ferramentas

No terminal:

```bash
git --version
node --version
npm --version
mysql --version
```

Se `mysql` não estiver no PATH, o servidor ainda pode estar instalado. Confirme no serviço do sistema ou no MySQL Workbench.

### Etapa 2 — Clonar o repositório

```bash
git clone https://github.com/consulteki/BancoDeDados.git
cd BancoDeDados
git status
git branch --show-current
```

Resultados esperados:

- repositório clonado;
- branch atual exibida;
- árvore de trabalho sem alterações.

### Etapa 3 — Criar branch da atividade

Substitua `seu-nome` por um identificador curto, sem espaços ou acentos.

```bash
git switch main
git pull origin main
git switch -c atividade/modulo-01-seu-nome
```

### Etapa 4 — Produzir o mapa do domínio

Crie um arquivo em:

```text
sistema-gestao-escolar/atividades/modulo-01/resposta-seu-nome.md
```

Use a estrutura:

```markdown
# Mapa inicial do domínio escolar

## Atores

## Dados manipulados

## Operações principais

## Problemas atuais

## Requisitos funcionais

## Requisitos não funcionais

## Regras de negócio preliminares

## Dúvidas que precisam ser validadas
```

### Etapa 5 — Revisar e versionar

```bash
git status
git diff
git add sistema-gestao-escolar/atividades/modulo-01/
git commit -m "docs: registra analise inicial do dominio escolar"
git push -u origin atividade/modulo-01-seu-nome
```

## 7. Exercício individual

Consulte o enunciado em:

- [Atividade 01 — Diagnóstico do domínio escolar](../../../atividades/modulo-01/atividade-01-diagnostico.md)

## 8. Desafio

Explique por que cada solução abaixo é inadequada ou insuficiente:

1. permitir que o navegador se conecte diretamente ao MySQL;
2. armazenar todos os dados escolares em uma única tabela;
3. registrar o nome do curso em todas as linhas de matrícula;
4. aceitar qualquer texto para a situação da matrícula;
5. excluir definitivamente uma turma com histórico de notas sem avaliação do impacto.

## 9. Erros frequentes

- começar pelas tabelas sem compreender o processo;
- confundir requisito com solução técnica;
- tratar MySQL Workbench como se fosse o SGBD;
- considerar planilha e banco relacional equivalentes;
- definir todos os campos como texto;
- usar CPF como chave primária sem discutir implicações;
- inserir credenciais no repositório;
- trabalhar diretamente na branch `main`;
- escrever regra vaga, como “o sistema deve ser bom”.

## 10. Checklist de aprendizagem

O estudante consegue:

- [ ] diferenciar dado, informação e conhecimento;
- [ ] explicar banco de dados, SGBD e ferramenta cliente;
- [ ] diferenciar esquema e instância;
- [ ] fornecer exemplos de metadados;
- [ ] explicar persistência e integridade;
- [ ] identificar atores e operações do sistema;
- [ ] separar requisito funcional, não funcional e regra de negócio;
- [ ] clonar o repositório e criar uma branch;
- [ ] produzir e versionar o mapa inicial do domínio.

## 11. Critérios de avaliação

| Critério | Peso |
|---|---:|
| Identificação dos atores | 15% |
| Dados e operações do domínio | 20% |
| Requisitos funcionais | 20% |
| Requisitos não funcionais | 15% |
| Regras de negócio preliminares | 20% |
| Clareza, organização e Git | 10% |

## 12. Evidências de entrega

O Pull Request deve conter:

- arquivo Markdown preenchido;
- pelo menos cinco requisitos funcionais;
- pelo menos três requisitos não funcionais;
- pelo menos cinco regras preliminares;
- uma dúvida relevante para validação;
- commit descritivo.

## 13. Referências

- RAMAKRISHNAN, R.; GEHRKE, J. *Sistemas de gerenciamento de bancos de dados*. McGraw-Hill, 2008.
- SILBERSCHATZ, A.; KORTH, H. F.; SUDARSHAN, S. *Sistema de banco de dados*. Elsevier, 2012.
- Documentação curricular do curso de Qualificação Profissional em Desenvolvimento Web Back-End, versão 05/2026.

## 14. Material do professor

- [Gabarito comentado do Módulo 1](../../gabaritos/modulo-01-gabarito.md)
