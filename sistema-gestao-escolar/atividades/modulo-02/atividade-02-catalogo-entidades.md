# Atividade 02 — Catálogo preliminar de entidades

## Objetivo

Identificar e documentar entidades, atributos, domínios, identificadores e regras de negócio do Sistema de Gestão Escolar antes da construção do modelo entidade-relacionamento.

## Parte A — Classificação conceitual

Classifique e justifique:

| Item | Classificação | Justificativa |
|---|---|---|
| Aluno | | |
| Nome do aluno | | |
| Matrícula | | |
| Data da matrícula | | |
| Média final | | |
| Relatório de reprovados | | |
| Botão “Cadastrar” | | |
| Professor | | |
| Nota entre 0 e 10 | | |
| Telefone do aluno | | |

Classificações possíveis: entidade, atributo, regra de negócio, resultado de consulta ou elemento da solução.

## Parte B — Catálogo

Preencha a ficha do módulo para:

1. Aluno;
2. Professor;
3. Curso;
4. Disciplina;
5. Turma;
6. Matrícula.

Para cada entidade, informe no mínimo:

- definição;
- duas ocorrências fictícias;
- identificador técnico proposto;
- chave natural candidata, se houver;
- cinco atributos, quando aplicável;
- domínio e obrigatoriedade;
- três regras de negócio;
- dois relacionamentos percebidos;
- duas dúvidas para validação.

## Parte C — Identificadores

Responda:

1. Por que CPF não deve ser adotado automaticamente como chave primária de Aluno?
2. Uma chave substituta elimina a necessidade de `UNIQUE` sobre matrícula institucional? Justifique.
3. Em que situação aluno + turma poderia formar chave composta de Matrícula?
4. O que aconteceria se a matrícula institucional pudesse mudar?
5. Quais critérios devem orientar a escolha de um identificador?

## Parte D — Qualidade das regras

Reescreva as regras vagas:

1. “O cadastro deve estar correto.”
2. “A nota tem que ser válida.”
3. “Não pode matricular errado.”
4. “Somente pessoas autorizadas podem alterar.”
5. “A turma deve ter professor.”

As novas regras devem ser verificáveis e indicar o objeto afetado.

## Parte E — Atributos problemáticos

Analise:

- `nome_endereco_telefone`;
- `telefones`;
- `idade`;
- `situacao` sem domínio;
- `observacao` usada para registrar qualquer dado;
- `cpf` obrigatório sem validação da necessidade.

Para cada item, explique o problema e proponha encaminhamento.

## Parte F — Reflexão

Escolha uma entidade e explique:

- o que aconteceria se ela não tivesse identificador;
- quais dados seriam realmente necessários;
- quais atributos poderiam ser derivados;
- quais regras pertencem ao banco, à aplicação ou a ambos;
- quais decisões ainda dependem da instituição.

## Entrega

Crie:

```text
sistema-gestao-escolar/atividades/modulo-02/catalogo-seu-nome.md
```

Versione:

```bash
git status
git diff
git add sistema-gestao-escolar/atividades/modulo-02/
git commit -m "docs: elabora catalogo preliminar de entidades"
git push -u origin atividade/modulo-02-seu-nome
```

Abra um Pull Request informando:

- entidades catalogadas;
- principais decisões;
- regras ainda não validadas;
- dúvidas encontradas.

## Critérios

| Critério | Peso |
|---|---:|
| Classificação conceitual | 15% |
| Catálogo das entidades | 30% |
| Análise dos identificadores | 20% |
| Reescrita das regras | 15% |
| Análise dos atributos | 10% |
| Organização e Git | 10% |
