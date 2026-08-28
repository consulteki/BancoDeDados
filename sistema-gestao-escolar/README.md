# Sistema de Gestão Escolar

Projeto integrador do curso guiado de Banco de Dados.

## Percurso

- formação principal: módulos 1–15, 60 horas;
- trilha complementar profissional: módulos 16–18, 12 horas sugeridas;
- banco: MySQL Community;
- frontend: Vanilla JavaScript;
- API: Node.js e Express;
- ORM principal: Sequelize;
- comparação: Prisma.

## Estrutura

- `docs/curso`: conteúdo guiado;
- `docs/scripts`: criação, carga e laboratórios SQL;
- `docs/gabaritos`: orientações do professor;
- `atividades`: entregas dos estudantes;
- `src/frontend`: CRUD no navegador;
- `src/backend/mysql2`: API com SQL parametrizado;
- `src/backend/sequelize`: persistência principal;
- `src/backend/prisma`: laboratório comparativo;
- `docs/api`: contrato OpenAPI;
- `docs/operacao`: operação e recuperação.

## Início rápido do curso

Execute no Workbench:

```text
docs/scripts/00-criar-banco.sql
docs/scripts/01-criar-tabelas.sql
docs/scripts/03-inserir-dados.sql
```

Consulte [a trilha completa](docs/curso/README.md).

## Ambiente profissional local

```bash
cp .env.example .env
docker compose up --build
docker compose ps
```

Use somente dados fictícios. Não envie `.env`, credenciais, dumps ou informações pessoais ao Git.

## Status

O repositório é educacional. Antes de produção, implemente autenticação, autorização, gestão de secrets, testes completos, TLS, monitoramento, política de backup e revisão de privacidade.
