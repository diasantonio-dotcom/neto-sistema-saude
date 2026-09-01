# neto-sistema-saúde
sistema de saúde 
## Descrição de minimundo
O projeto consistem na modelagem conceitual de um banco de dados para sistema de gerenciamento de uma unidade de saúde
o sistema tem como objetivo organizar as informações do paciente, médico, especialistas, consultas e prontúarios.
A unidade de saúde necessita controlar os dados do paciente, os profissionais responsáveis pelos atendimentos, suas especialidades, as consultas realizadas e o histórico clínico dos pacientes.

## Contexto da Aplicação

O sistema será utilizado para auxiliar no gerenciamento dos atendimentos de uma unidade de saúde.

Os pacientes poderão ser cadastrados e possuirão um prontuário. Os médicos serão cadastrados juntamente com suas especialidades. As consultas serão registradas relacionando um paciente a um médico.

## Regras de Negócio

1. Cada paciente deve possuir um cadastro único.
2. Um paciente pode realizar várias consultas.
3. Cada consulta pertence a um único paciente.
4. Um médico pode realizar várias consultas.
5. Cada consulta é realizada por um único médico.
6. Um médico pode possuir uma ou mais especialidades.
7. Uma especialidade pode estar associada a vários médicos.
8. Cada paciente possui um único prontuário.
9. Cada prontuário pertence a um único paciente.
10. Um prontuário pode registrar várias consultas.

## Principais Processos

- Cadastro de pacientes.
- Cadastro de médicos.
- Cadastro de especialidades.
- Agendamento e registro de consultas.
- Controle dos prontuários.
- Consulta do histórico de atendimentos.
