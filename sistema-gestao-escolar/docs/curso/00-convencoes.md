# Convenções do projeto

## 1. Finalidade

Estas convenções tornam os exemplos previsíveis, portáveis e fáceis de revisar. O curso privilegia clareza didática antes de otimizações prematuras.

## 2. Nomes de pastas e arquivos

- Usar letras minúsculas.
- Separar palavras com hífen em documentos: `modelo-logico.md`.
- Usar nomes descritivos.
- Manter códigos em `src/`.
- Manter scripts SQL em `docs/scripts/`, conforme a organização do curso.
- Não versionar senhas, tokens ou arquivos `.env`.

## 3. Convenções SQL

| Elemento | Convenção | Exemplo |
|---|---|---|
| Tabela | singular e snake_case | `aluno`, `turma_professor` |
| Coluna | snake_case | `data_nascimento` |
| Chave primária | `id_<tabela>` | `id_aluno` |
| Chave estrangeira | mesmo nome da PK referenciada | `id_curso` |
| Restrição | prefixo + tabelas/colunas | `fk_matricula_aluno` |
| Índice | `idx_<tabela>_<colunas>` | `idx_aluno_nome` |

Palavras-chave SQL serão escritas em maiúsculas para melhorar a leitura:

```sql
SELECT id_aluno, nome
FROM aluno
WHERE situacao = 'ATIVO'
ORDER BY nome;
```

### Portabilidade

Priorizar recursos amplamente suportados. Quando houver extensão específica do MySQL, identificá-la em comentário:

```sql
-- MySQL: AUTO_INCREMENT é específico do SGBD.
id_aluno INTEGER NOT NULL AUTO_INCREMENT
```

## 4. Convenções JavaScript

- Usar `camelCase` para variáveis e funções.
- Usar `PascalCase` para classes e models.
- Preferir `const`; usar `let` quando houver reatribuição.
- Não usar `var`.
- Separar rotas, controllers, services e acesso a dados.
- Não colocar credenciais diretamente no código.
- Tratar erros de operações assíncronas.
- Validar dados no cliente e novamente no servidor.

## 5. API REST

| Operação | Método | Rota |
|---|---|---|
| Listar alunos | GET | `/api/alunos` |
| Consultar aluno | GET | `/api/alunos/:id` |
| Cadastrar aluno | POST | `/api/alunos` |
| Atualizar aluno | PUT/PATCH | `/api/alunos/:id` |
| Remover aluno | DELETE | `/api/alunos/:id` |

Respostas devem empregar códigos HTTP coerentes e JSON previsível.

## 6. Segurança básica

- Usar `.env.example` somente com nomes das variáveis.
- Incluir `.env` no `.gitignore`.
- Usar usuário de banco com privilégios mínimos.
- Nunca concatenar entrada do usuário em SQL.
- Usar parâmetros, prepared statements ou ORM.
- Não expor mensagens internas ou credenciais em respostas da API.
- Validar tipo, formato, tamanho e obrigatoriedade dos campos.

## 7. Commits e branches

Branches:

- `atividade/modulo-01-nome`
- `feature/crud-alunos`
- `fix/matricula-duplicada`
- `docs/modelo-logico`

Commits:

```text
docs: documenta regras de matricula
feat: implementa cadastro de alunos
fix: impede matricula duplicada
test: valida criacao de curso
```

## 8. Definição de pronto

Um artefato está pronto quando:

- atende ao enunciado;
- pode ser reproduzido por outra pessoa;
- contém instruções de execução;
- não possui credenciais;
- mantém nomenclatura consistente;
- foi revisado com `git diff`;
- possui commit descritivo;
- apresenta evidência de teste.
