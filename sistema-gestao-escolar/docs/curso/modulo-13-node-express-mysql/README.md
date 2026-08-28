# Módulo 13 — Node.js, Express, HTTP e acesso seguro ao MySQL

## Objetivos

- compreender cliente, servidor, API e banco;
- mapear CRUD para HTTP;
- usar pool de conexões e consultas parametrizadas;
- validar entradas e padronizar erros;
- separar configuração de código.

## Mapeamento

| Ação | Método e rota | Resposta |
|---|---|---|
| listar | GET /alunos | 200 |
| detalhar | GET /alunos/:id | 200 ou 404 |
| criar | POST /alunos | 201 ou 422/409 |
| substituir | PUT /alunos/:id | 200 ou 404 |
| excluir | DELETE /alunos/:id | 204 ou 404/409 |

A API usa `mysql2/promise`, pool limitado e placeholders `?`. Nunca concatene valores recebidos na instrução SQL.

## Preparação

Crie um usuário com apenas os privilégios necessários:

```sql
CREATE USER 'gestao_app'@'localhost' IDENTIFIED BY 'uma_senha_forte';
GRANT SELECT, INSERT, UPDATE, DELETE ON gestao_escolar.* TO 'gestao_app'@'localhost';
```

Esses comandos e a administração de usuários são específicos do MySQL. Não reutilize conta administrativa na aplicação.

```bash
cd sistema-gestao-escolar/src/backend/mysql2
cp .env.example .env
npm install
npm run dev
```

Edite o `.env` local e nunca o envie ao Git. Teste `GET http://localhost:3000/health`.

## Segurança essencial

- credenciais fora do código;
- SQL parametrizado;
- limite de JSON;
- CORS restrito;
- headers com Helmet;
- validação também no servidor;
- mensagens públicas sem detalhes internos;
- logs sem senha ou dados pessoais.

## Limitação pedagógica

O exemplo concentra as rotas em um arquivo para facilitar a leitura. Um projeto maior deve separar rotas, controladores, serviços e repositórios. O próximo módulo introduz essa evolução com Sequelize.

## Atividade

Resolva a [Atividade 13](../../../atividades/modulo-13/atividade-13-api.md) e teste com curl, Insomnia, Postman ou cliente equivalente.

## Git

```bash
git switch -c atividade/modulo-13-seu-nome
git add sistema-gestao-escolar/src/backend/mysql2
git commit -m "feat: conclui api mysql2 do modulo 13"
git push -u origin atividade/modulo-13-seu-nome
```
