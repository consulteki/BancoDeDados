# Módulo 16 — Prisma e arquitetura moderna de persistência

> Trilha Complementar de Aprofundamento e Projeto Profissional.

## Propósito

Comparar Sequelize, ORM principal do curso, com Prisma 7 em um mesmo banco existente. A meta não é declarar um vencedor, mas selecionar tecnologia com critérios.

## Execução

```bash
cd sistema-gestao-escolar/src/backend/prisma
cp .env.example .env
npm install
npm run introspect
npm run generate
npm run demo
```

Em banco existente, `prisma db pull` realiza introspecção. Revise o diff do schema: introspecção não substitui decisões de domínio.

Prisma 7 usa `prisma.config.ts` para a URL da CLI, gerador `prisma-client` com saída explícita e driver adapter para conexão. O laboratório usa `@prisma/adapter-mariadb`, compatível com MySQL/MariaDB.

## Comparação

| Critério | Sequelize | Prisma |
|---|---|---|
| Modelo | JavaScript | schema declarativo |
| Cliente | API dinâmica do ORM | cliente gerado e tipado |
| Banco existente | models manuais | introspecção |
| Migrations | sequelize-cli | Prisma Migrate |
| TypeScript | possível | experiência central |
| SQL avançado | query/raw | query/raw |
| Transações | callback gerenciado | interactive transaction |

## Cuidados

- `BigInt` não serializa diretamente em JSON;
- introspecção preserva estrutura, não necessariamente nomes de domínio;
- Prisma Migrate precisa de estratégia segura para banco existente;
- queries geradas ainda exigem análise de desempenho;
- regras críticas continuam no banco e no serviço.

## Atividade

Resolva a [Atividade 16](../../../atividades/modulo-16/atividade-16-prisma.md), produza uma matriz de decisão e mantenha Sequelize como implementação principal.

## Git

```bash
git switch -c profissional/modulo-16-seu-nome
git add sistema-gestao-escolar/src/backend/prisma
git commit -m "feat: conclui laboratorio comparativo prisma"
git push -u origin profissional/modulo-16-seu-nome
```
