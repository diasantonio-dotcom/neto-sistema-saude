-- =========================================================================
-- ATIVIDADE: MÓDULO VENDAS (NORMALIZAÇÃO) + MÓDULO HOSPITALAR
-- =========================================================================

-- -------------------------------------------------------------------------
-- 1. MÓDULO VENDASDB (1FN, 2FN E 3FN)
-- -------------------------------------------------------------------------
DROP DATABASE IF EXISTS VendasDB;
CREATE DATABASE VendasDB;
USE VendasDB;

-- Cliente: 1FN (Endereço desmembrado em campos atômicos)
CREATE TABLE Cliente (
  idCliente INT UNSIGNED NOT NULL PRIMARY KEY,
  nome VARCHAR(125) NOT NULL,
  logradouro VARCHAR(150) NOT NULL, numero VARCHAR(10) NOT NULL,
  bairro VARCHAR(60) NOT NULL, cidade VARCHAR(60) NOT NULL,
  uf CHAR(2) NOT NULL, cep CHAR(8) NOT NULL
);

-- ClienteEmail: 1FN (Chave composta que resolve o atributo multivalorado de e-mails)
CREATE TABLE ClienteEmail (
  idCliente INT UNSIGNED NOT NULL,
  email VARCHAR(100) NOT NULL,
  PRIMARY KEY (idCliente, email),
  CONSTRAINT fk_cliente_email FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE
);

-- Produto: Tabela base para a 2FN
CREATE TABLE Produto (
  idProduto INT UNSIGNED NOT NULL PRIMARY KEY,
  nomeProduto VARCHAR(100) NOT NULL,
  precoUnitario DECIMAL(10,2) NOT NULL
);

-- Pedido: 3FN (Elimina dependência transitiva mantendo apenas a FK idCliente)
CREATE TABLE Pedido (
  idPedido INT UNSIGNED NOT NULL PRIMARY KEY,
  dataPedido DATE NOT NULL,
  idCliente INT UNSIGNED NOT NULL,
  CONSTRAINT fk_pedido_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- ItemPedido: 2FN (Dependência funcional total da PK composta: idPedido + idProduto)
CREATE TABLE ItemPedido (
  idPedido INT UNSIGNED NOT NULL,
  idProduto INT UNSIGNED NOT NULL,
  quantidade INT UNSIGNED NOT NULL,
  precoPraticado DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (idPedido, idProduto),
  CONSTRAINT fk_item_pedido FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
  CONSTRAINT fk_item_produto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

-- Povoamento de Dados (DML)
INSERT INTO Cliente VALUES
(1, 'Carlos Eduardo Silva', 'Rua das Flores', '120', 'Centro', 'São Paulo', 'SP', '01001000'),
(2, 'Maria Fernanda Oliveira', 'Av. Paulista', '1500', 'Bela Vista', 'São Paulo', 'SP', '01310100'),
(3, 'João Pedro Santos', 'Rua Brasil', '45', 'Jardins', 'Campinas', 'SP', '13010000');

INSERT INTO ClienteEmail VALUES (1, 'carlos.silva@email.com'), (1, 'carlos.trabalho@email.com'), (2, 'maria.fernanda@email.com');
INSERT INTO Produto VALUES (10, 'Notebook Gamer', 4500.00), (20, 'Mouse Sem Fio', 120.00), (30, 'Teclado Mecânico', 350.00);
INSERT INTO Pedido VALUES (101, '2026-03-01', 1), (102, '2026-03-02', 1), (103, '2026-03-05', 2);
INSERT INTO ItemPedido VALUES (101, 10, 1, 4500.00), (101, 20, 2, 120.00), (102, 30, 1, 350.00), (103, 20, 1, 120.00);

-- Consultas de Validação (DQL)
-- 1FN: E-mails cadastrados
SELECT c.nome AS 'Cliente', e.email AS 'E-mail' FROM Cliente c INNER JOIN ClienteEmail e ON c.idCliente = e.idCliente WHERE c.idCliente = 1;

-- 2FN e 3FN: Reconstrução das informações via JOIN
SELECT p.idPedido AS 'Nº Pedido', p.dataPedido AS 'Data', c.nome AS 'Cliente', prod.nomeProduto AS 'Produto', item.quantidade AS 'Qtd', item.precoPraticado AS 'Preço Un.', (item.quantidade * item.precoPraticado) AS 'Subtotal'
FROM Pedido p
INNER JOIN Cliente c ON p.idCliente = c.idCliente
INNER JOIN ItemPedido item ON p.idPedido = item.idPedido
INNER JOIN Produto prod ON item.idProduto = prod.idProduto
ORDER BY p.idPedido;

-- Total gasto por cliente (Group By)
SELECT c.nome AS 'Cliente', COUNT(DISTINCT p.idPedido) AS 'Total de Pedidos', SUM(item.quantidade * item.precoPraticado) AS 'Valor Total Gasto'
FROM Cliente c
INNER JOIN Pedido p ON c.idCliente = p.idCliente
INNER JOIN ItemPedido item ON p.idPedido = item.idPedido
GROUP BY c.idCliente, c.nome ORDER BY `Valor Total Gasto` DESC;


-- -------------------------------------------------------------------------
-- 2. MÓDULO SISTEMA HOSPITALAR
-- -------------------------------------------------------------------------
DROP DATABASE IF EXISTS sistema_hospitalar;
CREATE DATABASE sistema_hospitalar;
USE sistema_hospitalar;

-- Cadastros Auxiliares
CREATE TABLE ESPECIALIDADE (
    id_especialidade INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_especialidade VARCHAR(100) NOT NULL,
    descricao VARCHAR(255)
);

CREATE TABLE UNIDADE_SAUDE (
    id_unidade INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    telefone VARCHAR(20)
);

CREATE TABLE CONVENIO_SAUDE (
    id_convenio INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_operadora VARCHAR(150) NOT NULL,
    tipo_plano VARCHAR(100),
    telefone_contato VARCHAR(20)
);

CREATE TABLE MEDICAMENTO (
    id_medicamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_comercial VARCHAR(150) NOT NULL,
    principio_ativo VARCHAR(150),
    fabricante VARCHAR(150),
    KEY idx_medicamento_principio_ativo (principio_ativo)
);

-- Pessoas e Prontuário
CREATE TABLE MEDICO (
    crm VARCHAR(20) NOT NULL PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    email VARCHAR(150),
    id_especialidade INT NOT NULL,
    id_unidade INT NOT NULL,
    CONSTRAINT fk_medico_especialidade FOREIGN KEY (id_especialidade) REFERENCES ESPECIALIDADE (id_especialidade),
    CONSTRAINT fk_medico_unidade FOREIGN KEY (id_unidade) REFERENCES UNIDADE_SAUDE (id_unidade)
);

CREATE TABLE PACIENTE (
    cpf VARCHAR(14) NOT NULL PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    data_nascimento DATE,
    sexo VARCHAR(20),
    email VARCHAR(150),
    id_convenio INT,
    CONSTRAINT fk_paciente_convenio FOREIGN KEY (id_convenio) REFERENCES CONVENIO_SAUDE (id_convenio)
);

CREATE TABLE PRONTUARIO (
    id_prontuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    data_abertura DATE,
    historico_clinico TEXT,
    cpf_paciente VARCHAR(14) NOT NULL UNIQUE,
    CONSTRAINT fk_prontuario_paciente FOREIGN KEY (cpf_paciente) REFERENCES PACIENTE (cpf)
);

-- Consultas, Prescrições e Exames
CREATE TABLE CONSULTA (
    id_consulta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME,
    tipo_consulta VARCHAR(50),
    status VARCHAR(50),
    crm_medico VARCHAR(20) NOT NULL,
    id_prontuario INT NOT NULL,
    id_unidade INT NOT NULL,
    CONSTRAINT fk_consulta_medico FOREIGN KEY (crm_medico) REFERENCES MEDICO (crm),
    CONSTRAINT fk_consulta_prontuario FOREIGN KEY (id_prontuario) REFERENCES PRONTUARIO (id_prontuario),
    CONSTRAINT fk_consulta_unidade FOREIGN KEY (id_unidade) REFERENCES UNIDADE_SAUDE (id_unidade)
);

CREATE TABLE PRESCRICAO (
    id_prescricao INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    data_emissao DATE,
    validade DATE,
    id_consulta INT NOT NULL,
    CONSTRAINT fk_prescricao_consulta FOREIGN KEY (id_consulta) REFERENCES CONSULTA (id_consulta)
);

CREATE TABLE ITEM_PRESCRICAO (
    id_prescricao INT NOT NULL,
    id_medicamento INT NOT NULL,
    dosagem VARCHAR(100),
    posologia VARCHAR(255),
    duracao_tratamento VARCHAR(100),
    PRIMARY KEY (id_prescricao, id_medicamento),
    CONSTRAINT fk_item_prescricao_prescricao FOREIGN KEY (id_prescricao) REFERENCES PRESCRICAO (id_prescricao),
    CONSTRAINT fk_item_prescricao_medicamento FOREIGN KEY (id_medicamento) REFERENCES MEDICAMENTO (id_medicamento)
);

CREATE TABLE EXAME (
    id_exame INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tipo_exame VARCHAR(100),
    data_solicitacao DATE,
    data_resultado DATE,
    resultado TEXT,
    status VARCHAR(50),
    id_consulta INT NOT NULL,
    CONSTRAINT fk_exame_consulta FOREIGN KEY (id_consulta) REFERENCES CONSULTA (id_consulta)
);

-- Leitos e Internação
CREATE TABLE LEITO (
    id_leito INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    numero_leito VARCHAR(20) NOT NULL,
    tipo_leito VARCHAR(50),
    status VARCHAR(50),
    id_unidade INT NOT NULL,
    CONSTRAINT fk_leito_unidade FOREIGN KEY (id_unidade) REFERENCES UNIDADE_SAUDE (id_unidade)
);

CREATE TABLE INTERNACAO (
    id_internacao INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    data_entrada DATE,
    data_saida DATE,
    motivo VARCHAR(255),
    cpf_paciente VARCHAR(14) NOT NULL,
    id_leito INT NOT NULL,
    CONSTRAINT fk_internacao_paciente FOREIGN KEY (cpf_paciente) REFERENCES PACIENTE (cpf),
    CONSTRAINT fk_internacao_leito FOREIGN KEY (id_leito) REFERENCES LEITO (id_leito)
);