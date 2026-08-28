# Módulo 14 — Sequelize, migrations e persistência

## Objetivos

- mapear tabelas sem perder as regras do banco;
- definir associações;
- versionar alterações com migrations;
- criar dados fictícios com seeders;
- implementar serviço transacional;
- distinguir validação da aplicação e constraint.

## ORM não substitui SQL

Sequelize gera SQL e facilita modelos, associações e transações. O aluno ainda precisa compreender índices, planos, cardinalidade e integridade.

## Execução

```bash
cd sistema-gestao-escolar/src/backend/sequelize
cp .env.example .env
npm install
npm run db:migrate
npm run db:seed
npm run dev
```

A migration adiciona `atualizado_em` e possui método `down`. O seeder usa somente dados fictícios e pode ser removido pelo comando de undo do CLI.

## Associações

- Aluno 1:N Matrícula;
- Turma 1:N Matrícula;
- Matrícula pertence a Aluno e Turma.

Defina `tableName` e chaves explicitamente porque o esquema escolar já existe e usa nomes em português.

## Serviço transacional

O serviço de matrícula:

1. abre transação READ COMMITTED;
2. bloqueia a turma;
3. valida situação;
4. procura matrícula ativa;
5. conta ocupação;
6. cria matrícula;
7. confirma automaticamente ou desfaz se houver erro.

## Migrations

Migration é histórico executável, não uma edição manual do banco. Depois que uma migration foi compartilhada, prefira criar outra em vez de reescrever o passado.

Nunca use `sequelize.sync({ force: true })` em ambiente que contenha dados importantes.

## Atividade

Resolva a [Atividade 14](../../../atividades/modulo-14/atividade-14-sequelize.md).

## Git

```bash
git switch -c atividade/modulo-14-seu-nome
git add sistema-gestao-escolar/src/backend/sequelize
git commit -m "feat: conclui persistencia sequelize"
git push -u origin atividade/modulo-14-seu-nome
```
