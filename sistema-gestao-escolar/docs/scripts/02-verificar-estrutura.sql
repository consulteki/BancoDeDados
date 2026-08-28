-- ============================================================================
-- Curso de Banco de Dados - Sistema de Gestao Escolar
-- Script: 02-verificar-estrutura.sql
-- Objetivo: conferir a estrutura criada no MySQL.
-- Pre-requisito: executar 00-criar-banco.sql e 01-criar-tabelas.sql.
-- ============================================================================
--
-- PORTABILIDADE:
-- SHOW e INFORMATION_SCHEMA seguem implementacoes com variacoes por SGBD.
-- As consultas abaixo foram preparadas para MySQL 8.
-- ============================================================================

USE gestao_escolar;

-- 1. Banco selecionado.
SELECT DATABASE() AS banco_atual;

-- 2. Tabelas do projeto.
SELECT
    table_name,
    engine,
    table_collation
FROM information_schema.tables
WHERE table_schema = 'gestao_escolar'
ORDER BY table_name;

-- 3. Colunas, tipos, nulidade e valores padrao.
SELECT
    table_name,
    ordinal_position,
    column_name,
    column_type,
    is_nullable,
    column_default,
    column_key,
    extra
FROM information_schema.columns
WHERE table_schema = 'gestao_escolar'
ORDER BY table_name, ordinal_position;

-- 4. Chaves estrangeiras.
SELECT
    kcu.table_name,
    kcu.constraint_name,
    kcu.column_name,
    kcu.referenced_table_name,
    kcu.referenced_column_name
FROM information_schema.key_column_usage AS kcu
WHERE kcu.table_schema = 'gestao_escolar'
  AND kcu.referenced_table_name IS NOT NULL
ORDER BY kcu.table_name, kcu.constraint_name, kcu.ordinal_position;

-- 5. Constraints declaradas.
SELECT
    table_name,
    constraint_name,
    constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'gestao_escolar'
ORDER BY table_name, constraint_type, constraint_name;

-- 6. Checks do esquema.
SELECT
    tc.table_name,
    tc.constraint_name,
    cc.check_clause
FROM information_schema.table_constraints AS tc
INNER JOIN information_schema.check_constraints AS cc
    ON cc.constraint_schema = tc.constraint_schema
   AND cc.constraint_name = tc.constraint_name
WHERE tc.constraint_schema = 'gestao_escolar'
  AND tc.constraint_type = 'CHECK'
ORDER BY tc.table_name, tc.constraint_name;

-- 7. Definicoes completas para inspecao manual.
SHOW CREATE TABLE aluno;
SHOW CREATE TABLE disciplina;
SHOW CREATE TABLE turma;
SHOW CREATE TABLE matricula;
SHOW CREATE TABLE nota;

-- Resultado esperado: nove tabelas.
SELECT COUNT(*) AS quantidade_tabelas
FROM information_schema.tables
WHERE table_schema = 'gestao_escolar'
  AND table_type = 'BASE TABLE';
