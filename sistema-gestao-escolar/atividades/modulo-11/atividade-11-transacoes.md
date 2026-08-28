# Atividade 11 — Matrícula concorrente

1. Descreva a unidade atômica de matrícula.
2. Implemente a matrícula do aluno 5 na turma 2 dentro de uma transação.
3. Valide turma aberta/em andamento, vaga e ausência de matrícula ativa.
4. Use `FOR UPDATE` na linha da turma.
5. Crie um `SAVEPOINT` antes da inserção e demonstre `ROLLBACK TO SAVEPOINT`.
6. Em duas sessões, reproduza uma espera por bloqueio.
7. Explique os quatro principais fenômenos de concorrência.
8. Reproduza o deadlock controlado e identifique a transação vítima.
9. Proponha uma política de repetição segura na futura API.
10. Termine todos os experimentos com `ROLLBACK`.

## Avaliação

| Critério | Pontos |
|---|---:|
| Unidade atômica e validações | 2,0 |
| Transação e savepoint | 2,0 |
| Bloqueio em duas sessões | 2,0 |
| Concorrência e deadlock | 2,0 |
| Segurança, limpeza e justificativa | 2,0 |
| **Total** | **10,0** |
