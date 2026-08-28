"use strict";
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.addColumn("aluno", "atualizado_em", {
      type: Sequelize.DATE,
      allowNull: false,
      defaultValue: Sequelize.literal("CURRENT_TIMESTAMP")
    });
  },
  async down(queryInterface) {
    await queryInterface.removeColumn("aluno", "atualizado_em");
  }
};
