# Gabarito — Módulo 14

A associação esperada é `Disciplina.hasMany(Turma)` e `Turma.belongsTo(Disciplina)`, com `id_disciplina`. A listagem pode usar `Aluno.findAll({ include: [{ model: Matricula, as: "matriculas" }] })`.

Casos transacionais devem produzir: 201 para matrícula válida; 409 para duplicidade, indisponibilidade e falta de vaga; rollback automático para qualquer exceção. A migration deve possuir `up` e `down`.

`sync({ force: true })` recria tabelas e pode destruir dados; migrations oferecem evolução explícita, revisável e reproduzível.
