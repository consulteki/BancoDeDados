-- ============================================================================
-- Curso de Banco de Dados - Sistema de Gestao Escolar
-- Script: 00-criar-banco.sql
-- Objetivo: criar o banco e selecionar o esquema de trabalho.
-- SGBD alvo: MySQL Community 8.0+
-- ============================================================================
--
-- PORTABILIDADE:
-- CREATE DATABASE, CHARACTER SET e COLLATE possuem variacoes entre SGBDs.
-- utf8mb4_0900_ai_ci e especifico do MySQL 8.
--
-- SEGURANCA:
-- Execute em ambiente didatico autorizado. O usuario precisa de privilegio
-- CREATE. Em producao, criacao de banco costuma ser atividade administrativa.
-- ============================================================================

CREATE DATABASE IF NOT EXISTS gestao_escolar
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

USE gestao_escolar;

-- Confirmacao do banco selecionado.
SELECT DATABASE() AS banco_atual;
