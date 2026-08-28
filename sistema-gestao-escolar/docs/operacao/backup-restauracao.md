# Backup e restauração

## Backup lógico

```bash
mysqldump --host=127.0.0.1 --port=3306 --user=backup_user \
  --single-transaction --routines --triggers --events \
  gestao_escolar > gestao_escolar_YYYYMMDD.sql
```

Não coloque senha na linha de comando ou no script. Use mecanismo seguro de credenciais.

## Restauração em base de teste

```bash
mysql --host=127.0.0.1 --user=restore_user \
  gestao_escolar_restore < gestao_escolar_YYYYMMDD.sql
```

## Validação obrigatória

1. verifique código de saída e tamanho;
2. armazene de forma criptografada e com acesso restrito;
3. aplique política de retenção;
4. restaure periodicamente em ambiente isolado;
5. compare contagens e constraints;
6. registre responsável, data, resultado e tempo;
7. nunca considere um backup válido sem teste de restauração.

Em produção, RPO, RTO, binlogs, snapshots e redundância precisam de desenho específico.
