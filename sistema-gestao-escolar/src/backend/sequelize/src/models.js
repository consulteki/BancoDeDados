import { Sequelize, DataTypes } from "sequelize";
import "dotenv/config";

export const sequelize = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASSWORD, {
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT || 3306),
  dialect: "mysql",
  logging: false,
  pool: { max: 10, min: 0, acquire: 30000, idle: 10000 }
});

export const Aluno = sequelize.define("Aluno", {
  id_aluno: { type: DataTypes.BIGINT, primaryKey: true, autoIncrement: true },
  matricula: { type: DataTypes.STRING(30), allowNull: false, unique: true },
  nome: { type: DataTypes.STRING(150), allowNull: false },
  nome_social: DataTypes.STRING(150),
  email: { type: DataTypes.STRING(254), validate: { isEmail: true } },
  situacao: { type: DataTypes.STRING(20), allowNull: false }
}, { tableName: "aluno", timestamps: false });

export const Turma = sequelize.define("Turma", {
  id_turma: { type: DataTypes.BIGINT, primaryKey: true, autoIncrement: true },
  id_disciplina: { type: DataTypes.BIGINT, allowNull: false },
  codigo: { type: DataTypes.STRING(30), allowNull: false },
  capacidade: DataTypes.INTEGER,
  situacao: { type: DataTypes.STRING(20), allowNull: false }
}, { tableName: "turma", timestamps: false });

export const Matricula = sequelize.define("Matricula", {
  id_matricula: { type: DataTypes.BIGINT, primaryKey: true, autoIncrement: true },
  id_aluno: { type: DataTypes.BIGINT, allowNull: false },
  id_turma: { type: DataTypes.BIGINT, allowNull: false },
  data_matricula: { type: DataTypes.DATEONLY, allowNull: false },
  situacao: { type: DataTypes.STRING(20), allowNull: false },
  forma_ingresso: DataTypes.STRING(30)
}, { tableName: "matricula", timestamps: false });

Aluno.hasMany(Matricula, { foreignKey: "id_aluno", as: "matriculas" });
Matricula.belongsTo(Aluno, { foreignKey: "id_aluno", as: "aluno" });
Turma.hasMany(Matricula, { foreignKey: "id_turma", as: "matriculas" });
Matricula.belongsTo(Turma, { foreignKey: "id_turma", as: "turma" });
