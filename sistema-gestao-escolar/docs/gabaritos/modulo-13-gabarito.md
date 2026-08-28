# Gabarito — Módulo 13

O PATCH deve aceitar apenas `ATIVO` ou `INATIVO` e executar:

```js
const [result] = await pool.execute(
  "UPDATE aluno SET situacao = ? WHERE id_aluno = ?",
  [req.body.situacao, req.params.id]
);
```

Paginação deve converter e limitar números antes de interpolar qualquer parte estrutural. Valores de busca continuam em placeholders. Uma entrada como `' OR 1=1 --` deve ser pesquisada literalmente, sem alterar a sintaxe SQL.

A entrega correta usa usuário não administrativo, mantém `.env` local e retorna 422 para validação, 404 para ausência, 409 para conflito e 500 sem detalhes internos.
