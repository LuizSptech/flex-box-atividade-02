
use exercicios;

create table pessoa (
idpessoa int  primary key auto_increment ,
nome varchar (45),
cpf char(11)

);

create table Reserva (
idReserva int primary key auto_increment,
dtReserva datetime,
dtRetirada datetime,
dtDevolucao datetime,
fkpessoa int,
foreign key (fkpessoa) references pessoa(idpessoa)
);

insert into pessoa (nome,cpf) 
values ('Alan',11111111112),
		('Lucas',11111111113),
        ('Murilo',11111111114),
		('Heitor',11111111115),
        ('Kevin',11111111116);

INSERT INTO Reserva (dtReserva, dtRetirada, dtDevolucao, fkpessoa)
VALUES
('2026-03-10 10:00:00', '2026-03-12 09:00:00', '2026-03-15 18:00:00', 1),
('2026-03-11 14:30:00', '2026-03-13 08:00:00', '2026-03-16 17:00:00', 2),
('2026-03-12 09:15:00', '2026-03-14 10:00:00', '2026-03-18 19:00:00', 3),
('2026-03-13 16:45:00', '2026-03-15 09:30:00', '2026-03-20 20:00:00', 4),
('2026-03-14 11:00:00', '2026-03-16 08:30:00', '2026-03-21 18:30:00', 5);

select * from pessoa;
select * from Reserva;

select 
p.nome as NomePessoa,
R.dtReserva as DataReserva,
R.dtRetirada as Retirada
from pessoa p
join reserva R
on p.idPessoa = R.fkPessoa;

select dtReserva,
case 
	when dtReserva < '2026-03-12 09:15:00'  then 'Antigo'
    else 'Recente'
end as tempo
from Reserva;

update Reserva 
set dtDevolucao = null
where dtDevolucao like '2026-03-18 19:00:00';


select 
idReserva,
ifnull(dtDevolucao, 'Ainda não devolvido') as Devolucao
from Reserva;

-- /* EXERCICIO 02 */ --


create table Pessoa1 (
idPessoa1 int primary key auto_increment,
nome varchar(45),
dtNascimento date );


create table Pessoa2 (
idPessoa2 int primary key auto_increment,
nome varchar (45),
dtNascimento date,
fkPessoa1 int,
foreign key (fkPessoa1) references Pessoa1(idPessoa1));

INSERT INTO Pessoa1 (nome, dtNascimento)
VALUES
('Ana Silva', '2000-05-12'),
('Carlos Souza', '1998-11-23'),
('Mariana Lima', '2003-02-17'),
('João Pereira', '1995-08-30'),
('Fernanda Alves', '2001-01-09');

INSERT INTO Pessoa2 (nome, dtNascimento, fkPessoa1)
VALUES
('Lucas Martins', '2002-04-10', 1),
('Bruna Costa', '1999-07-21', 2),
('Rafael Gomes', '2001-12-05', 3),
('Juliana Rocha', '1997-09-14', 4),
('Pedro Henrique', '2000-03-30', 5);

SELECT 
P1.nome AS NomePessoa,
P2.dtNascimento AS Aniversario
FROM Pessoa1 P1
JOIN Pessoa2 P2
ON P1.idPessoa1 = P2.fkPessoa1;

select dtNascimento,
case 
	when dtNascimento < '2000-03-30'  then 'velho'
    else 'novo'
end as tempo
from Pessoa2;


select nome,
ifnull(dtNascimento, 'Ainda não nasceu') as data_nascimento
from Pessoa2;

-- /* EXERCICIO 03 */ --

CREATE TABLE Candidato (
idCandidato INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(50),
categoria CHAR(1)
);

CREATE TABLE Habilitacao (
idHabilitacao INT AUTO_INCREMENT PRIMARY KEY,
dataProva DATE,
statusProva VARCHAR(20),
fkCandidato INT,
FOREIGN KEY (fkCandidato) REFERENCES Candidato(idCandidato)
);

INSERT INTO Candidato (nome, categoria) VALUES
('João Silva','B'),
('Maria Souza','A'),
('Carlos Lima','B'),
('Ana Costa','A'),
('Pedro Rocha','B');

INSERT INTO Habilitacao (dataProva, statusProva, fkCandidato) VALUES
('2026-03-10','Aprovado',1),
('2026-03-11','Reprovado',2),
('2026-03-12',NULL,3),
('2026-03-13','Aprovado',4),
('2026-03-14','Reprovado',5);

SELECT * FROM Candidato;

SELECT * FROM Habilitacao;

SELECT 
C.nome AS NomeCandidato,
H.dataProva AS DataProva
FROM Candidato C
JOIN Habilitacao H
ON C.idCandidato = H.fkCandidato;

SELECT 
nome,
CASE
WHEN categoria = 'A' THEN 'Moto'
WHEN categoria = 'B' THEN 'Carro'
END AS tipo_veiculo
FROM Candidato;

SELECT nome, IFNULL(dtNascimento, 'Sem data') as datas
FROM Pessoa1;

-- /* EXERCICIO 04 */ --

CREATE TABLE Farmacia (
idFarmacia INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(50),
telefone VARCHAR(20)
);

CREATE TABLE Endereco (
idEndereco INT AUTO_INCREMENT PRIMARY KEY,
rua VARCHAR(50),
cidade VARCHAR(40),
fkFarmacia INT UNIQUE,
FOREIGN KEY (fkFarmacia) REFERENCES Farmacia(idFarmacia)
);

CREATE TABLE Farmaceutico (
idFarmaceutico INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(50),
crf VARCHAR(20),
fkFarmacia INT,
FOREIGN KEY (fkFarmacia) REFERENCES Farmacia(idFarmacia)
);


INSERT INTO Farmacia (nome, telefone) VALUES
('Farmacia Vida','11999990001'),
('Farmacia Popular','11999990002'),
('Farmacia Central','11999990003'),
('Farmacia Saúde','11999990004'),
('Farmacia Bem Estar','11999990005');

INSERT INTO Endereco (rua, cidade, fkFarmacia) VALUES
('Rua A','São Paulo',1),
('Rua B','São Paulo',2),
('Rua C','Campinas',3),
('Rua D','Santos',4),
('Rua E','Osasco',5);

INSERT INTO Farmaceutico (nome, crf, fkFarmacia) VALUES
('Ana Silva','CRF123',1),
('Carlos Lima','CRF456',1),
('Mariana Souza','CRF789',2),
('João Costa','CRF321',3),
('Pedro Alves','CRF654',4);

SELECT * FROM Farmacia;

SELECT 
F.nome AS NomeFarmacia,
E.rua AS Rua
FROM Farmacia F
JOIN Endereco E
ON F.idFarmacia = E.fkFarmacia;

SELECT 
cidade,
CASE
WHEN cidade = 'São Paulo' THEN 'Capital'
ELSE 'Interior'
END AS TipoCidade
FROM Endereco;

SELECT 
nome,
IFNULL(telefone,'Telefone não informado') AS Telefone
FROM Farmacia;