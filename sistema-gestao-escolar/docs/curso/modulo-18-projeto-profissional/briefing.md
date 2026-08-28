# Briefing do projeto profissional

## Problema

Secretarias escolares precisam manter cadastros, matrículas e resultados com integridade, rastreabilidade e acesso eficiente.

## Usuários

- secretaria;
- coordenação;
- professor;
- administrador técnico.

## Histórias prioritárias

- como secretaria, quero cadastrar e localizar alunos;
- como secretaria, quero matricular sem ultrapassar a capacidade;
- como coordenação, quero acompanhar ocupação e avaliações;
- como professor, quero registrar resultados válidos;
- como administrador, quero recuperar o serviço e auditar falhas.

## Requisitos não funcionais

- nenhuma credencial no repositório;
- operações críticas transacionais;
- erros sem vazamento interno;
- execução local reproduzível;
- contratos documentados;
- backup restaurável;
- logs com correlação;
- dados exclusivamente fictícios.

## Fora do escopo inicial

- cobrança;
- diário eletrônico completo;
- integração governamental;
- biometria;
- envio de mensagens;
- produção com dados de menores.

## Critérios de aceite

- README executado por outra pessoa;
- CRUD e matrícula demonstrados;
- testes passam em ambiente limpo;
- migration sobe e reverte;
- API corresponde ao OpenAPI;
- restauração comprovada;
- riscos e limitações registrados.
