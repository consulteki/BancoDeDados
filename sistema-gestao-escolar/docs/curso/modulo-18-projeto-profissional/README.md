# Módulo 18 — Projeto profissional e portfólio

> Trilha Complementar de Aprofundamento e Projeto Profissional.

## Propósito

Consolidar o projeto como uma entrega demonstrável, reproduzível e criticamente documentada, aproximando o estudante de desafios técnicos atuais do mercado.

## Resultado esperado

Uma pessoa avaliadora deve conseguir:

1. compreender o problema em cinco minutos;
2. instalar seguindo o README;
3. executar com dados fictícios;
4. acessar documentação da API;
5. reproduzir testes;
6. observar decisões arquiteturais;
7. identificar limitações e roadmap;
8. verificar histórico Git coerente.

## Escopo mínimo

- cadastro de alunos;
- turmas e matrículas;
- matrícula transacional;
- relatórios escolares;
- constraints e migrations;
- frontend integrado;
- API documentada;
- testes automatizados;
- Docker Compose;
- backup/restauração demonstrados;
- logs e health check.

## Qualidades profissionais

| Qualidade | Evidência |
|---|---|
| Reprodutibilidade | comandos e ambiente versionado |
| Segurança | menor privilégio, secrets e validação |
| Confiabilidade | constraints, transações e testes |
| Desempenho | EXPLAIN e índices justificados |
| Manutenibilidade | camadas, migrations e ADRs |
| Operabilidade | health, logs, backup e restauração |
| Comunicação | README, OpenAPI e apresentação |

## Entregas

- [briefing](briefing.md);
- [checklist de portfólio](checklist-portfolio.md);
- ao menos um ADR;
- README principal;
- demonstração gravada ou ao vivo;
- backlog priorizado.

## Apresentação

Pitch de 12 minutos:

- problema e usuário;
- arquitetura;
- demonstração;
- decisão difícil;
- segurança e qualidade;
- desempenho;
- limitações;
- roadmap.

## Git

```bash
git switch -c profissional/projeto-final-seu-nome
git add sistema-gestao-escolar
git commit -m "feat: conclui projeto profissional de portfolio"
git push -u origin profissional/projeto-final-seu-nome
```

Abra Pull Request e solicite revisão técnica.
