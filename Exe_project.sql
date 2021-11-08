CREATE DATABASE ex_projeto
GO
USE ex_projeto

CREATE TABLE projects(
Id			INT			NOT NULL	IDENTITY,
nome		VARCHAR(45) NOT NULL,
descricao VARCHAR(45),
dat		DATE NOT NULL,
PRIMARY KEY (Id))
GO
CREATE TABLE users(
Id			INT			NOT NULL IDENTITY,
nome		VARCHAR(45) NOT NULL,
username	VARCHAR(45) NOT NULL,
pass     	VARCHAR(45) NOT NULL,
email		VARCHAR(45) NOT NULL,
PRIMARY KEY (Id)
)
GO
CREATE TABLE users_has_pojects(
users_id	INT NOT NULL,
projects_id INT NOT NULL,
FOREIGN KEY (users_id) REFERENCES users(Id),
FOREIGN KEY (projects_id) REFERENCES projects(Id)
)
GO