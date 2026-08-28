# Módulo 15 — Integração, revisão e considerações finais

Este módulo encerra formalmente a formação principal de 60 horas.

## Objetivos

- integrar interface, API e persistência;
- revisar a evolução completa do sistema;
- avaliar evidências técnicas;
- comunicar decisões e limitações;
- elaborar plano de continuidade profissional.

## Arquitetura consolidada

```text
Navegador → HTTP/JSON → Express → Serviço → Sequelize → MySQL
```

Cada camada possui responsabilidade:

| Camada | Responsabilidade |
|---|---|
| Frontend | interação, estado visual e experiência |
| API | contrato HTTP, validação e resposta |
| Serviço | regras e transações |
| Persistência | consultas, models e migrations |
| MySQL | constraints, integridade e durabilidade |

## Integração

O arquivo `src/frontend/api-client.js` encapsula `fetch`. O aluno substitui as funções de `localStorage` do Módulo 12 pelas funções do cliente HTTP, sem misturar detalhes de rede à renderização.

Execute:

```bash
# terminal 1
cd src/backend/mysql2
cp .env.example .env
npm install
npm run dev

# terminal 2
cd src/frontend
npx serve .
```

Ajuste o CORS ao endereço real do frontend.

## Revisão do percurso

1. domínio e regras;
2. MER e modelo relacional;
3. normalização;
4. DDL e constraints;
5. DML e consultas;
6. relatórios e desempenho;
7. transações;
8. interface web;
9. API e segurança;
10. ORM e migrations.

## Apresentação final

Tempo sugerido: 10 minutos.

- 1 min: problema e público;
- 2 min: modelo e regras;
- 3 min: demonstração CRUD;
- 2 min: transação e integridade;
- 1 min: evidências de teste;
- 1 min: limitações e próximos passos.

## Critério de conclusão

A formação principal termina quando o estudante entrega código, documentação, scripts, histórico Git e evidências de execução. A quantidade de funcionalidades importa menos que coerência, segurança e capacidade de explicar decisões.

## Considerações finais

O projeto demonstrou que banco de dados não é um componente isolado. Modelagem, consultas, índices, transações e aplicação formam um sistema. O estudante deve sair capaz de investigar, justificar e documentar, não apenas repetir comandos.

Os módulos 16–18 são opcionais e formam a **Trilha Complementar de Aprofundamento e Projeto Profissional**, voltada a práticas contemporâneas do mercado e construção de portfólio.

## Git

```bash
git switch -c projeto/conclusao-60h-seu-nome
git add sistema-gestao-escolar
git commit -m "feat: integra projeto final da formacao principal"
git push -u origin projeto/conclusao-60h-seu-nome
```
