# Sistema de Gestão de Saúde (SGS)

##  Sobre o projeto

Este repositório contém a modelagem conceitual de dados (MER) de um **Sistema de Gestão de Saúde**, desenvolvido como parte de uma atividade prática de Modelagem de Dados. O objetivo é aplicar os conceitos de Entidades, Relacionamentos, Cardinalidades e Atributos a partir da descrição de um minimundo real.

##  Descrição do Minimundo

### Contexto e problema real

Redes de saúde municipais e regionais.Compostas por hospitais, Unidades Básicas de Saúde (UBS), laboratórios e clínicas, frequentemente enfrentam problemas de **fragmentação de informação**: prontuários em papel, exames que se perdem entre unidades, prescrições sem histórico centralizado e dificuldade em rastrear internações e ocupação de leitos.

O **Sistema de Gestão de Saúde (SGS)** tem como objetivo resolver esse problema centralizando digitalmente as informações de pacientes, profissionais de saúde, atendimentos, exames, prescrições e internações em uma rede de unidades de saúde, permitindo que qualquer unidade da rede tenha acesso ao histórico clínico completo do paciente.

### Aplicação

Trata-se de um **sistema de prontuário eletrônico e gestão hospitalar e ambulatorial**, utilizado por:
- Recepcionistas (cadastro e agendamento);
- Médicos (consultas, prescrições, solicitação de exames);
- Enfermagem/equipe técnica (internações, controle de leitos);
- Gestores (relatórios de ocupação, convênios, produtividade das unidades).

### Regras de negócio

1. Cada **paciente** possui exatamente **um prontuário**, que concentra todo o seu histórico clínico.
2. Um **médico** pode atuar em **uma ou mais especialidades** e pode trabalhar em **uma ou mais unidades de saúde**.
3. Uma **consulta** está sempre associada a um médico, um paciente (via prontuário) e uma unidade de saúde, em uma data e hora específica.
4. Uma consulta pode gerar **zero ou mais prescrições** e pode solicitar **zero ou mais exames**.
5. Uma **prescrição** é composta por **um ou mais itens**, sendo cada item referente a um medicamento, com sua própria dosagem e posologia.
6. Um **paciente** pode possuir **nenhum, um ou vários convênios de saúde**; um convênio atende a muitos pacientes.
7. Um **paciente** pode ter **zero ou mais internações** ao longo do tempo.
8. Cada **internação** ocupa exatamente **um leito**; um leito pode ser ocupado por diversas internações ao longo do tempo (nunca simultaneamente).
9. Todo **leito** pertence a **uma única unidade de saúde**.

### Processos principais (tarefas do sistema)

- Cadastro de pacientes, médicos e unidades de saúde;
- Agendamento e registro de consultas;
- Registro e consulta do histórico no prontuário eletrônico;
- Emissão de prescrições médicas com múltiplos medicamentos;
- Solicitação e registro de resultados de exames;
- Gestão de convênios e planos de saúde vinculados aos pacientes;
- Controle de internações e ocupação de leitos por unidade.
