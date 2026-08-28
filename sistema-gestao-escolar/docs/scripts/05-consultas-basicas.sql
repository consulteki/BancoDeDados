-- ============================================================================
-- Curso de Banco de Dados - Sistema de Gestao Escolar
-- Modulo 8: consultas basicas
-- SGBD alvo: MySQL Community 8.0+
-- Pre-requisito: executar a criacao do banco, das tabelas e 03-inserir-dados.sql
-- Todos os comandos deste arquivo sao somente leitura.
-- ============================================================================

USE gestao_escolar;

-- 1. Todas as colunas: util para exploracao, evite em interfaces de producao.
SELECT *
FROM aluno;

-- 2. Projecao: retorna apenas as colunas necessarias.
SELECT matricula, nome, email
FROM aluno;

-- 3. Alias de coluna. AS pertence ao SQL padrao.
SELECT
    matricula AS codigo_aluno,
    nome AS nome_completo,
    situacao AS situacao_cadastral
FROM aluno;

-- 4. Filtro por igualdade.
SELECT id_aluno, matricula, nome
FROM aluno
WHERE situacao = 'ATIVO';

-- 5. Comparacoes numericas.
SELECT codigo, nome, carga_horaria
FROM curso
WHERE carga_horaria >= 180;

-- 6. AND: todas as condicoes precisam ser verdadeiras.
SELECT id_matricula, id_aluno, id_turma, situacao
FROM matricula
WHERE id_turma = 1
  AND situacao = 'ATIVA';

-- 7. OR com parenteses: evita ambiguidade na precedencia.
SELECT id_turma, codigo, periodo, situacao
FROM turma
WHERE periodo = '2026-2'
  AND (situacao = 'ABERTA' OR situacao = 'EM_ANDAMENTO');

-- 8. IN: alternativa legivel para varias igualdades.
SELECT id_avaliacao, titulo, situacao
FROM avaliacao
WHERE situacao IN ('ABERTA', 'PLANEJADA');

-- 9. BETWEEN inclui os dois limites.
SELECT id_avaliacao, titulo, data_avaliacao
FROM avaliacao
WHERE data_avaliacao BETWEEN '2026-08-01' AND '2026-08-31'
ORDER BY data_avaliacao;

-- 10. LIKE: % representa zero ou mais caracteres.
SELECT id_aluno, nome
FROM aluno
WHERE nome LIKE 'A%';

-- 11. _ representa exatamente um caractere.
SELECT codigo, nome
FROM disciplina
WHERE codigo LIKE 'BD-___';

-- 12. NULL nao e comparado com =. Use IS NULL ou IS NOT NULL.
SELECT id_aluno, nome, nome_social
FROM aluno
WHERE nome_social IS NOT NULL;

-- 13. Ordenacao por mais de uma coluna.
SELECT id_matricula, id_turma, data_matricula, id_aluno
FROM matricula
ORDER BY id_turma ASC, data_matricula ASC, id_aluno ASC;

-- 14. DISTINCT remove duplicidades da projecao.
SELECT DISTINCT situacao
FROM matricula
ORDER BY situacao;

-- 15. Expressao aritmetica calculada na consulta.
SELECT
    titulo,
    valor_maximo,
    peso,
    valor_maximo * peso AS contribuicao_maxima
FROM avaliacao
ORDER BY contribuicao_maxima DESC;

-- 16. COALESCE e SQL padrao: devolve o primeiro valor nao nulo.
SELECT
    matricula,
    nome,
    COALESCE(nome_social, nome) AS nome_exibicao
FROM aluno
ORDER BY nome_exibicao;

-- 17. CASE produz uma classificacao sem alterar os dados.
SELECT
    id_nota,
    valor,
    CASE
        WHEN valor >= 9.00 THEN 'DESTAQUE'
        WHEN valor >= 7.00 THEN 'SATISFATORIA'
        ELSE 'EM_RECUPERACAO'
    END AS faixa_desempenho
FROM nota
ORDER BY valor DESC;

-- 18. LIMIT e especifico do MySQL/PostgreSQL, nao do nucleo SQL ANSI.
SELECT id_aluno, matricula, nome
FROM aluno
ORDER BY id_aluno
LIMIT 3;

-- 19. Paginacao MySQL: segunda pagina, duas linhas por pagina.
-- Uma paginacao confiavel sempre precisa de ORDER BY deterministico.
SELECT id_aluno, matricula, nome
FROM aluno
ORDER BY id_aluno
LIMIT 2 OFFSET 2;

-- 20. Filtro por data usando intervalo semiaberto.
-- Esta forma evita problemas quando uma coluna futura armazenar data e hora.
SELECT id_avaliacao, titulo, data_avaliacao
FROM avaliacao
WHERE data_avaliacao >= '2026-08-01'
  AND data_avaliacao < '2026-09-01'
ORDER BY data_avaliacao;
