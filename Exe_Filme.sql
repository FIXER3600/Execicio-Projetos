CREATE DATABASE ex_filme
GO
USE ex_filme

CREATE TABLE FILME(
Id		INT		UNIQUE,
Titulo	VARCHAR(80) UNIQUE,
Ano		INT			NOT NULL
PRIMARY KEY(Id))
GO
CREATE TABLE DVD(
Num		INT,
Data_Fabricacao		Date,
Id_Filme		INT,
PRIMARY KEY(Num),
FOREIGN KEY (Id_Filme) REFERENCES FILME(Id))
GO
CREATE TABLE ESTRELA(
Id		INT		UNIQUE,
Nome	VARCHAR(50)		
PRIMARY KEY(Id))
GO
CREATE TABLE CLIENTE(
Num_cadastro	INT		UNIQUE,
Nome			VARCHAR(70),
Logradouro		VARCHAR(150),
Num				INT,
CEP				CHAR(8)
PRIMARY KEY(Num_Cadastro))
GO
CREATE TABLE LOCACAO(
Data_Locacao	Date,
Data_Devolucao	Date,
Valor			DECIMAL(7,2),
DVDNum			INT,
Clientenum_cadastro		INT,
PRIMARY KEY(Data_Locacao),
FOREIGN KEY (DVDNum) REFERENCES DVD(Num),
FOREIGN KEY (Clientenum_cadastro) REFERENCES CLIENTE(Num_cadastro))
GO
CREATE TABLE FILME_ESTRELA(
Filmeid		Int,
Estrelaid	Int,
FOREIGN KEY (Filmeid)	REFERENCES FILME(Id),
FOREIGN KEY (Estrelaid)	REFERENCES ESTRELA(Id))
GO
INSERT INTO FILME (Id, Titulo, Ano) VALUES 
(1001,'Whiplash',2015),
(1002,'Birdman',2015),
(1003,'Interestellar',2014),
(1004,'A Culpa é das Estrelas',2014),
(1005,'Alexandre e o Dia Terrível, Horrível, Espantoso e Horroroso',2014),
(1006,'Sing',2016)

INSERT INTO ESTRELA (Id,Nome) VALUES
(9901,'Michael Keaton'),
(9902,'Emma Stone'),
(9903,'Miles Teller'),
(9904,'Steve Carell'),
(9905,'Jennifer Garner')

INSERT INTO FILME_ESTRELA (Filmeid,Estrelaid) VALUES
(1002,9001),
(1002,9002),
(1001,9003),
(1005,9004),
(1005,9005)

INSERT INTO DVD (Num,Data_Fabricacao,Id_Filme) VALUES 
(10001,2020-12-02,1001),
(10002,2020-10-08,1002),
(10003,2020-04-03,1003),
(10004,2020-12-02,1001),
(10005,2019-10-18,1004),
(10006,2020-04-03,1002),
(10007,2020-12-02,1005),
(10008,2019-10-18,1002),
(10009,2020-04-03,1003)

INSERT INTO CLIENTE (Num_cadastro, Nome,Logradouro,Num,CEP) VALUES
(5501,'Matilde Luz','Rua Síria',150,03086040),
(5502,'Carlos Carreiro','Rua Bartolomeu Aires',1250,04419110),
(5503,'Daniel Ramalho','Rua Itajutiba',169,NULL),
(5504,'Roberta Bento','Rua Jayme Von Rosenburg',36,NULL),
(5505,'Rosa Cerqueira','Rua Arnaldo Simões Pinto',235,02917110)

INSERT INTO LOCACAO (DVDNum,Clientenum_cadastro,Data_Locacao,Data_Devolucao,Valor) VALUES
(10001,5502,2021-02-18,2021-02-21,3.50),
(10009,5502,2021-02-18,2021-02-21,3.50),
(10002,5503,2021-02-18,2021-02-19,3.50),
(10002,5505,2021-02-20,2021-02-23,3.00),
(10004,5505,2021-02-20,2021-02-23,3.00),
(10005,5505,2021-02-20,2021-02-23,3.00),
(10001,5501,2021-02-24,2021-02-26,3.50),
(10008,5501,2021-02-24,2021-02-26,3.50)