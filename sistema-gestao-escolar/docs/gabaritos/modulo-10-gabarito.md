# Gabarito — Módulo 10

## Solução orientadora

### 1 e 2. Inventário

```sql
SHOW INDEX FROM matricula;
SHOW INDEX FROM aluno;
SHOW INDEX FROM avaliacao;
```

Devem ser reconhecidos:

- índices primários das PKs;
- índices únicos das restrições `UNIQUE`;
- índices exigidos para FKs pelo InnoDB;
- índices adicionais do laboratório, caso ainda existam.

Os nomes e a cardinalidade mostrados podem variar conforme a versão e as estatísticas.

### 3 e 4. Plano inicial

```sql
EXPLAIN
SELECT id_matricula, id_aluno, data_matricula
FROM matricula
WHERE id_turma = 1
  AND situacao = 'ATIVA'
ORDER BY data_matricula;
```

Não existe um único valor obrigatório para `type`, `key` ou `rows`. Com oito matrículas, o otimizador pode escolher varredura completa. A avaliação deve considerar se o estudante registrou e interpretou o plano real.

### 5 e 6. Índice proposto

```sql
CREATE INDEX idx_matricula_turma_situacao_data
    ON matricula (id_turma, situacao, data_matricula);
```

Justificativa:

1. `id_turma`: igualdade e recorte principal;
2. `situacao`: segunda igualdade;
3. `data_matricula`: ordem solicitada após as igualdades.

### 7. Estatísticas e novo plano

```sql
ANALYZE TABLE matricula;

EXPLAIN
SELECT id_matricula, id_aluno, data_matricula
FROM matricula
WHERE id_turma = 1
  AND situacao = 'ATIVA'
ORDER BY data_matricula;
```

Mesmo após isso, o índice pode não ser escolhido porque ler oito linhas é barato. O índice deve ser reavaliado com volume e distribuição representativos.

### 9. Prefixo esquerdo

```sql
-- Aproveita o primeiro prefixo.
SELECT id_matricula
FROM matricula
WHERE id_turma = 1;

-- Aproveita os dois primeiros componentes.
SELECT id_matricula
FROM matricula
WHERE id_turma = 1
  AND situacao = 'ATIVA';

-- Ignora a primeira coluna; pode não aproveitar o índice composto.
SELECT id_matricula
FROM matricula
WHERE situacao = 'ATIVA';
```

### 10. Sargabilidade

Evitar:

```sql
WHERE YEAR(data_avaliacao) = 2026
  AND MONTH(data_avaliacao) = 8
```

Preferir:

```sql
WHERE data_avaliacao >= '2026-08-01'
  AND data_avaliacao <  '2026-09-01'
```

### 11. Custos

Respostas possíveis:

- armazenamento adicional;
- maior consumo de cache;
- manutenção durante INSERT, UPDATE e DELETE;
- mais trabalho para estatísticas;
- maior complexidade de administração;
- possibilidade de planos ruins com índices redundantes.

### 12. Redundância hipotética

Um índice isolado em `aluno(matricula)` seria redundante porque `uq_aluno_matricula` já cria um índice único iniciando pela mesma coluna. A restrição única também possui significado de integridade que um índice comum não substitui.

### 13. Limpeza

```sql
DROP INDEX idx_matricula_turma_situacao_data ON matricula;

SHOW INDEX FROM matricula;
```

A correção só deve remover o índice efetivamente criado pelo estudante.

## Avaliação do desafio

Não se deve exigir a criação de um índice. Uma recomendação profissional pode concluir que:

- o índice existente já é suficiente;
- a consulta retorna grande parte da tabela;
- o volume não justifica o custo;
- a consulta é rara;
- a proposta precisa ser validada com dados representativos.

O valor da resposta está no processo de investigação, nas evidências e na capacidade de reversão.
