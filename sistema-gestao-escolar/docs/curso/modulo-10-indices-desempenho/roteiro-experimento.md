# Roteiro de experimento com índices

## Objetivo

Comparar planos de execução antes e depois da criação de índices, sem confundir uma decisão do otimizador com uma regra absoluta.

## Sequência

1. recrie a base e carregue os dados;
2. execute `07-diagnostico-desempenho.sql`;
3. registre os planos das consultas 3, 4 e 5;
4. execute `08-criar-indices-laboratorio.sql` uma única vez;
5. repita os planos;
6. compare os campos;
7. justifique se o índice foi ou não escolhido;
8. use a limpeza opcional caso queira repetir.

## Ficha de observação

| Consulta | Etapa | type | possible_keys | key escolhido | rows | Extra | Interpretação |
|---|---|---|---|---|---:|---|---|
| Matrículas | Antes |  |  |  |  |  |  |
| Matrículas | Depois |  |  |  |  |  |  |
| Alunos | Antes |  |  |  |  |  |  |
| Alunos | Depois |  |  |  |  |  |  |
| Avaliações | Antes |  |  |  |  |  |  |
| Avaliações | Depois |  |  |  |  |  |  |

## Como interpretar sem conclusões precipitadas

A carga didática possui poucas linhas. Ler toda a tabela pode custar menos do que navegar pelo índice e depois buscar as linhas. Portanto, o resultado correto do experimento pode ser “o índice existe, mas o otimizador preferiu não usá-lo”.

Não force índices apenas para produzir um plano esperado. Em um ambiente real, a decisão deve considerar:

- volume e distribuição dos dados;
- frequência da consulta;
- quantidade de linhas retornadas;
- custo de escrita;
- memória e armazenamento;
- medições representativas.

## Evidências para entrega

- captura ou transcrição dos planos;
- tabela de observação preenchida;
- explicação do prefixo esquerdo;
- comparação entre consulta sargable e consulta com função na coluna;
- justificativa sobre a utilidade de cada índice;
- confirmação da limpeza, se executada.
