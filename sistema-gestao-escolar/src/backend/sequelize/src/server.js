import express from "express";
import { sequelize, Aluno } from "./models.js";
import { matricular, BusinessError } from "./matricula-service.js";

const app = express();
app.use(express.json({ limit: "20kb" }));

app.get("/health", async (_req,res,next) => {
  try { await sequelize.authenticate(); res.json({ status: "ok", orm: "sequelize" }); } catch (e) { next(e); }
});
app.get("/alunos", async (_req,res,next) => {
  try { res.json(await Aluno.findAll({ order: [["nome","ASC"]], limit: 100 })); } catch (e) { next(e); }
});
app.post("/matriculas", async (req,res,next) => {
  try {
    const created = await matricular({ alunoId: req.body.aluno_id, turmaId: req.body.turma_id });
    res.status(201).json(created);
  } catch (e) { next(e); }
});
app.use((error,_req,res,_next) => {
  if (error instanceof BusinessError) return res.status(409).json({ error: error.message });
  console.error({ name: error.name, message: error.message });
  res.status(500).json({ error: "Erro interno" });
});
app.listen(Number(process.env.PORT || 3001));
