

--DDL


--CRIANDO BANCO DE DADOS
CREATE DATABASE SPMEDGROUP;

--USANDO BANCO DE DADOS
USE SPMEDGROUP;

CREATE TABLE USUARIOS (
	ID INT IDENTITY PRIMARY KEY 
	,EMAIL VARCHAR(250) NOT NULL UNIQUE
	,SENHA VARCHAR(200) NOT NULL 
);


CREATE TABLE PACIENTES(
	ID INT IDENTITY PRIMARY KEY
	,NOME VARCHAR(250) NOT NULL
	,CPF CHAR(11) NOT NULL UNIQUE
	,TELEFONE VARCHAR(12) NOT NULL
	,ID_USUARIO INT NOT NULL FOREIGN KEY REFERENCES USUARIOS(ID)
);
CREATE TABLE ESPECIALIDADES(
	ID INT IDENTITY PRIMARY KEY
	,NOME VARCHAR(250) NOT NULL
);

CREATE TABLE CLINICAS(
	ID INT IDENTITY PRIMARY KEY
	,NOME_FANTASIA VARCHAR(250) NOT NULL
	,RASAO_SOCIAL VARCHAR(250) NOT NULL UNIQUE
	,ENDERECO VARCHAR(250) NOT NULL
	,TELEFONE VARCHAR(12) NOT NULL
);


CREATE TABLE STATUS_CONSULTA(
	ID INT IDENTITY PRIMARY KEY
	,NOME VARCHAR(250) NOT NULL
);

CREATE TABLE MEDICOS(
	ID INT IDENTITY PRIMARY KEY
	,NOME VARCHAR(250) NOT NULL
	,DATA_NASCIMENTO DATE NOT NULL
	,TELEFONE VARCHAR(12) NOT NULL
	,CRM VARCHAR (100) NOT NULL
	,ID_ESPECIALIDADE INT NOT NULL FOREIGN KEY REFERENCES ESPECIALIDADES(ID)
	,ID_CLINICA INT NOT NULL FOREIGN KEY REFERENCES CLINICAS(ID)
);

CREATE TABLE CONSULTAS(
	ID INT IDENTITY PRIMARY KEY
	,DATA_AGENDAMENTO DATE NOT NULL
	,DATA_CONSULTA DATE NOT NULL
	,DESCRICAO VARCHAR(250)
	,ID_PACIENTE INT NOT NULL FOREIGN KEY REFERENCES PACIENTES(ID)
	,ID_MEDICOS INT NOT NULL FOREIGN KEY REFERENCES MEDICOS(ID)
	,ID_STATUS INT NOT NULL FOREIGN KEY REFERENCES STATUS_CONSULTA(ID)
);

ALTER TABLE MEDICOS ADD ID_USUARIO INT NOT NULL FOREIGN KEY REFERENCES USUARIOS(ID);
ALTER TABLE USUARIOS ADD PERMICAO CHAR(1) NOT NULL DEFAULT(1);
ALTER TABLE CLINICAS ADD CNPJ CHAR(12) NOT NULL;
ALTER TABLE PACIENTES ADD DATA_NASCIMENTO DATE NOT NULL;
ALTER TABLE PACIENTES ADD RG CHAR(12) NOT NULL;

ALTER TABLE CONSULTAS ALTER COLUMN DATA_CONSULTA DATETIME NOT NULL;


----------------------------------------------------------------------------------------------
--DML


INSERT INTO ESPECIALIDADES(NOME)
VALUES ('ACUMPULTURA'), ('ANESTESIOLOGIA'),('ANGIOLOGIA'),('CARDIOLOGIA'),('CIRURGIA CARDIOVASCULAR'),('CIRURGIA DA M�O'),('CIRURGIA DO APARELHO DIGESTIVO'), ('CIRURGIA GERAL'),('CIRURGIA PEDIATRICA'),('CIRURGIA PLASTICA'),('CIRURGIA TOR�CICA'),('CIRURGIA VASCULAR'),('DERMATOLOGIA'),('RADIOTERAPIA'),('UROLOGIA'),('PEDIATRIA'),('PSIQUIATRIA');

INSERT INTO USUARIOS(EMAIL,SENHA)
VALUES ('ligia@gmail.com','123'),('alexandre@gmail.com','123'),('fernando@gmail.com','123'),('henrique@gmail.com','123'),('joao@hotmail.com','123'),('bruno@gmail.com','123'),('mariana@outlook.com','123');

INSERT INTO PACIENTES(NOME, CPF, TELEFONE, DATA_NASCIMENTO, RG, ID_USUARIO)
VALUES ('LIGIA','94839859000','1134567654','1983/10/13','435225435','1');

INSERT INTO PACIENTES(NOME, CPF, TELEFONE, DATA_NASCIMENTO, RG, ID_USUARIO)
VALUES ('Alexandre','73556944057','11987656543','2001/07/23','326543457','2'),('Fernando','16839338002','11972084453','1978/10/10','546365253','3'),('Henrique','14332654765','1134566543','1985/10/13','543663625','4'),
('JOAO','91305348010','1176566377','1975/08/27','t32544444-1','5'),('BRUNO','79799299004','11954368769','1972/03/21','545662667','6'),('MARIANA','13771913039','11111111111','2018/03/05','545662668','7')

INSERT INTO CLINICAS(NOME_FANTASIA,RASAO_SOCIAL,ENDERECO,TELEFONE,CNPJ)
VALUES ('Clinica Possarle', 'SP Medical Group','Av. Bar�o Limeira 532 S�o Paulo SP', '1140028922','864902000130');

INSERT INTO USUARIOS(EMAIL, SENHA)
VALUES('ricardo.lemos@spmedicalgroup.com.br','123'),('roberto.possarle@spmedicalgroup.com.br', '123'), ('helena.souza@spmedicalgroup.com.br', '123');


INSERT INTO MEDICOS(NOME,DATA_NASCIMENTO,TELEFONE,CRM,ID_USUARIO,ID_ESPECIALIDADE,ID_CLINICA)
VALUES('Ricardo Lemos', '1996/03/05', '40028922', '54356SP','9','2', '3'),('Roberto Possarle', '1996/03/06', '40028922', '53452SP', '10','17','3'),('Helena Strada', '1996/03/07', '40028922', '65463SP', '11', '16','3');

INSERT INTO STATUS_CONSULTA(NOME)
VALUES('AGENDADA'), ('CANCELADA'), ('REALIZADA');

INSERT INTO CONSULTAS(ID_PACIENTE,ID_MEDICOS,DATA_AGENDAMENTO,DATA_CONSULTA,ID_STATUS,DESCRICAO)
VALUES('7','3', '10/01/2019 01:00', '20/01/2019 15:00', '3', 'morreu'),('2', '2', '10/01/2018','06/01/2018 10:00', '2', 'ta morrendo'),
('3', '2', '10/01/2018 01:00', '07/02/2019 11:00','3', 'nasceu'),('2','2','06/02/2018 10:00', '06/02/2018 10:00','3', 'p�o'),('4','1','07/02/2019 11:00','07/02/2019 11:00','2', 'resfriado'),
('7','3','08/02/2019 15:00','08/02/2019 15:00', '1', 'ta bem'),('4','1','09/02/2019 11:00','09/02/2019 11:00','1','ta por um fio');


------------------------------------------------------------------------------------------------------------------------------
--DQL

SELECT PACIENTES.NOME, USUARIOS.EMAIL, PACIENTES.CPF, PACIENTES.DATA_NASCIMENTO, PACIENTES.TELEFONE, PACIENTES.RG, PACIENTES.CPF
FROM USUARIOS
INNER JOIN PACIENTES
ON USUARIOS.ID = PACIENTES.ID_USUARIO

SELECT MEDICOS.CRM,MEDICOS.NOME, USUARIOS.EMAIL, ESPECIALIDADES.NOME, CLINICAS.NOME_FANTASIA, CLINICAS.CNPJ, CLINICAS.RASAO_SOCIAL, CLINICAS.ENDERECO
FROM MEDICOS
INNER JOIN USUARIOS
ON USUARIOS.ID = MEDICOS.ID_USUARIO
INNER JOIN ESPECIALIDADES
ON MEDICOS.ID_ESPECIALIDADE=ESPECIALIDADES.ID
INNER JOIN CLINICAS
ON MEDICOS.ID_CLINICA=CLINICAS.ID

SELECT PACIENTES.NOME, MEDICOS.NOME, CONSULTAS.DATA_CONSULTA, STATUS_CONSULTA.NOME
FROM CONSULTAS
INNER JOIN PACIENTES
ON CONSULTAS.ID_PACIENTE=PACIENTES.ID
INNER JOIN MEDICOS
ON CONSULTAS.ID_MEDICOS=MEDICOS.ID
INNER JOIN STATUS_CONSULTA
ON CONSULTAS.ID_STATUS=STATUS_CONSULTA.ID



SELECT * FROM PACIENTES;
SELECT * FROM MEDICOS;
SELECT * FROM STATUS_CONSULTA;
SELECT * FROM USUARIOS;
SELECT * FROM CLINICAS;
SELECT * FROM ESPECIALIDADES;

SELECT COUNT(ID)
FROM MEDICOS
WHERE MEDICOS.ID_ESPECIALIDADE = 2;

SELECT COUNT(ID)
FROM MEDICOS
WHERE MEDICOS.ID_ESPECIALIDADE = 17;

SELECT COUNT(ID)
FROM MEDICOS;

SELECT COUNT(ID)
FROM USUSAR;












