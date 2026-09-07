# Modelo Entidade e Relacionamento (MER)

## 1. Entidades

### Paciente

**Definição:** Representa a pessoa que recebe atendimento médico no sistema.

### Médico

**Definição:** Representa o profissional responsável pela realização das consultas.

### Especialidade

**Definição:** Representa a área de atuação de um profissional médico.

### Consulta

**Definição:** Representa o atendimento realizado ou agendado entre um paciente e um médico.

### Prontuário

**Definição:** Representa o histórico clínico e as informações relacionadas à saúde de um paciente.

## 2. Relacionamentos e Cardinalidades

### Paciente — realiza — Consulta

[Paciente] (1,N) <realiza> (1,1) [Consulta]

Um paciente pode realizar várias consultas, mas cada consulta pertence a apenas um paciente.

### Médico — realiza — Consulta

[Médico] (1,N) <realiza> (1,1) [Consulta]

Um médico pode realizar várias consultas, mas cada consulta é realizada por apenas um médico.

### Médico — possui — Especialidade

[Médico] (1,N) <possui> (1,N) [Especialidade]

Um médico pode possuir uma ou mais especialidades, e uma especialidade pode estar associada a vários médicos.

### Paciente — possui — Prontuário

[Paciente] (1,1) <possui> (1,1) [Prontuário]

Cada paciente possui um único prontuário, e cada prontuário pertence a um único paciente.

### Prontuário — registra — Consulta

[Prontuário] (1,1) <registra> (0,N) [Consulta]

Um prontuário pode registrar nenhuma, uma ou várias consultas ao longo do tempo.

## 3. Sugestão de Atributos

### Paciente

- **CPF (PK)**
- Nome
- Data de nascimento
- Sexo
- Telefone
- E-mail
- Endereço

### Médico

- **CRM (PK)**
- Nome
- Telefone
- E-mail

### Especialidade

- **ID_Especialidade (PK)**
- Nome
- Descrição

### Consulta

- **ID_Consulta (PK)**
- Data
- Horário
- Status
- Motivo
- Observações

### Prontuário

- **ID_Prontuario (PK)**
- Data de criação
- Alergias
- Observações clínicas

### ATENDIMENTO 
int id_atendimento PK
date data_atendimento
string descricao 
string observacoes 
int id_consulta FK
int id_prontuario FK 

### MEDICO_ESPECIALIDADE 
int id_medico PK, FK 
int id_especialidade PK, FK 

