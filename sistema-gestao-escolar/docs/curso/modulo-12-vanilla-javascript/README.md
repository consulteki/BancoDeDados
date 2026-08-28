# Módulo 12 — CRUD com Vanilla JavaScript

## Objetivos

Compreender estado, eventos, validação, renderização e as quatro operações CRUD antes de conectar uma API.

## Fluxo

| Interface | Operação | Armazenamento local |
|---|---|---|
| formulário novo | Create | inserir no array/localStorage |
| tabela e busca | Read | filtrar e renderizar |
| editar | Update | substituir objeto |
| excluir | Delete | remover após confirmação |

## Conceitos

- DOM e seletores;
- eventos `submit`, `click` e `input`;
- arrays, objetos, `map`, `filter` e `find`;
- estado em memória;
- serialização JSON e `localStorage`;
- validação HTML e regra de matrícula única;
- renderização segura com `textContent`;
- separação entre carregar, persistir e renderizar;
- acessibilidade básica com labels e `aria-live`.

O armazenamento local é apenas simulação. Ele não oferece concorrência, integridade relacional, controle de acesso ou fonte compartilhada entre usuários.

## Execução

```bash
cd sistema-gestao-escolar/src/frontend
npx serve .
```

Abra o endereço informado. Também é possível usar a extensão Live Server. Evite abrir por `file://`, pois módulos JavaScript podem ser bloqueados pelo navegador.

## Segurança

Dados inseridos pelo usuário são apresentados com `textContent`, não com `innerHTML`. Isso reduz injeção de HTML. A validação no navegador melhora a experiência, mas não substitui validação no servidor.

## Prática

1. execute o frontend;
2. crie, edite, busque e exclua;
3. recarregue e observe o `localStorage`;
4. resolva a [Atividade 12](../../../atividades/modulo-12/atividade-12-frontend.md).

## Git

```bash
git switch -c atividade/modulo-12-seu-nome
git add sistema-gestao-escolar/src/frontend
git commit -m "feat: conclui crud frontend do modulo 12"
git push -u origin atividade/modulo-12-seu-nome
```

## Checklist

- [ ] Relacionei interface e CRUD.
- [ ] Evitei innerHTML com dados externos.
- [ ] Validei matrícula duplicada.
- [ ] Diferenciei estado local e banco compartilhado.
