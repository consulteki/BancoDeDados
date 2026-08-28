# Módulo 10 — Índices, desempenho e planos de execução

## Objetivos de aprendizagem

Ao concluir este módulo, você deverá ser capaz de:

- explicar a finalidade e o custo de um índice;
- reconhecer índices criados por PK, UNIQUE e FK;
- propor índices simples e compostos a partir de consultas reais;
- aplicar a regra do prefixo esquerdo;
- interpretar os principais campos de `EXPLAIN`;
- diferenciar estimativas de execução real;
- reconhecer consultas não sargable;
- evitar índices redundantes e indexação excessiva.

## Conhecimentos prévios

- esquema físico do Módulo 6;
- DML e carga de dados;
- filtros, ordenação, junções e agregações;
- uso do MySQL Workbench.

## 1. O problema de desempenho

Uma consulta correta pode ficar lenta quando o volume cresce. Sem um caminho seletivo, o banco pode examinar muitas linhas para retornar poucas.

Um índice é uma estrutura auxiliar que organiza valores e referências às linhas. No InnoDB, a maior parte dos índices usa estruturas B-tree. A busca pode percorrer essa estrutura em vez de examinar toda a tabela.

Índice não é sinônimo de velocidade em qualquer situação. Ele:

- ocupa armazenamento;
- consome memória;
- precisa ser atualizado em inserções, alterações e exclusões;
- pode ser ignorado pelo otimizador;
- pode ser redundante com outro índice.

## 2. Índices já existentes

O projeto cria automaticamente ou exige índices associados a:

- chaves primárias;
- restrições `UNIQUE`;
- chaves estrangeiras no MySQL/InnoDB.

Antes de criar um índice, consulte os existentes:

```sql
SHOW INDEX FROM matricula;
```

`SHOW INDEX` é específico do MySQL. Outros SGBDs oferecem catálogos e comandos diferentes.

## 3. Seletividade e cardinalidade

A seletividade indica quanto um filtro reduz o conjunto. Uma matrícula única é muito seletiva; uma situação com apenas dois valores normalmente é pouco seletiva.

Um índice em `situacao` isoladamente pode não compensar. Entretanto, a combinação abaixo representa uma consulta real:

```sql
CREATE INDEX idx_matricula_turma_situacao_data
    ON matricula (id_turma, situacao, data_matricula);
```

A decisão deve partir das consultas, não de uma tentativa de indexar todas as colunas.

## 4. Índices compostos e prefixo esquerdo

Para um índice `(id_turma, situacao, data_matricula)`, os prefixos naturalmente aproveitáveis são:

- `id_turma`;
- `id_turma, situacao`;
- `id_turma, situacao, data_matricula`.

Uma consulta apenas por `situacao` ignora a primeira coluna e pode não usar o índice. A ordem das colunas deve considerar:

1. condições de igualdade;
2. condições de intervalo;
3. ordenação;
4. seletividade e frequência reais.

Não existe uma fórmula única; confirme com o plano.

## 5. Índice de cobertura

Um índice é de cobertura quando contém todas as informações necessárias à consulta. O banco pode responder sem acessar a linha completa.

Isso pode aparecer como `Using index` no campo `Extra` do MySQL. Acrescentar muitas colunas apenas para cobrir consultas aumenta o índice e o custo de escrita; use com critério.

## 6. EXPLAIN

```sql
EXPLAIN
SELECT id_matricula, id_aluno, data_matricula
FROM matricula
WHERE id_turma = 1
  AND situacao = 'ATIVA'
ORDER BY data_matricula;
```

Campos importantes do MySQL:

| Campo | Leitura inicial |
|---|---|
| `type` | forma de acesso; `ALL` indica varredura completa |
| `possible_keys` | índices candidatos |
| `key` | índice escolhido |
| `key_len` | parte do índice utilizada |
| `ref` | valor ou coluna usada na busca |
| `rows` | linhas estimadas |
| `filtered` | percentual estimado após filtros |
| `Extra` | informações como `Using index`, `Using where` ou `Using filesort` |

Não classifique um plano apenas pelo valor de `type`. Volume, quantidade retornada e custo total também importam.

## 7. EXPLAIN ANALYZE

No MySQL 8.0.18 ou superior:

```sql
EXPLAIN ANALYZE
SELECT ...
```

Diferentemente de `EXPLAIN`, esse comando executa a consulta e apresenta tempos e linhas observadas. Use com cuidado em comandos caros. A sintaxe e a apresentação são específicas do MySQL.

Estimativa diferente da realidade pode indicar estatísticas desatualizadas ou distribuição difícil de estimar.

## 8. Consultas sargable

Uma condição sargable permite ao otimizador transformar o predicado em um intervalo de busca.

Preferível:

```sql
WHERE data_avaliacao >= '2026-08-01'
  AND data_avaliacao <  '2026-09-01'
```

Potencialmente prejudicial:

```sql
WHERE YEAR(data_avaliacao) = 2026
  AND MONTH(data_avaliacao) = 8
```

A função atua sobre cada valor da coluna e pode impedir o uso do índice convencional. Além disso, `YEAR` e `MONTH` são funções do MySQL no uso apresentado.

## 9. Índices e ORDER BY

Um índice pode ajudar a localizar linhas e também evitar ordenação adicional quando sua ordem é compatível com filtros e `ORDER BY`. Contudo, direções, intervalos, junções e collation influenciam essa decisão.

`Using filesort` não significa necessariamente que o disco foi usado; significa que o MySQL precisou aplicar uma etapa de ordenação fora da ordem do índice.

## 10. Índices redundantes

Se existe um índice `(a, b, c)`, um índice separado em `(a)` pode ser redundante. Mas isso não pode ser decidido somente pela aparência:

- o índice menor ocupa menos espaço;
- restrições únicas possuem semântica própria;
- carga de leitura e escrita influencia a escolha;
- cada SGBD possui particularidades.

Use inventário, métricas e planos antes de remover.

## 11. Pequenas bases e escolhas do otimizador

Com cinco ou dez linhas, uma varredura completa pode ser mais barata. O laboratório não promete que o campo `key` sempre mostrará o índice recém-criado.

O objetivo é aprender a formular hipótese, medir, interpretar e justificar — não obrigar o banco a usar determinado índice.

## 12. Processo profissional de otimização

1. identifique uma consulta relevante e lenta;
2. registre dados, parâmetros e plano atual;
3. confirme a granularidade e evite retornar colunas desnecessárias;
4. verifique índices existentes;
5. formule uma hipótese;
6. crie o menor índice capaz de atendê-la;
7. atualize estatísticas quando necessário;
8. compare plano, tempo e linhas examinadas;
9. observe impacto nas escritas;
10. documente, monitore e reverta se não houver benefício.

## 13. Portabilidade

O conceito de índice e a análise de planos existem nos principais SGBDs, mas sua implementação não é uniformizada pelo núcleo SQL ANSI.

São particularidades do MySQL utilizadas:

- `SHOW INDEX`;
- formato de `EXPLAIN`;
- `EXPLAIN ANALYZE`;
- `ANALYZE TABLE`;
- `DROP INDEX nome ON tabela`;
- commits implícitos de DDL;
- detalhes do InnoDB.

Os scripts identificam essas diferenças explicitamente.

## 14. Prática guiada

1. prepare a base até `03-inserir-dados.sql`;
2. execute [07-diagnostico-desempenho.sql](../../scripts/07-diagnostico-desempenho.sql);
3. preencha a etapa “antes” do [roteiro de experimento](roteiro-experimento.md);
4. execute [08-criar-indices-laboratorio.sql](../../scripts/08-criar-indices-laboratorio.sql) uma única vez;
5. repita os planos e preencha a etapa “depois”;
6. resolva a [Atividade 10](../../../atividades/modulo-10/atividade-10-indices.md);
7. consulte o gabarito somente após concluir a análise.

## 15. Entrega com Git

```bash
git switch main
git pull origin main
git switch -c atividade/modulo-10-seu-nome

git status
git diff
git add sistema-gestao-escolar/atividades/modulo-10/
git commit -m "docs: conclui atividade do modulo 10"
git push -u origin atividade/modulo-10-seu-nome
```

Abra um Pull Request para `main` e anexe a ficha preenchida. Registre inclusive resultados que contrariem sua hipótese.

## Erros frequentes

- criar um índice para cada coluna;
- duplicar índices já cobertos por PK ou UNIQUE;
- interpretar `ALL` como erro automático;
- usar somente tempo de uma execução;
- testar com cache, volume e parâmetros não representativos;
- forçar índice sem medir;
- ignorar o custo de escrita;
- acreditar que `ROLLBACK` desfaz `CREATE INDEX` no MySQL.

## Checklist

- [ ] Consultei os índices existentes.
- [ ] Parti de uma consulta real.
- [ ] Expliquei a ordem do índice composto.
- [ ] Comparei planos antes e depois.
- [ ] Diferenciei estimativa de execução real.
- [ ] Reconheci limitações da base pequena.
- [ ] Registrei custos e benefícios.

## Referências recomendadas

- documentação oficial do MySQL 8.0 — Optimization e EXPLAIN;
- ELMASRI, R.; NAVATHE, S. B. *Sistemas de Banco de Dados*;
- SILBERSCHATZ, A.; KORTH, H.; SUDARSHAN, S. *Sistema de Banco de Dados*;
- USE THE INDEX, LUKE. Guia de indexação e desempenho SQL.
