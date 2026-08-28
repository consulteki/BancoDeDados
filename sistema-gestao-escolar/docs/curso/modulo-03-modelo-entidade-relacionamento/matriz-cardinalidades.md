# Matriz de relacionamentos e cardinalidades

Preencha antes de desenhar o DER.

## Como preencher

Para cada relacionamento:

1. escreva a regra em linguagem natural;
2. responda mínimo e máximo para cada lado;
3. indique a fonte;
4. marque como validada ou hipótese;
5. registre impacto de uma resposta diferente.

## Matriz

| ID | Entidade A | Verbo | Entidade B | A mínimo | A máximo | B mínimo | B máximo | Fonte | Situação |
|---|---|---|---|---:|---:|---:|---:|---|---|
| REL01 | | | | | | | | | |

## Leitura bidirecional

Para cada linha, escreva duas sentenças.

### REL01

- Uma ocorrência de **A** ...
- Uma ocorrência de **B** ...

## Dados do vínculo

| Relacionamento | Possui atributos próprios? | Atributos | Exige entidade associativa? | Justificativa |
|---|---|---|---|---|
| | sim/não/a validar | | | |

## Perguntas de validação

| ID | Pergunta | Resposta atual | Quem deve validar | Impacto |
|---|---|---|---|---|
| DV-REL-01 | | | | |

## Controle de qualidade

- [ ] Todos os relacionamentos têm verbo.
- [ ] As quatro cardinalidades foram respondidas.
- [ ] As leituras nos dois sentidos são coerentes.
- [ ] Cardinalidades refletem regras, não apenas dados atuais.
- [ ] Hipóteses estão identificadas.
- [ ] Atributos do vínculo foram avaliados.
- [ ] Relacionamentos N:N foram analisados.
- [ ] Não há implementação SQL no modelo conceitual.
