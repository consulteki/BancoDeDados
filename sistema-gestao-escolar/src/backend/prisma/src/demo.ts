import { prisma } from "./client.js";

const students = await prisma.aluno.findMany({
  select: {
    id: true,
    matricula: true,
    nome: true,
    nomeSocial: true,
    situacao: true,
    matriculas: {
      select: { id: true, turmaId: true, situacao: true }
    }
  },
  orderBy: { nome: "asc" },
  take: 100
});

console.log(JSON.stringify(students, (_key,value) =>
  typeof value === "bigint" ? value.toString() : value
, 2));

await prisma.$disconnect();
