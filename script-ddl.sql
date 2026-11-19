
-- ==========================================
-- PROJETO: SISTEMA DE SAUDE
-- ARQUIVO: script-ddl.sql
-- ==========================================

-- 1. Criar o banco de dados
CREATE DATABASE IF NOT EXISTS sistema_saude;

-- 2. Selecionar o banco de dados
USE sistema_saude;



-- TABELA 1: UNIDADES DE SAUDE
CREATE TABLE unidade_saude (
    id_unidade INT AUTO_INCREMENT,
    nome VARCHAR(120) NOT NULL,
    tipo VARCHAR(40) NOT NULL,
    endereco VARCHAR(180) NOT NULL,
    telefone VARCHAR(20),
    ativa BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id_unidade)
);


-- TABELA 2: ESPECIALIDADES MEDICAS
CREATE TABLE especialidade (
    id_especialidade INT AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    descricao VARCHAR(255),
    duracao_padrao_min INT DEFAULT 30,
    ativa BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id_especialidade),
    UNIQUE (nome)
);


-- TABELA 3: CONVENIOS
CREATE TABLE convenio (
    id_convenio INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    telefone_contato VARCHAR(20),
    ativo BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id_convenio)
);


-- TABELA 4: PACIENTES
CREATE TABLE paciente (
    id_paciente INT AUTO_INCREMENT,
    nome VARCHAR(120) NOT NULL,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(120) UNIQUE,
    endereco VARCHAR(180) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_paciente)
);


-- TABELA 5: MEDICOS
CREATE TABLE medico (
    id_medico INT AUTO_INCREMENT,
    nome VARCHAR(120) NOT NULL,
    crm VARCHAR(20) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(120) UNIQUE,
    id_unidade INT NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,

    PRIMARY KEY (id_medico),

    CONSTRAINT uq_medico_crm UNIQUE (crm),

    CONSTRAINT fk_medico_unidade
    FOREIGN KEY (id_unidade)
    REFERENCES unidade_saude(id_unidade)
);


-- TABELA 6: MEDICOS E ESPECIALIDADES
CREATE TABLE medico_especialidade (
    id_medico INT NOT NULL,
    id_especialidade INT NOT NULL,
    data_inicio DATE NOT NULL,
    principal BOOLEAN DEFAULT FALSE,
    observacao VARCHAR(180),

    PRIMARY KEY (id_medico, id_especialidade),

    CONSTRAINT fk_me_medico
    FOREIGN KEY (id_medico)
    REFERENCES medico(id_medico),

    CONSTRAINT fk_me_especialidade
    FOREIGN KEY (id_especialidade)
    REFERENCES especialidade(id_especialidade)
);


-- TABELA 7: CONSULTAS
CREATE TABLE consulta (
    id_consulta INT AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    id_unidade INT NOT NULL,
    id_convenio INT,
    data_hora DATETIME NOT NULL,
    status VARCHAR(20) DEFAULT 'Agendada',
    motivo VARCHAR(255) NOT NULL,

    PRIMARY KEY (id_consulta),

    CONSTRAINT fk_consulta_paciente
    FOREIGN KEY (id_paciente)
    REFERENCES paciente(id_paciente),

    CONSTRAINT fk_consulta_medico
    FOREIGN KEY (id_medico)
    REFERENCES medico(id_medico),

    CONSTRAINT fk_consulta_unidade
    FOREIGN KEY (id_unidade)
    REFERENCES unidade_saude(id_unidade),

    CONSTRAINT fk_consulta_convenio
    FOREIGN KEY (id_convenio)
    REFERENCES convenio(id_convenio),

    CONSTRAINT chk_consulta_status
    CHECK (status IN ('Agendada', 'Realizada', 'Cancelada', 'Faltou'))
);


-- TABELA 8: PRONTUARIOS
CREATE TABLE prontuario (
    id_prontuario INT AUTO_INCREMENT,
    id_consulta INT NOT NULL,
    data_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    queixa_principal VARCHAR(255) NOT NULL,
    diagnostico VARCHAR(255),
    conduta VARCHAR(255),
    observacoes TEXT,

    PRIMARY KEY (id_prontuario),

    CONSTRAINT uq_prontuario_consulta UNIQUE (id_consulta),

    CONSTRAINT fk_prontuario_consulta
    FOREIGN KEY (id_consulta)
    REFERENCES consulta(id_consulta)
);
