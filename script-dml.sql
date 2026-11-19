
-- ==========================================
-- PROJETO: SISTEMA DE SAUDE
-- ARQUIVO: script-dml.sql
-- ==========================================

-- Selecionar o banco de dados
USE sistema_saude;


-- ==========================================
-- CENARIO 1: CADASTRO DAS UNIDADES DE SAUDE
-- A administracao cadastrou cinco unidades
-- para iniciar os atendimentos.
-- ==========================================


INSERT INTO unidade_saude
(id_unidade, nome, tipo, endereco, telefone, ativa)
VALUES
(1, 'UBS Jardim das Flores', 'UBS',
 'Rua das Acacias, 120 - Centro', '(84) 3000-1001', TRUE),

(2, 'Clinica Vida Nova', 'Clinica',
 'Avenida Principal, 450 - Centro', '(84) 3000-1002', TRUE),

(3, 'Hospital Municipal Esperanca', 'Hospital',
 'Rua do Hospital, 80 - Lagoa', '(84) 3000-1003', TRUE),

(4, 'UBS Alto do Sol', 'UBS',
 'Rua Sol Nascente, 55 - Alto', '(84) 3000-1004', TRUE),

(5, 'UPA Central', 'UPA',
 'Avenida da Saude, 900 - Centro', '(84) 3000-1005', TRUE);


-- ==========================================
-- CENARIO 2: CADASTRO DE ESPECIALIDADES
-- E CONVENIOS
-- A administracao cadastrou as especialidades
-- e os convenios disponíveis para atendimento.
-- ==========================================

-- Cadastro das especialidades
INSERT INTO especialidade
(id_especialidade, nome, descricao, duracao_padrao_min, ativa)
VALUES
(1, 'Clinica Geral', 'Atendimento inicial e acompanhamento geral', 30, TRUE),
(2, 'Pediatria', 'Atendimento de criancas e adolescentes', 30, TRUE),
(3, 'Cardiologia', 'Avaliacao e acompanhamento do coracao', 40, TRUE),
(4, 'Dermatologia', 'Avaliacao de pele, cabelos e unhas', 30, TRUE),
(5, 'Ginecologia', 'Saude e acompanhamento ginecologico', 40, TRUE);

-- Cadastro dos convenios
INSERT INTO convenio
(id_convenio, nome, tipo, telefone_contato, ativo)
VALUES
(1, 'SUS', 'Publico', '(136)', TRUE),
(2, 'VidaPlena', 'Privado', '(0800) 100-2001', TRUE),
(3, 'SaudeMais', 'Privado', '(0800) 100-2002', TRUE),
(4, 'BemEstar', 'Privado', '(0800) 100-2003', TRUE),
(5, 'Atendimento Particular', 'Particular', '(84) 3000-2005', TRUE);


-- ==========================================
-- CENARIO 3: CADASTRO DOS PACIENTES
-- A recepcao realizou o cadastro de cinco
-- pacientes no sistema de saude.
-- ==========================================

INSERT INTO paciente
(id_paciente, nome, data_nascimento, telefone, email, endereco, data_cadastro)
VALUES
(1, 'Ana Beatriz Costa', '1992-04-15',
 '(84) 99911-1001', 'ana@email.com',
 'Rua das Flores, 100', '2026-10-01'),

(2, 'Carlos Eduardo Lima', '1985-09-22',
 '(84) 99911-1002', 'carlos@email.com',
 'Rua Central, 200', '2026-10-01'),

(3, 'Mariana Alves Rocha', '2014-02-10',
 '(84) 99911-1003', 'mariana@email.com',
 'Avenida Principal, 300', '2026-10-02'),

(4, 'Joao Pedro Martins', '1978-12-03',
 '(84) 99911-1004', 'joao@email.com',
 'Rua do Sol, 400', '2026-10-02'),

(5, 'Lucia Fernanda Souza', '1999-07-28',
 '(84) 99911-1005', 'lucia@email.com',
 'Rua da Saude, 500', '2026-10-03');


 -- ==========================================
-- CENARIO 4: CADASTRO DOS MEDICOS
-- A administracao cadastrou cinco medicos
-- e vinculou cada um a uma unidade de saude.
-- ==========================================

INSERT INTO medico
(id_medico, nome, crm, telefone, email, id_unidade, ativo)
VALUES
(1, 'Dra. Helena Ribeiro', 'CRM-RN 12001',
 '(84) 98811-2001', 'helena@email.com', 1, TRUE),

(2, 'Dr. Marcos Almeida', 'CRM-RN 12002',
 '(84) 98811-2002', 'marcos@email.com', 2, TRUE),

(3, 'Dra. Paula Nascimento', 'CRM-RN 12003',
 '(84) 98811-2003', 'paula@email.com', 3, TRUE),

(4, 'Dr. Ricardo Fernandes', 'CRM-RN 12004',
 '(84) 98811-2004', 'ricardo@email.com', 4, TRUE),

(5, 'Dra. Camila Oliveira', 'CRM-RN 12005',
 '(84) 98811-2005', 'camila@email.com', 5, TRUE);


-- ==========================================
-- CENARIO 5: VINCULO DOS MEDICOS
-- COM SUAS ESPECIALIDADES
-- Cada medico foi associado a uma
-- especialidade medica.
-- ==========================================

INSERT INTO medico_especialidade
(id_medico, id_especialidade, data_inicio, principal, observacao)
VALUES
(1, 1, '2026-10-01', TRUE, 'Especialidade principal em clinica geral'),

(2, 2, '2026-10-01', TRUE, 'Especialidade principal em pediatria'),

(3, 3, '2026-10-01', TRUE, 'Especialidade principal em cardiologia'),

(4, 4, '2026-10-01', TRUE, 'Especialidade principal em dermatologia'),

(5, 5, '2026-10-01', TRUE, 'Especialidade principal em ginecologia');


-- ==========================================
-- CENARIO 6: AGENDAMENTO E REALIZACAO
-- DAS CONSULTAS MEDICAS
-- Os pacientes foram atendidos nas
-- respectivas unidades de saude.
-- ==========================================

INSERT INTO consulta
(id_consulta, id_paciente, id_medico, id_unidade,
 id_convenio, data_hora, status, motivo)
VALUES
(1, 1, 1, 1, 1, '2026-10-06 08:00:00',
 'Realizada', 'Consulta de rotina'),

(2, 2, 3, 3, 2, '2026-10-06 09:30:00',
 'Realizada', 'Avaliacao cardiologica'),

(3, 3, 2, 2, 1, '2026-10-07 10:00:00',
 'Realizada', 'Consulta pediatrica'),

(4, 4, 4, 4, 3, '2026-10-08 14:00:00',
 'Realizada', 'Avaliacao dermatologica'),

(5, 5, 5, 5, 5, '2026-10-09 15:00:00',
 'Realizada', 'Consulta ginecologica');


 -- ==========================================
-- CENARIO 7: REGISTRO DOS PRONTUARIOS
-- Apos as consultas, os medicos registraram
-- as informacoes dos atendimentos.
-- ==========================================

INSERT INTO prontuario
(id_prontuario, id_consulta, data_registro,
 queixa_principal, diagnostico, conduta, observacoes)
VALUES
(1, 1, '2026-10-06',
 'Consulta de rotina',
 'Paciente sem alteracoes relevantes',
 'Orientacoes gerais de saude',
 'Retorno conforme necessidade'),

(2, 2, '2026-10-06',
 'Avaliacao cardiologica',
 'Avaliacao clinica realizada',
 'Solicitados exames de rotina',
 'Acompanhamento recomendado'),

(3, 3, '2026-10-07',
 'Consulta pediatrica',
 'Paciente em acompanhamento',
 'Orientacoes aos responsaveis',
 'Retorno conforme necessidade'),

(4, 4, '2026-10-08',
 'Avaliacao dermatologica',
 'Avaliacao dermatologica realizada',
 'Orientacoes de cuidados com a pele',
 'Acompanhamento se necessario'),

(5, 5, '2026-10-09',
 'Consulta ginecologica',
 'Consulta de acompanhamento',
 'Orientacoes preventivas',
 'Retorno conforme necessidade');

 