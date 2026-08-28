# Catálogo da carga de dados

O arquivo [03-inserir-dados.sql](../../scripts/03-inserir-dados.sql) cria uma base pequena e coerente para os exercícios do curso. Todos os nomes e contatos são fictícios.

## Quantidades esperadas

| Tabela | Linhas | Papel no cenário |
|---|---:|---|
| `curso` | 2 | Ofertas formativas |
| `disciplina` | 3 | Componentes de cada curso |
| `professor` | 3 | Docentes disponíveis |
| `aluno` | 5 | Estudantes cadastrados |
| `turma` | 3 | Ofertas de disciplinas |
| `turma_professor` | 4 | Alocações docentes |
| `matricula` | 8 | Vínculos entre aluno e turma |
| `avaliacao` | 4 | Instrumentos avaliativos |
| `nota` | 7 | Resultados já lançados |

## Por que os IDs são explícitos?

Nesta carga didática, IDs fixos tornam os relacionamentos fáceis de acompanhar e deixam os gabaritos reproduzíveis. Em uma aplicação real, o banco gera o identificador e o código recupera o valor criado.

## Ordem de inserção

Os registros pais precisam existir antes dos filhos:

1. curso, disciplina, professor e aluno;
2. turma;
3. turma_professor e matricula;
4. avaliacao;
5. nota.

A exclusão física segue a ordem inversa. Como este projeto preserva histórico, normalmente é melhor atualizar a situação do registro do que apagá-lo.

## Verificação

O final do script retorna uma linha por tabela com sua contagem. Compare o resultado com a tabela acima. Se houver divergência, recrie o banco e repita os scripts na ordem documentada; a carga usa IDs e chaves únicas e foi projetada para uma base limpa.
