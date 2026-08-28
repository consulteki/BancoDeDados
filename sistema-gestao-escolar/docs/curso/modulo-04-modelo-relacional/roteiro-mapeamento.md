# Roteiro de mapeamento MER-relacional

## 1. Inventário de elementos

| ID | Elemento conceitual | Tipo | Regra de origem | Situação |
|---|---|---|---|---|
| E01 | | entidade/atributo/relacionamento | | validada/hipótese |

## 2. Mapeamento de entidades

| Entidade | Relação resultante | PK | Chaves alternativas | Atributos derivados excluídos | Justificativa |
|---|---|---|---|---|---|
| | | | | | |

## 3. Mapeamento de atributos especiais

| Entidade | Atributo | Classificação | Decisão lógica | Justificativa |
|---|---|---|---|---|
| | | composto/multivalorado/derivado | | |

## 4. Mapeamento de relacionamentos

| ID | Entidades | Cardinalidade | Participação | Transformação | FK/relação resultante |
|---|---|---|---|---|---|
| R01 | | | | | |

## 5. Chaves estrangeiras

| Relação de origem | FK | Relação referenciada | Chave-alvo | Nulo permitido? | Regra |
|---|---|---|---|---|---|
| | | | | | |

## 6. Unicidade de negócio

| Relação | Atributo(s) | Por que deve ser único? | Regra validada? |
|---|---|---|---|
| | | | |

## 7. Nulidade

| Relação | Atributo | Permite nulo? | Significado do nulo | Alternativa avaliada |
|---|---|---|---|---|
| | | | | |

## 8. Rastreabilidade

| Requisito/regra | Elemento do MER | Elemento relacional | Como será preservado |
|---|---|---|---|
| | | | |

## 9. Dúvidas abertas

| ID | Dúvida | Decisão afetada | Risco de decidir incorretamente |
|---|---|---|---|
| | | | |

## 10. Controle de qualidade

- [ ] Toda entidade possui relação correspondente ou justificativa.
- [ ] Toda relação possui chave primária.
- [ ] Chaves alternativas foram preservadas.
- [ ] Todo relacionamento 1:N possui FK no lado N.
- [ ] Todo 1:1 possui análise de posição e unicidade da FK.
- [ ] Todo N:N foi transformado.
- [ ] Atributos multivalorados foram tratados.
- [ ] Atributos derivados foram avaliados.
- [ ] Nulos possuem significado.
- [ ] Regras do MER permanecem rastreáveis.
- [ ] Não foram adicionados detalhes físicos do MySQL.
