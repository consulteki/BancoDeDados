# Módulo 17 — Qualidade, segurança e operação profissional

> Trilha Complementar de Aprofundamento e Projeto Profissional.

## Objetivos

Transformar o protótipo em solução reproduzível, verificável e operável.

## Pilares

- testes unitários, integração e contrato;
- banco exclusivo para testes;
- validação e tratamento de erros;
- menor privilégio e segredos;
- logs estruturados sem dados sensíveis;
- health checks e encerramento gracioso;
- Docker Compose;
- OpenAPI;
- CI;
- backup testado e restauração.

## Docker

```bash
cp .env.example .env
docker compose up --build
docker compose ps
docker compose logs -f api
```

O Compose é voltado ao aprendizado local. Produção exige secrets, TLS, imagens fixadas, limites, redes, monitoramento e banco administrado ou estratégia equivalente.

## Testes

Pirâmide sugerida:

1. muitos testes unitários de regras;
2. testes de integração com MySQL isolado;
3. poucos testes de ponta a ponta;
4. testes de contrato para API.

Cada teste deve preparar seus dados, executar e limpar. Não use a base de desenvolvimento.

## Observabilidade

Registre request ID, rota, status, duração e código de erro. Não registre senhas, tokens, SQL com dados pessoais ou corpos completos sem avaliação.

Métricas mínimas: latência, taxa de erro, conexões, queries lentas e saturação. Logs explicam eventos; métricas mostram tendências; traces conectam etapas.

## Backup

Siga [backup e restauração](../../operacao/backup-restauracao.md). Backup não testado é apenas uma expectativa de recuperação.

## OpenAPI

O contrato inicial está em [openapi.yaml](../../api/openapi.yaml). Valide-o e mantenha documentação e implementação sincronizadas.

## Atividade

Resolva a [Atividade 17](../../../atividades/modulo-17/atividade-17-qualidade.md) e produza evidências automatizadas.

## Git

```bash
git switch -c profissional/modulo-17-seu-nome
git add sistema-gestao-escolar
git commit -m "test: adiciona qualidade e operacao profissional"
git push -u origin profissional/modulo-17-seu-nome
```
