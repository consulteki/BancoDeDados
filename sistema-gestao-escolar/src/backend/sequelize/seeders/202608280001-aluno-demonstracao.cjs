"use strict";
module.exports = {
  async up(queryInterface) {
    await queryInterface.bulkInsert("aluno", [{
      matricula: "20269990",
      nome: "Estudante Seeder",
      email: "seeder@example.test",
      situacao: "ATIVO",
      criado_em: new Date(),
      atualizado_em: new Date()
    }]);
  },
  async down(queryInterface) {
    await queryInterface.bulkDelete("aluno", { matricula: "20269990" });
  }
};
