import { Transaction } from "sequelize";
import { sequelize, Turma, Matricula } from "./models.js";

export class BusinessError extends Error {}

export async function matricular({ alunoId, turmaId }) {
  return sequelize.transaction({
    isolationLevel: Transaction.ISOLATION_LEVELS.READ_COMMITTED
  }, async transaction => {
    const turma = await Turma.findByPk(turmaId, {
      transaction,
      lock: transaction.LOCK.UPDATE
    });
    if (!turma) throw new BusinessError("Turma não encontrada");
    if (!["ABERTA","EM_ANDAMENTO"].includes(turma.situacao)) throw new BusinessError("Turma indisponível");

    const existente = await Matricula.findOne({
      where: { id_aluno: alunoId, id_turma: turmaId, situacao: "ATIVA" },
      transaction,
      lock: transaction.LOCK.UPDATE
    });
    if (existente) throw new BusinessError("Aluno já possui matrícula ativa");

    const ocupadas = await Matricula.count({
      where: { id_turma: turmaId, situacao: "ATIVA" },
      transaction
    });
    if (turma.capacidade !== null && ocupadas >= turma.capacidade) throw new BusinessError("Turma sem vagas");

    return Matricula.create({
      id_aluno: alunoId,
      id_turma: turmaId,
      data_matricula: new Date().toISOString().slice(0,10),
      situacao: "ATIVA",
      forma_ingresso: "INSCRICAO"
    }, { transaction });
  });
}
