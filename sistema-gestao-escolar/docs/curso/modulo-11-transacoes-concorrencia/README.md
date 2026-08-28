# Módulo 11 — Transações, concorrência e integridade

## Objetivos

- aplicar ACID a operações escolares;
- usar `START TRANSACTION`, `COMMIT`, `ROLLBACK` e `SAVEPOINT`;
- compreender autocommit e confirmação implícita;
- reconhecer dirty read, non-repeatable read, phantom read e atualização perdida;
- usar bloqueio pessimista com `SELECT ... FOR UPDATE`;
- tratar deadlocks e manter transações curtas.

## 1. Unidade de trabalho

Matricular um aluno não é apenas inserir uma linha. É necessário validar turma, situação, vaga e duplicidade. Ou todas as etapas são confirmadas, ou nenhuma deve permanecer.

ACID:

| Propriedade | Aplicação |
|---|---|
| Atomicidade | todas as etapas confirmam ou desfazem |
| Consistência | constraints e regras permanecem válidas |
| Isolamento | transações concorrentes não corrompem a decisão |
| Durabilidade | após COMMIT, a alteração sobrevive a falhas |

## 2. Controle básico

```sql
START TRANSACTION;
UPDATE ...;
SAVEPOINT etapa_validada;
INSERT ...;
COMMIT; -- ou ROLLBACK
```

No MySQL, DDL pode provocar `COMMIT` implícito. Não misture `CREATE TABLE` ou `CREATE INDEX` a uma unidade DML que pretende desfazer.

## 3. Concorrência

| Fenômeno | Descrição |
|---|---|
| Dirty read | leitura de alteração não confirmada |
| Non-repeatable read | a mesma linha muda entre leituras |
| Phantom read | novas linhas aparecem em uma repetição |
| Lost update | uma atualização sobrescreve outra |

O isolamento reduz fenômenos, mas pode aumentar espera e contenção. MySQL/InnoDB usa `REPEATABLE READ` como padrão; a aplicação não deve depender de um padrão não documentado.

## 4. Bloqueios

```sql
SELECT id_turma, capacidade
FROM turma
WHERE id_turma = ?
FOR UPDATE;
```

O bloqueio pertence à transação e à conexão. Ele só protege a decisão quando todas as operações relacionadas usam a mesma conexão.

## 5. Deadlocks

Deadlock é um ciclo de espera. O banco escolhe uma transação como vítima. Aplicações profissionais:

- mantêm ordem consistente de bloqueios;
- reduzem a duração das transações;
- tratam o erro;
- repetem a operação quando ela é idempotente e segura;
- registram contexto sem expor dados sensíveis.

## 6. Regra de matrícula

A restrição UNIQUE atual preserva histórico por data, mas não garante sozinha “somente uma matrícula ativa por aluno e turma”. Essa regra exige combinação de transação, consulta bloqueante e camada de serviço. No módulo Sequelize será implementada na aplicação.

## 7. Prática

1. execute [09-matricula-transacional.sql](../../scripts/09-matricula-transacional.sql);
2. confirme que o `ROLLBACK` preserva a carga;
3. abra duas conexões e siga [10-concorrencia-duas-sessoes.sql](../../scripts/10-concorrencia-duas-sessoes.sql);
4. resolva a [Atividade 11](../../../atividades/modulo-11/atividade-11-transacoes.md).

## Portabilidade

Transações e níveis de isolamento são conceitos padronizados. `FOR UPDATE`, autocommit, diagnóstico de deadlock e detalhes de bloqueio variam. `SHOW ENGINE INNODB STATUS` e `ROW_COUNT()` são específicos do MySQL.

## Entrega Git

```bash
git switch -c atividade/modulo-11-seu-nome
git add sistema-gestao-escolar/atividades/modulo-11/
git commit -m "docs: conclui atividade do modulo 11"
git push -u origin atividade/modulo-11-seu-nome
```

## Checklist

- [ ] Delimitei a unidade de trabalho.
- [ ] Sei quando usar COMMIT ou ROLLBACK.
- [ ] Mantive a mesma conexão durante a transação.
- [ ] Reproduzi um bloqueio em duas sessões.
- [ ] Sei que deadlock deve ser tratado.
