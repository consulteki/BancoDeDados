# Módulo 7 — Manipulação de dados com DML

## Objetivos de aprendizagem

Ao concluir este módulo, você deverá ser capaz de:

- diferenciar DDL, DML e consultas;
- inserir dados respeitando chaves e relacionamentos;
- alterar somente os registros pretendidos;
- excluir dados com consciência do histórico e das dependências;
- relacionar `INSERT`, `SELECT`, `UPDATE` e `DELETE` ao CRUD;
- usar transações para praticar alterações de forma reversível.

## 1. Onde a DML se encaixa

A DDL define a estrutura, como `CREATE TABLE`. A DML modifica o estado dos dados:

| Operação CRUD | SQL | Finalidade |
|---|---|---|
| Create | `INSERT` | Criar uma linha |
| Read | `SELECT` | Consultar linhas |
| Update | `UPDATE` | Alterar linhas existentes |
| Delete | `DELETE` | Excluir linhas |

`SELECT` é frequentemente classificado como DQL, mas no desenvolvimento aparece como o “R” do CRUD.

## 2. Preparação da base

No MySQL Workbench, abra e execute nesta ordem:

1. `docs/scripts/01-criar-banco.sql`;
2. `docs/scripts/02-criar-tabelas.sql`;
3. `docs/scripts/03-inserir-dados.sql`.

A carga é destinada a uma base limpa e contém dados fictícios. Consulte o [catálogo dos dados](catalogo-dados-teste.md) para validar as quantidades.

## 3. INSERT

Informe as colunas explicitamente. Assim, mudanças na ordem física da tabela não quebram o comando.

```sql
INSERT INTO aluno (
    matricula, nome, data_nascimento, email, data_ingresso, situacao
) VALUES (
    '20260010', 'Nome Fictício', '2006-04-18',
    'aluno10@example.test', CURRENT_DATE, 'ATIVO'
);
```

Também é possível inserir várias linhas com um único comando:

```sql
INSERT INTO curso (codigo, nome, carga_horaria, situacao)
VALUES
    ('CUR-TESTE-1', 'Curso de Teste 1', 40, 'ATIVO'),
    ('CUR-TESTE-2', 'Curso de Teste 2', 60, 'ATIVO');
```

Se uma coluna tiver `AUTO_INCREMENT`, omita-a para o MySQL gerar o valor. `LAST_INSERT_ID()` recupera o último ID criado na conexão, mas é específico do MySQL. Aplicações Node.js normalmente recebem o ID pelo driver ou ORM.

Omissão não é igual a `NULL`: uma coluna omitida pode assumir seu `DEFAULT`; `NULL` declara ausência de valor e só é aceito em colunas anuláveis.

## 4. UPDATE

Um `UPDATE` sem `WHERE` altera todas as linhas. Antes de alterar, visualize exatamente o mesmo conjunto:

```sql
SELECT id, nome, email
FROM aluno
WHERE matricula = '20260010';

UPDATE aluno
SET email = 'novo.email@example.test'
WHERE matricula = '20260010';
```

Boas práticas:

- filtre por chave primária ou chave única quando a intenção for alterar uma linha;
- confira a quantidade de linhas afetadas;
- não mude a chave apenas para corrigir outro campo;
- registre alterações críticas na aplicação.

O modo de atualizações seguras do Workbench pode recusar filtros que não usam uma chave. Isso é uma proteção do MySQL/Workbench, não uma regra SQL ANSI. Em vez de desligá-la, melhore o `WHERE`.

## 5. DELETE e preservação do histórico

```sql
DELETE FROM aluno
WHERE id = 9999;
```

A exclusão física elimina a linha. Em gestão escolar, matrículas, notas e avaliações constituem histórico; por isso, costuma ser mais adequado atualizar a situação:

```sql
UPDATE aluno
SET situacao = 'INATIVO'
WHERE id = 10;
```

As chaves estrangeiras do projeto usam `ON DELETE RESTRICT`. Um curso com disciplinas ou um aluno com matrículas não pode ser apagado enquanto houver dependências. Essa falha é uma proteção de integridade, não um defeito do banco.

## 6. Integridade e ordem das operações

Uma inserção pode falhar por:

- chave primária ou única duplicada;
- chave estrangeira inexistente;
- valor obrigatório ausente;
- valor fora de uma restrição `CHECK`;
- tipo ou tamanho incompatível.

Insira pais antes dos filhos. Se uma exclusão física for realmente necessária, analise as dependências e trate os filhos antes dos pais. Não apague dados históricos apenas para contornar uma restrição.

## 7. Transação como rede de segurança

```sql
START TRANSACTION;
-- comandos de teste
ROLLBACK;
```

`ROLLBACK` desfaz alterações ainda não confirmadas; `COMMIT` as torna permanentes. O [laboratório DML](../../scripts/04-laboratorio-dml.sql) termina com `ROLLBACK`, permitindo repetir a prática. Transações e concorrência serão aprofundadas em módulo posterior.

Atenção: no MySQL, comandos DDL podem provocar confirmação implícita. Neste laboratório, mantenha apenas comandos DML dentro da transação.

## 8. Portabilidade

`INSERT`, `UPDATE`, `DELETE`, `CURRENT_DATE`, `COMMIT` e `ROLLBACK` fazem parte do núcleo portável usado no curso. São particularidades do MySQL neste módulo:

- `USE gestao_escolar`;
- `AUTO_INCREMENT`;
- `LAST_INSERT_ID()`;
- `ROW_COUNT()`;
- o modo `SQL_SAFE_UPDATES`.

Sempre que uma extensão do MySQL for útil, ela será identificada.

## 9. Prática guiada

1. Execute a carga inicial e compare as contagens com o catálogo.
2. Execute o laboratório inteiro.
3. Confirme que `aluno_temporario_apos_rollback` retorna zero.
4. Resolva a [Atividade 07](../../../atividades/modulo-07/atividade-07-dml.md).
5. Só depois compare sua solução com o gabarito.

## 10. Entrega com Git

Partindo da raiz do repositório:

```bash
git switch main
git pull origin main
git switch -c atividade/modulo-07-seu-nome

# edite sua solução e confira antes de registrar
git status
git diff

git add sistema-gestao-escolar/atividades/modulo-07/
git commit -m "docs: conclui atividade do modulo 07"
git push -u origin atividade/modulo-07-seu-nome
```

No GitHub, abra um Pull Request para `main`. Descreva os comandos executados, o resultado das verificações e qualquer decisão de portabilidade. Não inclua senhas, dados pessoais ou arquivos locais de configuração.

## Checklist

- [ ] Executei os scripts na ordem correta.
- [ ] Sei explicar por que um `UPDATE` ou `DELETE` sem `WHERE` é perigoso.
- [ ] Verifico dependências antes de excluir.
- [ ] Distingo exclusão física de mudança de situação.
- [ ] Consigo relacionar DML e CRUD.
- [ ] Usei `ROLLBACK` para desfazer o laboratório.
