# Módulo 8 — Consultas SQL básicas

## Objetivos de aprendizagem

Ao concluir este módulo, você deverá ser capaz de:

- explicar a ordem lógica de uma consulta;
- escolher colunas com projeção;
- filtrar dados com operadores relacionais e lógicos;
- tratar corretamente valores nulos;
- ordenar resultados de modo determinístico;
- eliminar duplicidades com `DISTINCT`;
- criar colunas derivadas com expressões, `COALESCE` e `CASE`;
- limitar e paginar resultados, reconhecendo diferenças de dialeto.

## Conhecimentos prévios

- tabelas, linhas, colunas, chaves e relacionamentos;
- execução de scripts no MySQL Workbench;
- esquema físico criado no Módulo 6;
- carga de dados do Módulo 7.

## 1. Consultar não é apenas “mostrar a tabela”

Uma consulta transforma dados armazenados em um conjunto de resultados. O banco não garante a ordem das linhas sem `ORDER BY`.

```sql
SELECT matricula, nome
FROM aluno
WHERE situacao = 'ATIVO'
ORDER BY nome;
```

Nesta consulta:

- `FROM` define a fonte;
- `WHERE` seleciona linhas;
- `SELECT` define as colunas;
- `ORDER BY` organiza a apresentação.

Embora seja escrita começando por `SELECT`, sua ordem lógica simplificada é `FROM → WHERE → SELECT → ORDER BY`. Isso explica por que certos aliases ainda não estão disponíveis no `WHERE`.

## 2. Projeção e SELECT *

```sql
SELECT matricula, nome, email
FROM aluno;
```

A projeção reduz tráfego, deixa a intenção explícita e evita depender da estrutura completa da tabela. `SELECT *` é útil para exploração rápida, mas deve ser evitado em APIs e telas estáveis.

Aliases melhoram o nome apresentado:

```sql
SELECT matricula AS codigo_aluno, nome AS nome_completo
FROM aluno;
```

`AS` para aliases é SQL padrão.

## 3. WHERE e operadores de comparação

| Operador | Significado |
|---|---|
| `=` | igual |
| `<>` | diferente no SQL padrão |
| `>`, `>=` | maior, maior ou igual |
| `<`, `<=` | menor, menor ou igual |

```sql
SELECT codigo, nome, carga_horaria
FROM curso
WHERE carga_horaria >= 180;
```

O MySQL também aceita `!=`, mas `<>` é a forma ANSI preferida.

## 4. AND, OR, NOT e precedência

`AND` é avaliado antes de `OR`. Use parênteses para tornar a regra inequívoca:

```sql
SELECT codigo, periodo, situacao
FROM turma
WHERE periodo = '2026-2'
  AND (situacao = 'ABERTA' OR situacao = 'EM_ANDAMENTO');
```

Não dependa apenas de conhecer a precedência; a clareza protege contra erros de manutenção.

## 5. IN, BETWEEN e LIKE

`IN` compara com um conjunto:

```sql
WHERE situacao IN ('ABERTA', 'PLANEJADA')
```

`BETWEEN` inclui os limites:

```sql
WHERE data_avaliacao BETWEEN '2026-08-01' AND '2026-08-31'
```

Para campos com data e hora, prefira um intervalo semiaberto:

```sql
WHERE instante >= '2026-08-01'
  AND instante <  '2026-09-01'
```

Em `LIKE`, `%` representa qualquer sequência e `_` representa um caractere. A sensibilidade a maiúsculas e minúsculas depende da collation, portanto não deve ser presumida como igual em todos os bancos.

## 6. A lógica de NULL

`NULL` significa valor ausente ou desconhecido. Comparações como `nome_social = NULL` não retornam verdadeiro.

```sql
SELECT nome, nome_social
FROM aluno
WHERE nome_social IS NOT NULL;
```

O SQL trabalha com lógica de três valores: verdadeiro, falso e desconhecido. Em `WHERE`, somente o resultado verdadeiro permanece.

`COALESCE` escolhe o primeiro valor não nulo:

```sql
SELECT COALESCE(nome_social, nome) AS nome_exibicao
FROM aluno;
```

## 7. ORDER BY e resultados determinísticos

```sql
SELECT id_matricula, data_matricula, id_aluno
FROM matricula
ORDER BY data_matricula ASC, id_aluno ASC;
```

Se várias linhas empatarem, acrescente uma chave única ao final da ordenação. Isso é essencial para paginação estável.

- `ASC`: crescente e padrão;
- `DESC`: decrescente.

A posição relativa dos valores nulos pode variar entre SGBDs. Quando isso importar, declare uma expressão de ordenação específica.

## 8. DISTINCT

```sql
SELECT DISTINCT situacao
FROM matricula
ORDER BY situacao;
```

`DISTINCT` atua sobre a combinação completa das colunas projetadas. Ele não deve ser usado para esconder duplicidades produzidas por modelagem ou relacionamentos incorretos.

## 9. Expressões e CASE

Consultas podem calcular valores sem modificar as tabelas:

```sql
SELECT titulo, valor_maximo * peso AS contribuicao_maxima
FROM avaliacao;
```

`CASE` cria classificações:

```sql
SELECT valor,
       CASE
           WHEN valor >= 9 THEN 'DESTAQUE'
           WHEN valor >= 7 THEN 'SATISFATORIA'
           ELSE 'EM_RECUPERACAO'
       END AS faixa
FROM nota;
```

A ordem dos `WHEN` importa: a primeira condição verdadeira é usada.

## 10. Limitação e paginação

No MySQL:

```sql
SELECT id_aluno, nome
FROM aluno
ORDER BY id_aluno
LIMIT 2 OFFSET 2;
```

`LIMIT` é uma extensão compartilhada por alguns SGBDs, mas não é a sintaxe do núcleo ANSI. Outros bancos usam `OFFSET ... FETCH` ou `TOP`. A aplicação deve isolar diferenças de dialeto — posteriormente o ORM ajudará nesse ponto.

Paginação por deslocamento é simples, porém páginas distantes podem ficar lentas e sofrer mudanças quando dados são inseridos. Paginação por cursor/chave será tratada junto à API.

## 11. Erros frequentes

- usar `= NULL` em vez de `IS NULL`;
- omitir aspas de textos e datas;
- misturar `AND` e `OR` sem parênteses;
- esperar uma ordem que não foi declarada;
- usar `DISTINCT` para mascarar um problema;
- paginar sem `ORDER BY`;
- usar `SELECT *` em toda consulta;
- supor que `LIKE` possui o mesmo comportamento em toda configuração.

## 12. Prática guiada

1. Prepare a base conforme os módulos anteriores.
2. Abra [05-consultas-basicas.sql](../../scripts/05-consultas-basicas.sql).
3. Execute uma consulta por vez e descreva o que cada cláusula faz.
4. Compare com os [resultados esperados](resultados-esperados.md).
5. Altere filtros e antecipe o resultado antes de executar.
6. Resolva a [Atividade 08](../../../atividades/modulo-08/atividade-08-consultas.md).
7. Consulte o gabarito somente após finalizar sua tentativa.

## 13. Entrega com Git

```bash
git switch main
git pull origin main
git switch -c atividade/modulo-08-seu-nome

# crie seu arquivo de respostas e revise
git status
git diff

git add sistema-gestao-escolar/atividades/modulo-08/
git commit -m "docs: conclui atividade do modulo 08"
git push -u origin atividade/modulo-08-seu-nome
```

Abra um Pull Request para `main` e registre quais consultas foram testadas, resultados observados e dúvidas restantes. Nunca envie credenciais ou dados pessoais.

## Checklist

- [ ] Projetei somente as colunas necessárias.
- [ ] Usei parênteses ao combinar condições.
- [ ] Tratei nulos com `IS NULL`, `IS NOT NULL` ou `COALESCE`.
- [ ] Ordenei o resultado quando a ordem era relevante.
- [ ] Sei explicar o alcance de `DISTINCT`.
- [ ] Identifiquei `LIMIT` como particularidade de dialeto.
- [ ] Comparei o resultado das consultas com a carga conhecida.

## Referências recomendadas

- ISO/IEC 9075 — SQL, conceitos da linguagem;
- documentação oficial do MySQL 8.0 — `SELECT`, expressões e otimização;
- ELMASRI, R.; NAVATHE, S. B. *Sistemas de Banco de Dados*;
- SILBERSCHATZ, A.; KORTH, H.; SUDARSHAN, S. *Sistema de Banco de Dados*.
