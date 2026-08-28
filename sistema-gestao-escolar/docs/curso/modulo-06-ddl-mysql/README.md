# Módulo 6 — DDL e construção física no MySQL

## Dados da unidade

- Duração sugerida: 4 horas
- Pré-requisitos: Módulos 1 a 5
- Produto principal: banco `gestao_escolar` criado no MySQL
- SGBD: MySQL Community 8.0.16 ou superior
- Ferramenta: MySQL Workbench
- Scripts: `docs/scripts/00`, `01` e `02`

## 1. Objetivos de aprendizagem

Ao concluir esta unidade, o estudante deverá ser capaz de:

- explicar DDL;
- criar banco e tabelas;
- escolher tipos físicos coerentes;
- aplicar PK, FK, UNIQUE, NOT NULL, DEFAULT e CHECK;
- nomear constraints;
- distinguir recursos ANSI e extensões MySQL;
- definir ações referenciais com cautela;
- executar scripts no Workbench;
- interpretar erros de criação;
- consultar metadados no `information_schema`;
- validar a implementação física contra o modelo lógico;
- versionar scripts reproduzíveis.

## 2. Do modelo lógico ao físico

O modelo lógico definiu relações, atributos e chaves. O modelo físico acrescenta decisões do SGBD:

- tipos concretos;
- tamanho;
- geração de identificadores;
- charset e collation;
- engine;
- constraints;
- ações referenciais;
- detalhes de nomes;
- ordem de criação.

```text
modelo lógico -> decisões físicas -> DDL -> metadados do SGBD
```

## 3. DDL

Data Definition Language reúne comandos de definição.

| Comando | Finalidade |
|---|---|
| `CREATE` | criar banco, tabela, view ou outro objeto |
| `ALTER` | modificar estrutura |
| `DROP` | remover objeto |
| `TRUNCATE` | remover dados mantendo estrutura, com comportamento próprio |
| `RENAME` | renomear objeto conforme suporte |

Neste módulo, o foco é `CREATE` e introdução controlada a `ALTER`. `DROP` e `TRUNCATE` exigem cautela por serem destrutivos.

## 4. Anatomia de CREATE TABLE

```sql
CREATE TABLE curso (
    id_curso BIGINT NOT NULL AUTO_INCREMENT,
    codigo VARCHAR(30) NOT NULL,
    nome VARCHAR(150) NOT NULL,
    carga_horaria INTEGER NOT NULL,

    CONSTRAINT pk_curso PRIMARY KEY (id_curso),
    CONSTRAINT uq_curso_codigo UNIQUE (codigo),
    CONSTRAINT ck_curso_carga_horaria CHECK (carga_horaria > 0)
) ENGINE = InnoDB;
```

Elementos:

- nome da tabela;
- colunas;
- tipos;
- nulidade;
- valor padrão;
- geração de ID;
- constraints;
- configuração física.

## 5. Tipos utilizados

### 5.1 Inteiros

- `INTEGER`: carga horária e capacidade.
- `BIGINT`: identificadores, permitindo grande faixa.

Não usar tipo numérico para telefone, CPF ou matrícula apenas porque contêm dígitos. Esses valores não participam de operações aritméticas e podem possuir zeros iniciais.

### 5.2 Texto

- `VARCHAR(n)`: texto de tamanho variável e limitado.
- `CHAR(n)`: tamanho fixo; usar somente quando a regra justificar.
- `TEXT`: conteúdo longo, com implicações próprias.

Tamanhos devem refletir requisitos, interoperabilidade e dados reais, não números arbitrários sem justificativa.

### 5.3 Datas

- `DATE`: apenas data.
- `TIME`: horário.
- `DATETIME`: data e hora sem conversão automática de fuso pelo MySQL.
- `TIMESTAMP`: instante armazenado com comportamento de fuso e faixa específica.

Neste projeto, datas acadêmicas usam `DATE`; registros de criação usam `TIMESTAMP`.

### 5.4 Decimais

`DECIMAL(p,s)` é adequado para notas e pesos quando precisão exata importa.

- `p`: total de dígitos;
- `s`: casas decimais.

Evitar `FLOAT` para valores que não toleram aproximação binária.

## 6. Nulidade

`NOT NULL` representa obrigatoriedade física. Deve refletir a regra.

Exemplo:

- nome do Aluno: obrigatório;
- nome_social: opcional;
- data_fim da Turma: pode estar ausente durante planejamento.

Não utilizar valores falsos para evitar nulo.

## 7. Constraints

### 7.1 PRIMARY KEY

Garante unicidade e não nulidade do identificador principal.

### 7.2 UNIQUE

Preserva chaves candidatas e regras de unicidade.

A PK técnica não impede, sozinha, duplicidade de matrícula institucional.

### 7.3 FOREIGN KEY

Preserva integridade referencial.

```sql
CONSTRAINT fk_disciplina_curso
    FOREIGN KEY (id_curso)
    REFERENCES curso (id_curso)
```

### 7.4 CHECK

Expressa domínios e condições na própria tabela.

```sql
CONSTRAINT ck_curso_carga_horaria
    CHECK (carga_horaria > 0)
```

No MySQL, enforcement de `CHECK` requer versão moderna; versões anteriores podiam aceitar e ignorar a condição.

### 7.5 DEFAULT

Fornece valor quando a coluna é omitida. Não substitui validação.

## 8. Constraints nomeadas

Use nomes previsíveis:

| Prefixo | Significado |
|---|---|
| `pk_` | chave primária |
| `fk_` | chave estrangeira |
| `uq_` | unicidade |
| `ck_` | verificação |
| `idx_` | índice |

Nomes facilitam diagnóstico, migrations e manutenção.

## 9. AUTO_INCREMENT e portabilidade

`AUTO_INCREMENT` é específico do MySQL. Outros SGBDs usam:

- identidade;
- sequence;
- serial;
- generated identity.

Por isso, o material comenta explicitamente a extensão. O conceito portável é geração de identificador, não a palavra-chave.

## 10. Charset e collation

- charset define codificação;
- collation define regras de comparação e ordenação.

O script usa:

```sql
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci
```

É configuração específica do MySQL 8 e favorece Unicode amplo. Regras de sensibilidade a acentos e maiúsculas devem ser entendidas antes de impor unicidade.

## 11. Engine InnoDB

InnoDB oferece transações e FKs no MySQL. `ENGINE = InnoDB` é específico do SGBD.

## 12. Ações referenciais

Opções comuns:

- `RESTRICT` ou `NO ACTION`;
- `CASCADE`;
- `SET NULL`.

Este projeto usa `RESTRICT` para evitar apagar histórico por acidente.

`CASCADE` não é “melhor” nem “mais automático”. Deve representar a regra de ciclo de vida. Excluir Curso e apagar notas em cadeia seria inadequado.

## 13. Ordem de criação

Tabelas referenciadas devem existir antes das dependentes.

Ordem aplicada:

1. aluno;
2. professor;
3. curso;
4. disciplina;
5. turma;
6. turma_professor;
7. matricula;
8. avaliacao;
9. nota.

A ordem de remoção, quando autorizada, é inversa.

## 14. Regras que CHECK não resolve

`CHECK` normalmente avalia a própria linha. Não resolve facilmente:

- nota menor ou igual ao valor máximo de outra tabela;
- quantidade de matrículas menor que capacidade;
- apenas uma matrícula ativa;
- soma dos pesos igual a 1;
- professor autorizado para determinada turma.

Essas regras podem envolver transação, serviço, trigger ou procedimento, conforme decisão posterior.

## 15. Scripts do módulo

Execute na ordem:

1. [00-criar-banco.sql](../../scripts/00-criar-banco.sql)
2. [01-criar-tabelas.sql](../../scripts/01-criar-tabelas.sql)
3. [02-verificar-estrutura.sql](../../scripts/02-verificar-estrutura.sql)

## 16. Execução no MySQL Workbench

### Etapa 1 — Conferir servidor

- abrir MySQL Workbench;
- selecionar a conexão local;
- testar conexão;
- confirmar MySQL 8.0.16+:

```sql
SELECT VERSION();
```

### Etapa 2 — Abrir script

Menu:

```text
File -> Open SQL Script
```

Abra `00-criar-banco.sql`.

### Etapa 3 — Executar

- raio simples: comando selecionado/atual;
- raio completo: script inteiro;
- conferir painel de saída;
- não ignorar avisos ou erros.

### Etapa 4 — Atualizar schemas

No painel SCHEMAS:

- clicar em refresh;
- localizar `gestao_escolar`;
- expandir Tables.

### Etapa 5 — Criar tabelas

Abra e execute `01-criar-tabelas.sql`.

### Etapa 6 — Verificar

Execute `02-verificar-estrutura.sql`.

Resultado esperado:

- nove tabelas;
- PKs nomeadas;
- FKs;
- restrições UNIQUE;
- CHECKs;
- InnoDB;
- collation do banco.

## 17. Execução pela linha de comando

Sem colocar senha no comando:

```bash
mysql -u root -p < sistema-gestao-escolar/docs/scripts/00-criar-banco.sql
mysql -u root -p gestao_escolar < sistema-gestao-escolar/docs/scripts/01-criar-tabelas.sql
mysql -u root -p gestao_escolar < sistema-gestao-escolar/docs/scripts/02-verificar-estrutura.sql
```

O terminal solicitará a senha. Em ambiente real, use usuário com privilégios mínimos, não `root`.

## 18. Transação e DDL no MySQL

Muitos comandos DDL provocam commit implícito no MySQL. Portanto:

- não suponha que `ROLLBACK` desfará `CREATE TABLE`;
- teste em banco didático;
- versionar scripts é essencial;
- planeje alterações com backups/migrations.

## 19. ALTER TABLE

Exemplo didático:

```sql
ALTER TABLE aluno
    ADD COLUMN telefone_preferencial VARCHAR(20) NULL;
```

Antes de alterar:

- verificar necessidade;
- avaliar dados existentes;
- considerar impacto em API e ORM;
- preparar reversão;
- atualizar documentação.

Não execute o exemplo no modelo oficial: telefone é potencialmente multivalorado.

## 20. Erros comuns

### No database selected

Execute:

```sql
USE gestao_escolar;
```

### Table already exists

O script foi repetido. Não apagar automaticamente; confira o ambiente.

### Cannot add foreign key constraint

Verifique:

- tabela referenciada;
- tipo e sinal do campo;
- coluna alvo indexada;
- engine;
- ordem;
- dados existentes em ALTER.

### Check constraint violated

O valor não respeita regra declarada. Corrija o dado, não desative a constraint sem análise.

### Access denied

Usuário não possui privilégio. Não contorne; solicite autorização adequada.

## 21. Prática guiada

### Etapa 1 — Branch

```bash
git switch main
git pull origin main
git switch -c atividade/modulo-06-seu-nome
```

### Etapa 2 — Executar scripts

Execute os três scripts na ordem.

### Etapa 3 — Registrar evidências

Crie:

```text
sistema-gestao-escolar/atividades/modulo-06/evidencias-seu-nome.md
```

Registre:

- versão do MySQL;
- data da execução;
- quantidade de tabelas;
- três PKs;
- cinco FKs;
- três CHECKs;
- erros encontrados e correções;
- diferenças entre modelo lógico e físico.

Não inclua senha, host sensível ou dados pessoais.

### Etapa 4 — Testes negativos

Tente, dentro de transação quando aplicável:

- Curso com carga horária negativa;
- Aluno com situação inválida;
- Disciplina referenciando Curso inexistente.

No MySQL, INSERTs podem ser revertidos:

```sql
START TRANSACTION;

-- teste de INSERT invalido aqui

ROLLBACK;
```

A falha esperada deve ser documentada.

### Etapa 5 — Versionar

```bash
git status
git diff
git add sistema-gestao-escolar/atividades/modulo-06/
git commit -m "test: registra validacao da estrutura fisica"
git push -u origin atividade/modulo-06-seu-nome
```

## 22. Exercício individual

- [Atividade 06 — DDL e validação estrutural](../../../atividades/modulo-06/atividade-06-ddl.md)

## 23. Desafio

1. Por que telefone não deve ser `BIGINT`?
2. Quando `CHAR` seria mais adequado que `VARCHAR`?
3. Por que `CASCADE` pode ser perigoso no histórico escolar?
4. Como garantir uma matrícula ativa por aluno/turma no MySQL?
5. Por que `valor <= valor_maximo` não está em CHECK de NOTA?
6. Como adaptar IDs para PostgreSQL mantendo o conceito?
7. O que muda quando uma tabela já possui milhões de linhas e recebe `ALTER`?

## 24. Checklist

- [ ] explico DDL;
- [ ] identifico extensões MySQL;
- [ ] escolho tipos coerentes;
- [ ] aplico nulidade;
- [ ] nomeio constraints;
- [ ] preservo chaves de negócio;
- [ ] crio FKs;
- [ ] escolho ações referenciais;
- [ ] executo scripts na ordem;
- [ ] interpreto erros;
- [ ] consulto metadados;
- [ ] realizo testes negativos;
- [ ] não versiono credenciais;
- [ ] registro evidências.

## 25. Critérios de avaliação

| Critério | Peso |
|---|---:|
| Execução e reprodutibilidade | 20% |
| Tipos e nulidade | 15% |
| PK, FK e UNIQUE | 20% |
| CHECK e domínios | 15% |
| Portabilidade | 10% |
| Verificação e testes negativos | 15% |
| Git e documentação | 5% |

## 26. Referências

- MySQL 8.0 Reference Manual.
- RAMAKRISHNAN, R.; GEHRKE, J. *Sistemas de gerenciamento de bancos de dados*. McGraw-Hill, 2008.
- SILBERSCHATZ, A.; KORTH, H. F.; SUDARSHAN, S. *Sistema de banco de dados*. Elsevier, 2012.

## 27. Material do professor

- [Gabarito comentado do Módulo 6](../../gabaritos/modulo-06-gabarito.md)
