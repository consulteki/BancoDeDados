import "dotenv/config";
import express from "express";
import cors from "cors";
import helmet from "helmet";
import { pool } from "./db.js";

const app = express();
app.use(helmet());
app.use(cors({ origin: process.env.CORS_ORIGIN || false }));
app.use(express.json({ limit: "20kb" }));

const studentFields = "id_aluno, matricula, nome, nome_social, email, situacao";

function validateStudent(body, partial = false) {
  const errors = [];
  if (!partial || body.matricula !== undefined) {
    if (typeof body.matricula !== "string" || !body.matricula.trim()) errors.push("matricula é obrigatória");
  }
  if (!partial || body.nome !== undefined) {
    if (typeof body.nome !== "string" || body.nome.trim().length < 2) errors.push("nome deve ter pelo menos 2 caracteres");
  }
  if (body.situacao !== undefined && !["ATIVO","INATIVO"].includes(body.situacao)) errors.push("situacao inválida");
  return errors;
}

app.get("/health", async (_req,res,next) => {
  try { await pool.query("SELECT 1"); res.json({ status: "ok" }); } catch (error) { next(error); }
});

app.get("/alunos", async (req,res,next) => {
  try {
    const term = String(req.query.q || "").trim();
    const [rows] = await pool.execute(
      `SELECT ${studentFields}
       FROM aluno
       WHERE (? = '' OR nome LIKE CONCAT('%', ?, '%') OR matricula LIKE CONCAT('%', ?, '%'))
       ORDER BY nome, id_aluno
       LIMIT 100`,
      [term, term, term]
    );
    res.json(rows);
  } catch (error) { next(error); }
});

app.get("/alunos/:id", async (req,res,next) => {
  try {
    const [rows] = await pool.execute(`SELECT ${studentFields} FROM aluno WHERE id_aluno = ?`, [req.params.id]);
    if (!rows[0]) return res.status(404).json({ error: "Aluno não encontrado" });
    res.json(rows[0]);
  } catch (error) { next(error); }
});

app.post("/alunos", async (req,res,next) => {
  try {
    const errors = validateStudent(req.body);
    if (errors.length) return res.status(422).json({ errors });
    const { matricula, nome, nome_social = null, email = null, situacao = "ATIVO" } = req.body;
    const [result] = await pool.execute(
      `INSERT INTO aluno (matricula, nome, nome_social, email, situacao)
       VALUES (?, ?, ?, ?, ?)`,
      [matricula.trim(), nome.trim(), nome_social?.trim() || null, email?.trim() || null, situacao]
    );
    const [rows] = await pool.execute(`SELECT ${studentFields} FROM aluno WHERE id_aluno = ?`, [result.insertId]);
    res.status(201).location(`/alunos/${result.insertId}`).json(rows[0]);
  } catch (error) { next(error); }
});

app.put("/alunos/:id", async (req,res,next) => {
  try {
    const errors = validateStudent(req.body);
    if (errors.length) return res.status(422).json({ errors });
    const { matricula, nome, nome_social = null, email = null, situacao = "ATIVO" } = req.body;
    const [result] = await pool.execute(
      `UPDATE aluno SET matricula=?, nome=?, nome_social=?, email=?, situacao=?
       WHERE id_aluno=?`,
      [matricula.trim(), nome.trim(), nome_social?.trim() || null, email?.trim() || null, situacao, req.params.id]
    );
    if (!result.affectedRows) return res.status(404).json({ error: "Aluno não encontrado" });
    const [rows] = await pool.execute(`SELECT ${studentFields} FROM aluno WHERE id_aluno = ?`, [req.params.id]);
    res.json(rows[0]);
  } catch (error) { next(error); }
});

app.delete("/alunos/:id", async (req,res,next) => {
  try {
    const [result] = await pool.execute("DELETE FROM aluno WHERE id_aluno = ?", [req.params.id]);
    if (!result.affectedRows) return res.status(404).json({ error: "Aluno não encontrado" });
    res.status(204).end();
  } catch (error) { next(error); }
});

app.use((_req,res) => res.status(404).json({ error: "Rota não encontrada" }));
app.use((error,_req,res,_next) => {
  console.error({ code: error.code, message: error.message });
  if (error.code === "ER_DUP_ENTRY") return res.status(409).json({ error: "Matrícula ou e-mail já cadastrado" });
  if (error.code === "ER_ROW_IS_REFERENCED_2") return res.status(409).json({ error: "Registro possui histórico relacionado" });
  res.status(500).json({ error: "Erro interno" });
});

const port = Number(process.env.PORT || 3000);
app.listen(port, () => console.log(`API disponível em http://localhost:${port}`));
