# Roteiro de dependências e normalização

## 1. Relação analisada

```text
NOME_RELACAO(
  atributo_1,
  atributo_2,
  ...
)
```

### Granularidade

Uma tupla representa:

## 2. Chaves

| Candidata | Justificativa de unicidade | É mínima? | Regra validada? |
|---|---|---|---|
| | | | |

## 3. Dependências funcionais

| ID | Determinante X | Atributo(s) Y | X -> Y | Origem da regra | Situação |
|---|---|---|---|---|---|
| DF01 | | | | | validada/hipótese |

## 4. Fecho

### Conjunto inicial

```text
X+ = { ... }
```

### Aplicações

| Passo | Dependência aplicada | Novos atributos |
|---:|---|---|
| 1 | | |

### Resultado

- O fecho contém todos os atributos?
- X é superchave?
- X é mínima?
- Existe outra chave candidata?

## 5. Anomalias

| Tipo | Operação | Problema | Exemplo |
|---|---|---|---|
| Inserção | | | |
| Atualização | | | |
| Exclusão | | | |

## 6. Primeira Forma Normal

- Existem grupos repetitivos?
- Há listas em atributos?
- Cada atributo é atômico para a finalidade?
- Qual violação foi encontrada?
- Qual decomposição foi realizada?

## 7. Segunda Forma Normal

| Relação | Chave composta | Dependência parcial | Decomposição |
|---|---|---|---|
| | | | |

## 8. Terceira Forma Normal

| Relação | Dependência transitiva | Determinante intermediário | Decomposição |
|---|---|---|---|
| | | | |

## 9. Relações resultantes

```text
RELACAO_1(...)
RELACAO_2(...)
```

Para cada relação:

| Relação | PK | FKs | Chaves alternativas | Forma normal |
|---|---|---|---|---|
| | | | | |

## 10. Junção sem perda

| Decomposição | Atributos comuns | O atributo comum determina uma parte? | Conclusão |
|---|---|---|---|
| R -> R1, R2 | | | |

## 11. Preservação de dependências

| Dependência original | Relação que permite verificá-la | Preservada diretamente? |
|---|---|---|
| | | |

## 12. Comparação com o MER

| Resultado normalizado | Elemento do MER | Coerente? | Ajuste necessário |
|---|---|---|---|
| | | | |

## 13. Dúvidas

| ID | Dúvida | Dependência/forma normal afetada | Responsável pela validação |
|---|---|---|---|
| | | | |

## 14. Controle de qualidade

- [ ] A granularidade foi declarada.
- [ ] Chaves candidatas foram justificadas.
- [ ] Dependências vêm de regras, não apenas de exemplos.
- [ ] 1FN foi verificada.
- [ ] Dependências parciais foram removidas.
- [ ] Dependências transitivas foram removidas.
- [ ] Toda relação resultante possui chave.
- [ ] FKs reconstruem os vínculos.
- [ ] A decomposição é sem perda.
- [ ] Dependências importantes foram preservadas ou documentadas.
- [ ] O resultado foi comparado ao MER.
