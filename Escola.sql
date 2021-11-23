Create Database Ex_Subquery
Go
Use Ex_Subquery

Create Table filme(
id		int		not null,
titulo  varchar(40)		not null,
ano		int		null Check(ano <= 2021)
Primary Key(id)
)
Go
Create Table estrela(
id		int		not null,
nome	varchar(50)	not null
Primary Key(id)
)
Go
Create Table filme_estrela(
filme_id	int		not null,
estrela_id	int		not null
Primary Key(filme_id, estrela_id)
Foreign Key(filme_id) References filme(id),
Foreign Key(estrela_id) References estrela(id)
)
Go
Create Table dvd(
num		int		not null,
data_fabricacao		date		not null  Check(data_fabricacao < GETDATE()),
filme_id		int		not null
Primary Key(num)
Foreign Key(filme_id)	References	filme(id)
) 
Go
Create Table cliente(
num_cadastro	int		not null,
nome		varchar(70)		not null,
logradouro	varchar(150)	not null,
num		int			not null	Check(num > 0),
cep		char(8)		null		Check(LEN(cep) = 8)
Primary Key(num_cadastro)
)
Go
Create Table locacao(
dvd_num		int		not null,
cliente_num_cadastro	int		not null,
data_locacao		date		not null	default(GETDATE()),
data_devolucao		date		not null,	
valor		decimal(7,2)		not null,
Constraint  dtd_dtl	 Check(data_devolucao > data_locacao),
Primary Key(data_locacao, dvd_num, cliente_num_cadastro),
Foreign Key(dvd_num) References dvd(num),
Foreign Key (cliente_num_cadastro) References cliente(num_cadastro)
)
Alter Table filme
Alter Column titulo	varchar(80)		not null

Alter Table estrela
Add nome_real varchar(50)	not null

Alter Table estrela
Alter Column nome_real varchar(50)	null

Exec sp_help cliente
Exec sp_help dvd
Exec sp_help estrela
Exec sp_help filme
Exec sp_help filme_estrela
Exec sp_help locacao

Insert Into filme
Values
(1001, 'Whiplash', 2015),
(1002, 'Birdman', 2015),
(1003, 'Interstelar', 2014),
(1004, 'A Culpa é das estrelas', 2014),
(1005, 'Alexandre e o Dia Terrível, Horrível, Espantoso e Horroroso', 2014),
(1006, 'Sing', 2016)
Go
Insert Into estrela
Values
(9901,'Michael Keaton','Michael John Douglas'),
(9902, 'Emma Stone', 'Emily Jean Stone'),
(9903, 'Miles Teller', null),
(9904, 'Steve Carell', 'Steve John Carell'),
(9905, 'Jennifer Garner', 'Jennifer Anne Garner')
Go
Insert Into filme_estrela
Values
(1002,9901),
(1002,9902),
(1001,9903),
(1005,9904),
(1005,9905)
Go
Insert Into dvd
Values
(10001,'2020-12-02',1001),
(10002,'2019-10-18',1002),
(10003,'2020-04-03',1003),
(10004,'2020-12-02',1001),
(10005,'2019-10-18',1004),
(10006,'2020-04-03',1002),
(10007,'2020-12-02',1005),
(10008,'2019-10-18',1002),
(10009,'2020-04-03',1003)
Go
Insert Into cliente
Values
(5501,'Matilde Luz','Rua Síria',150,'03086040'),
(5502,'Carlos Carreiro','Rua Bartolomeu Aires',1250,'04419110'),
(5503,'Daniel Ramalho','Rua Itajutiba',169,NULL),
(5504,'Roberta Bento','Rua Jayme Von Rosenburg',36,NULL),
(5505,'Rosa Cerqueira','Rua Arnaldo Simões Pinto',235,'02917110')
Go
Insert Into locacao
Values
(10001,5502,'2021-02-18','2021-02-21',3.50),
(10009,5502,'2021-02-18','2021-02-21',3.50),
(10002,5503,'2021-02-18','2021-02-19',3.50),
(10002,5505,'2021-02-20','2021-02-23',3.00),
(10004,5505,'2021-02-20','2021-02-23',3.00),
(10005,5505,'2021-02-20','2021-02-23',3.00),
(10001,5501,'2021-02-24','2021-02-26',3.50),
(10008,5501,'2021-02-24','2021-02-26',3.50)

Update cliente
Set cep = '08411150'
Where num_cadastro = 5503
Go
Update cliente
Set cep = '02918190'
Where num_cadastro = 5504

Update locacao
Set valor = 3.25
Where data_devolucao = '2021-02-18' and cliente_num_cadastro = 5502

Update locacao
Set valor = 3.10
Where data_devolucao = '2021-02-24' and cliente_num_cadastro = 5501

update dvd
Set data_fabricacao = '2019-07-14'
Where num = 10005 

update estrela
Set nome_real = 'Miles Alexander Teller'
Where nome = 'Miles Teller'

delete filme
Where titulo = 'Sing'

SELECT * FROM cliente
SELECT * FROM dvd
SELECT * FROM estrela
SELECT * FROM filme
SELECT * FROM filme_estrela
SELECT * FROM locacao


Select id, ano,
	CASE
		WHEN((LEN(titulo) > 10)) THEN 
			SUBSTRING(titulo,1,10)+'...'
		ELSE
			titulo
	END as titulo_otimizado
From filme
Where id In
(
	SELECT DISTINCT filme_id
	FROM dvd
	WHERE data_fabricacao > '01-01-2020'

)

Select num, Convert(char(10), data_fabricacao, 103) As dt_fab,
	Datediff(Month, data_fabricacao, GETDATE()) As qtd_meses_desde_fabricacao
From dvd
Where filme_id in(
	Select id
	From filme
	Where titulo = 'Interstelar'
)

Select dvd_num, Convert(char(10), data_locacao, 103) As dt_loc,
	   Convert(char(10), data_devolucao, 103) As dt_dev,
	   DATEDIFF(DAY, data_locacao, data_devolucao) As dias_alugado,
	   valor
From locacao
Where cliente_num_cadastro in(
	SELECT num_cadastro
	From cliente
	Where nome like '%Rosa%'
)

Select nome, logradouro + ',' + CAST(num as varchar(4)) As endereço_completo,
'('+SUBSTRING(cep,1,5) + '-' + SUBSTRING(cep,6,3)+')' As cep
From cliente
Where num_cadastro in(
SELECT cliente_num_cadastro
From locacao
Where dvd_num = 10002
)