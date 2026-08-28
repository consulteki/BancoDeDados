# Gabarito comentado — Módulo 6

## Parte A — Preparação

Esperar ambiente reproduzível, versões e ausência de credenciais. MySQL deve ser 8.0.16+ para enforcement consistente dos CHECKs usados.

## Parte B — Execução

Resultado esperado:

- banco: `gestao_escolar`;
- nove tabelas: aluno, professor, curso, disciplina, turma, turma_professor, matricula, avaliacao e nota;
- engine: InnoDB;
- charset/collation definidos pelo script.

Erros aceitáveis somente se diagnosticados, como tabela já existente ou versão incompatível. Não aceitar exclusão indiscriminada como primeira solução.

## Parte C — Exemplos

### ALUNO

- PK: id_aluno;
- UQ: matricula e email;
- CHECK: nome e situação;
- nulos: nome_social, data_nascimento e email.

### DISCIPLINA

- PK: id_disciplina;
- UQ: id_curso + codigo;
- FK: id_curso;
- CHECK: nome, carga horária e situação.

### NOTA

- PK: id_nota;
- UQ: id_matricula + id_avaliacao;
- FKs: matrícula e avaliação;
- CHECK: valor não negativo.

## Parte D — Portabilidade

| Recurso | Classificação |
|---|---|
| PRIMARY KEY | amplamente padronizado |
| FOREIGN KEY | amplamente padronizado, ações podem variar |
| AUTO_INCREMENT | específico do MySQL |
| ENGINE=InnoDB | específico do MySQL |
| utf8mb4_0900_ai_ci | específico do MySQL |
| CHECK | padrão, histórico de suporte varia |
| CURRENT_TIMESTAMP | padrão com diferenças de comportamento |
| SHOW CREATE TABLE | específico/variável |

Em PostgreSQL, IDs podem usar `GENERATED ... AS IDENTITY`; SQL Server usa `IDENTITY`; Oracle pode usar identity/sequence.

## Parte E — Testes negativos

Falhas esperadas:

1. `ck_curso_carga_horaria`;
2. `ck_aluno_situacao`;
3. `ck_turma_capacidade`;
4. `fk_disciplina_curso`;
5. `ck_nota_valor_nao_negativo`;
6. `uq_nota_matricula_avaliacao`.

O estudante deve demonstrar que nenhuma linha inválida permaneceu.

## Parte F — Análise

1. AUTO_INCREMENT não pertence ao SQL portável e possui sintaxe/comportamento do MySQL.
2. São identificadores/textos, podem ter zeros e não sofrem aritmética.
3. ENUM acopla domínio ao MySQL e torna alterações/migração menos flexíveis.
4. Nomes tornam erros, ALTER e migrations compreensíveis.
5. RESTRICT protege histórico e exige decisão explícita.
6. CHECK não consulta outra tabela; valor máximo está em AVALIACAO.
7. Pode exigir transação e consulta com bloqueio, coluna/estrutura de vigência, índice funcional ou desenho alternativo; UNIQUE simples não representa “somente ativa” mantendo histórico.
8. CREATE/ALTER podem confirmar transação automaticamente e não ser desfeitos por ROLLBACK comum.

## Parte G — ALTER

Solução plausível:

```sql
ALTER TABLE curso
    ADD COLUMN descricao VARCHAR(1000) NULL;
```

Reversão:

```sql
ALTER TABLE curso
    DROP COLUMN descricao;
```

A reversão é destrutiva se houver dados. Antes disso, exportar/migrar valores. Tornar NOT NULL exige plano para linhas existentes e regra confirmada.

## Questões técnicas adicionais

### Nota e valor máximo

Validar na camada de serviço dentro da operação. Trigger é possível, mas adiciona lógica no banco e precisa de documentação/teste. A decisão virá em módulo posterior.

### Matrícula ativa

MySQL não possui índice parcial com `WHERE situacao='ATIVA'` como PostgreSQL. Opções exigem desenho cuidadoso. Não aceitar apenas remoção do histórico.

### CHECK de data futura

Evitar função não determinística em CHECK. A regra pode ser validada pela aplicação/serviço e testes, conforme necessidade.

## Rubrica

| Nível | Evidência |
|---|---|
| Excelente | scripts executados, metadados conferidos, falhas esperadas interpretadas e portabilidade discutida |
| Satisfatório | estrutura criada e testes principais documentados |
| Insuficiente | apenas captura de tela, constraints desativadas ou credenciais expostas |

## Sinais de atenção

- senha em arquivo;
- execução como root tratada como padrão de produção;
- uso de CASCADE sem análise;
- correção de erro removendo constraint;
- dependência do Workbench confundida com servidor;
- screenshots sem SQL e interpretação;
- DROP executado sem confirmar alvo.
