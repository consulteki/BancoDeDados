# Orientação — Módulo 16

Uma boa resposta não escolhe ORM por popularidade. Deve justificar:

- Sequelize para equipes JavaScript, flexibilidade e base existente;
- Prisma para TypeScript, cliente gerado e schema central;
- SQL direto para relatórios ou operações que exigem controle fino.

A matrícula deve usar `prisma.$transaction(async tx => ...)`. Se for necessário `SELECT ... FOR UPDATE`, documente o uso de SQL parametrizado por tagged template. O tratamento de `BigInt` deve ocorrer na borda de serialização, sem converter IDs dentro do banco.
