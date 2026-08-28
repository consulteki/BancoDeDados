# Gabarito comentado — Módulo 1

> Material de apoio ao professor. As respostas dos estudantes podem usar redações diferentes, desde que preservem os conceitos e sejam coerentes com o domínio.

## Parte A — Conceitos

### 1. Dado e informação

Dado é uma representação elementar de um fato, como `8,5`. Informação surge quando o dado é contextualizado: “Ana obteve nota 8,5 na avaliação de Banco de Dados”.

### 2. Banco de dados e SGBD

Banco de dados é a coleção estruturada e relacionada de dados. SGBD é o software que permite definir, armazenar, consultar, controlar e recuperar esses dados. MySQL é o SGBD adotado.

### 3. MySQL Workbench

É uma ferramenta cliente para administração, modelagem e execução de comandos no MySQL. Não substitui o servidor do SGBD.

### 4. Esquema e instância

Esquema é a definição da estrutura: tabelas, colunas, tipos, chaves e restrições. Instância é o conteúdo existente em determinado momento.

### 5. Metadados do aluno

Exemplos aceitáveis:

- nome do atributo;
- tipo de dado;
- tamanho máximo;
- obrigatoriedade;
- descrição;
- domínio permitido;
- origem;
- responsável pela atualização.

### 6. Persistência

Mantém os dados após o encerramento da aplicação, com mecanismos controlados de armazenamento, recuperação e integridade.

### 7. Repetição sem controle

Pode causar versões conflitantes, atualização parcial, desperdício de armazenamento, dificuldade de manutenção e relatórios incorretos.

## Parte B — Exemplo de atores

| Ator | Responsabilidade | Consulta | Alteração |
|---|---|---|---|
| Secretaria | cadastro e matrícula | alunos, turmas | alunos, matrículas |
| Coordenação | oferta acadêmica | cursos, disciplinas | cursos, disciplinas, turmas |
| Professor | atividade acadêmica | turmas e matrículas | avaliações, notas, frequência |
| Estudante | acompanhamento | próprios dados | dados permitidos de perfil |
| Administrador | suporte e controle | configurações e auditoria | usuários, papéis e parâmetros |

Avaliar a coerência, não a reprodução literal.

## Parte C — Exemplos

### Requisitos funcionais

- RF01 — permitir cadastrar aluno.
- RF02 — permitir criar turma vinculada a uma disciplina.
- RF03 — permitir matricular aluno em turma.
- RF04 — permitir lançar avaliação.
- RF05 — permitir registrar nota.
- RF06 — permitir registrar frequência.
- RF07 — emitir relatório de desempenho.

### Requisitos não funcionais

- RNF01 — não armazenar credenciais no código.
- RNF02 — manter dados confirmados após reinício da aplicação.
- RNF03 — registrar erros de forma rastreável.
- RNF04 — permitir execução conforme documentação.
- RNF05 — restringir operações conforme o papel.

### Regras de negócio

- RN01 — matrícula exige aluno e turma existentes.
- RN02 — aluno não pode ter matrícula duplicada na mesma turma.
- RN03 — nota deve respeitar a escala definida.
- RN04 — frequência deve estar associada a uma matrícula válida.
- RN05 — disciplina deve pertencer a um curso ou matriz definida.
- RN06 — exclusão não pode romper histórico acadêmico.

### Dúvidas para validação

- DV01 — um aluno pode possuir mais de um curso ativo?
- DV02 — uma turma pode possuir mais de um professor?
- DV03 — qual é a escala oficial de notas?
- DV04 — como são tratados cancelamento e trancamento?
- DV05 — é permitido alterar nota após fechamento?

## Parte D — Fluxo de matrícula

Resposta esperada:

1. localizar ou cadastrar o aluno;
2. selecionar a turma;
3. verificar situação do aluno;
4. verificar existência e disponibilidade da turma;
5. verificar duplicidade;
6. validar pré-requisitos, quando aplicável;
7. registrar matrícula;
8. confirmar a operação;
9. manter evidência para consulta.

Entradas: aluno, turma, período e situação inicial.

Erros: aluno inexistente, turma inexistente, duplicidade, turma encerrada ou regra não atendida.

Persistência: identificadores relacionados, data, situação e informações de auditoria que forem aprovadas.

## Parte E — Reflexão

### Conexão direta do navegador

Expõe credenciais e banco, elimina uma camada adequada de validação e aumenta o risco de acesso indevido.

### Tabela única

Mistura assuntos, repete dados e provoca anomalias. A decisão final depende da modelagem, mas uma estrutura monolítica é inadequada para o domínio apresentado.

### Senhas no código

Credenciais podem ser expostas no Git, logs, cópias e ambientes. Devem ser fornecidas por configuração externa protegida.

### Exclusão de turma

Pode quebrar integridade e apagar histórico. O impacto deve ser avaliado e, frequentemente, usa-se mudança de situação em lugar de remoção física.

### Implementação sem validação

O código pode consolidar premissas incorretas, gerar retrabalho e aplicar regras diferentes das utilizadas pela instituição.

## Faixas de desempenho

| Faixa | Características |
|---|---|
| Excelente | conceitos corretos, requisitos verificáveis, regras claras e análise crítica |
| Satisfatório | atende ao mínimo, com pequenas imprecisões sem comprometer o entendimento |
| Insuficiente | confunde conceitos, apresenta regras vagas ou entrega incompleta |

## Sinais de atenção na correção

- requisito escrito como nome de tecnologia;
- regra que não pode ser verificada;
- ator tratado automaticamente como tabela;
- ausência de situações de erro;
- suposição apresentada como fato;
- uso de dados pessoais reais na atividade;
- credencial incluída no arquivo.
