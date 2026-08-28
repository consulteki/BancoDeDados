# Gabarito — Módulo 12

A solução deve incluir `nome_social` no formulário e usar:

```js
const nomeExibicao = student.nome_social?.trim() || student.nome;
const emailDuplicado = students.some(
  item => item.email && item.email === data.email && item.id !== data.id
);
```

O filtro por situação pode combinar `filter` com o termo de busca. A restauração deve substituir o estado por uma cópia dos dados iniciais, persistir e renderizar.

Limitações esperadas: dados restritos ao navegador, ausência de autenticação, ausência de transações/relacionamentos, facilidade de alteração pelo usuário e falta de sincronização entre pessoas.
