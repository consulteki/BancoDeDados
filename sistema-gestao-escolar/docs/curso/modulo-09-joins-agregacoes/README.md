# Módulo 9 — Junções, agregações e relatórios escolares

## Objetivos de aprendizagem

Ao concluir este módulo, você deverá ser capaz de:

- unir tabelas a partir de chaves primárias e estrangeiras;
- escolher entre `INNER JOIN` e `LEFT JOIN`;
- distinguir filtros em `ON`, `WHERE` e `HAVING`;
- produzir métricas com `COUNT`, `SUM`, `AVG`, `MIN` e `MAX`;
- agrupar dados sem depender de extensões permissivas do MySQL;
- usar `DISTINCT`, subconsultas, `EXISTS` e `NOT EXISTS`;
- reconhecer multiplicação de linhas e contagens infladas.

## Conhecimentos prévios

- modelos conceitual, lógico e físico;
- chaves primárias e estrangeiras;
- carga DML do Módulo 7;
- filtros, aliases, expressões e ordenação do Módulo 8.

## 1. JOIN reconstrói relações

As tabelas foram separadas pela normalização. A junção recupera uma visão útil do domínio:

```sql
SELECT a.nome, m.id_turma, m.situacao
FROM aluno AS a
INNER JOIN matricula AS m
    ON m.id_aluno = a.id_aluno;
```

A condição `ON` deve representar a relação entre as tabelas. Omiti-la ou usar a chave errada pode gerar produto cartesiano: cada linha de um lado é combinada com várias do outro.

Use aliases curtos, mas significativos, e qualifique colunas repetidas.

## 2. INNER JOIN e LEFT JOIN

| Junção | Resultado |
|---|---|
| `INNER JOIN` | somente correspondências |
| `LEFT JOIN` | todas as linhas da esquerda e correspondências da direita |
| `RIGHT JOIN` | todas as linhas da direita; frequentemente reescrita como LEFT |
| `FULL OUTER JOIN` | todas de ambos os lados, com ou sem correspondência |

O MySQL 8 não implementa `FULL OUTER JOIN` diretamente. Ele pode ser simulado em casos específicos com `UNION`, mas isso deve ser identificado como adaptação de dialeto.

Para localizar avaliações sem notas:

```sql
SELECT av.id_avaliacao, av.titulo
FROM avaliacao AS av
LEFT JOIN nota AS n
    ON n.id_avaliacao = av.id_avaliacao
WHERE n.id_nota IS NULL;
```

## 3. ON versus WHERE em junções externas

Considere a contagem de matrículas ativas, preservando turmas vazias:

```sql
SELECT t.id_turma, COUNT(m.id_matricula)
FROM turma AS t
LEFT JOIN matricula AS m
    ON m.id_turma = t.id_turma
   AND m.situacao = 'ATIVA'
GROUP BY t.id_turma;
```

Se `m.situacao = 'ATIVA'` for movido para `WHERE`, a turma sem matrícula terá valor nulo e será removida. O filtro em `ON` controla quais filhos correspondem; o `WHERE` filtra o resultado da junção.

## 4. Funções agregadas

| Função | Finalidade |
|---|---|
| `COUNT` | contar |
| `SUM` | somar |
| `AVG` | calcular média |
| `MIN` | obter menor valor |
| `MAX` | obter maior valor |

`COUNT(*)` conta linhas. `COUNT(coluna)` ignora nulos. Em um `LEFT JOIN`, conte uma chave não nula do filho para que grupos sem correspondência resultem em zero.

```sql
SELECT situacao, COUNT(*) AS quantidade
FROM matricula
GROUP BY situacao;
```

## 5. GROUP BY

`GROUP BY` reúne linhas com os mesmos valores. Toda coluna não agregada projetada deve participar do agrupamento:

```sql
SELECT av.id_avaliacao,
       av.titulo,
       ROUND(AVG(n.valor), 2) AS media
FROM avaliacao AS av
LEFT JOIN nota AS n
    ON n.id_avaliacao = av.id_avaliacao
GROUP BY av.id_avaliacao, av.titulo;
```

Algumas configurações antigas do MySQL toleram colunas não agrupadas, mas o resultado pode ser arbitrário. O curso usa a forma explícita e portável, compatível com `ONLY_FULL_GROUP_BY`.

## 6. WHERE e HAVING

- `WHERE` filtra linhas antes do agrupamento;
- `HAVING` filtra grupos depois das agregações.

```sql
SELECT id_turma, COUNT(*) AS quantidade
FROM matricula
WHERE situacao = 'ATIVA'
GROUP BY id_turma
HAVING COUNT(*) >= 3;
```

Evite usar `HAVING` para uma condição simples que poderia ser aplicada antes em `WHERE`.

## 7. DISTINCT em métricas

Um aluno pode cursar várias disciplinas. Para contar pessoas, não vínculos:

```sql
COUNT(DISTINCT m.id_aluno)
```

Pergunte sempre: a métrica representa linhas, matrículas, alunos ou turmas? `DISTINCT` não é um curativo universal; ele deve refletir a unidade real da medida.

## 8. Agregação condicional

```sql
SUM(CASE WHEN m.situacao = 'ATIVA' THEN 1 ELSE 0 END)
```

`CASE` transforma uma condição em 1 ou 0, permitindo várias métricas no mesmo agrupamento. `CASE` e `SUM` são construções SQL padrão.

## 9. Subconsultas

Uma subconsulta escalar retorna um único valor:

```sql
SELECT id_nota, valor
FROM nota
WHERE valor > (SELECT AVG(valor) FROM nota);
```

`EXISTS` testa a existência de pelo menos uma linha correlacionada:

```sql
SELECT a.id_aluno, a.nome
FROM aluno AS a
WHERE EXISTS (
    SELECT 1
    FROM matricula AS m
    WHERE m.id_aluno = a.id_aluno
      AND m.situacao = 'ATIVA'
);
```

Use `NOT EXISTS` para localizar ausências. Ele é geralmente mais seguro que `NOT IN` quando a subconsulta pode retornar `NULL`.

## 10. O perigo da multiplicação de linhas

Uma turma possui várias matrículas e várias avaliações. Juntar ambas simultaneamente pela turma cria todas as combinações. Na turma 1, 5 matrículas × 2 avaliações = 10 linhas.

Se o relatório contar matrículas e avaliações nessa mesma junção, ambas as métricas serão infladas. Soluções possíveis:

- agregar cada relação antes de uni-la;
- usar subconsultas independentes;
- usar `COUNT(DISTINCT ...)` somente quando isso corresponde à métrica;
- decompor um relatório complexo em etapas verificáveis.

Sempre inspecione as linhas antes de agregar.

## 11. Ordem lógica ampliada

Uma visão didática da ordem lógica é:

```text
FROM/JOIN → ON → WHERE → GROUP BY → HAVING → SELECT → DISTINCT → ORDER BY
```

Essa sequência ajuda a compreender por que uma linha removida no `WHERE` não participa da média e por que um alias criado em `SELECT` normalmente não pode ser usado no `WHERE`.

## 12. Portabilidade

São usados em forma padronizada: `INNER JOIN`, `LEFT JOIN`, `ON`, `GROUP BY`, `HAVING`, agregações, `CASE`, subconsultas e `EXISTS`.

Particularidades relevantes:

- `USE gestao_escolar` é específico do ecossistema MySQL nesta forma;
- `ROUND` existe em vários bancos, mas regras de tipos e arredondamento podem variar;
- MySQL não oferece `FULL OUTER JOIN` nativo;
- `ONLY_FULL_GROUP_BY` é um modo do MySQL que reforça agrupamentos válidos.

## 13. Prática guiada

1. Prepare a base até `03-inserir-dados.sql`.
2. Abra [06-relatorios-joins-agregacoes.sql](../../scripts/06-relatorios-joins-agregacoes.sql).
3. Antes de cada execução, desenhe o caminho entre as tabelas.
4. Execute primeiro sem agregação para observar a granularidade.
5. Compare com os [resultados esperados](resultados-esperados.md).
6. Resolva a [Atividade 09](../../../atividades/modulo-09/atividade-09-relatorios.md).
7. Consulte o gabarito somente após registrar sua tentativa.

## 14. Entrega com Git

```bash
git switch main
git pull origin main
git switch -c atividade/modulo-09-seu-nome

git status
git diff
git add sistema-gestao-escolar/atividades/modulo-09/
git commit -m "docs: conclui atividade do modulo 09"
git push -u origin atividade/modulo-09-seu-nome
```

Abra um Pull Request para `main`. Informe as consultas executadas, quantidades observadas e decisões de granularidade. Não envie dados pessoais ou credenciais.

## Erros frequentes

- esquecer ou errar a condição `ON`;
- filtrar a tabela direita no `WHERE` e transformar o efeito de um `LEFT JOIN`;
- contar `*` quando deveria contar a chave do filho;
- projetar colunas fora do `GROUP BY`;
- confundir `WHERE` com `HAVING`;
- contar matrículas quando a pergunta exige alunos distintos;
- agregar sem antes conferir a granularidade;
- usar `DISTINCT` apenas para esconder duplicidades.

## Checklist

- [ ] Consigo desenhar o caminho de chaves usado pela junção.
- [ ] Escolho conscientemente entre INNER e LEFT JOIN.
- [ ] Sei explicar filtros em ON, WHERE e HAVING.
- [ ] Conto a unidade correta da métrica.
- [ ] Preservo grupos sem filhos quando necessário.
- [ ] Reconheço multiplicação de linhas.
- [ ] Identifico recursos específicos do MySQL.

## Referências recomendadas

- ISO/IEC 9075 — SQL;
- documentação oficial do MySQL 8.0 — cláusula JOIN e funções agregadas;
- ELMASRI, R.; NAVATHE, S. B. *Sistemas de Banco de Dados*;
- SILBERSCHATZ, A.; KORTH, H.; SUDARSHAN, S. *Sistema de Banco de Dados*.
