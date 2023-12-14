# TRABALHO

CREATE DATABASE RHDatabase;

-- Seleção do Banco de Dados
USE RHDatabase;

-- Criação das Tabelas
create table Funcionario (
    Funcionario_ID INT PRIMARY KEY auto_increment,
    Nome VARCHAR(255),
    DataNascimento DATE,
    CPF VARCHAR(14),
    RG VARCHAR(20),
    Endereco VARCHAR(255),
    Contato VARCHAR(20),
    Cargo VARCHAR(100),
    Departamento VARCHAR(100),
    DataAdmissao DATE,
    Salario DECIMAL(10, 2),
    RegimeTrabalho VARCHAR(50),
    CargaHoraria INT
);

create table Beneficio (
    Beneficio_ID INT PRIMARY KEY auto_increment,
    TipoBeneficio VARCHAR(50),
    Descricao VARCHAR(255)
);

create table Salario (
    Salario_ID INT PRIMARY KEY auto_increment,
    Funcionario_ID INT,
    Valor DECIMAL(10, 2),
    DataReajuste DATE,
    FOREIGN KEY (Funcionario_ID) REFERENCES Funcionario(Funcionario_ID)
);

create table Ferias (
    Ferias_ID INT PRIMARY KEY auto_increment,
    Funcionario_ID INT,
    DataInicio DATE,
    DataTermino DATE,
    SaldoFerias INT,
    FOREIGN KEY (Funcionario_ID) REFERENCES Funcionario(Funcionario_ID)
);

create table AvaliacaoDesempenho (
    Avaliacao_ID INT PRIMARY KEY auto_increment,
    Funcionario_ID INT,
    Metas VARCHAR(255),
    Feedback VARCHAR(255),
    Nota INT,
    PlanoDesenvolvimento VARCHAR(255),
    FOREIGN KEY (Funcionario_ID) REFERENCES Funcionario(Funcionario_ID)
);

create table Treinamento (
    Treinamento_ID INT PRIMARY KEY auto_increment,
    Funcionario_ID INT,
    Curso VARCHAR(255),
    Certificacao VARCHAR(255),
    HabilidadesAdquiridas VARCHAR(255),
    FOREIGN KEY (Funcionario_ID) REFERENCES Funcionario(Funcionario_ID)
);

create table RecrutamentoSelecao (
    Recrutamento_ID INT PRIMARY KEY auto_increment,
    Candidato VARCHAR(255),
    Vaga VARCHAR(100),
    StatusContratacao VARCHAR(50)
);

create table Demissao (
    Demissao_ID INT PRIMARY KEY auto_increment,
    Funcionario_ID INT,
    Motivo VARCHAR(255),
    DataSaida DATE,
    ProcedimentosDesligamento VARCHAR(255),
    FOREIGN KEY (Funcionario_ID) REFERENCES Funcionario(Funcionario_ID)
);

INSERT INTO Funcionario (Nome,DataNascimento,CPF,RG,Endereco,Contato,Cargo,Departamento,DataAdmissao,Salario,RegimeTrabalho,CargaHoraria)
	VALUES('Erling Haaland', '200-10-15', '987.415.874-63', '752149', 'Little Ekeberg kindergarten, 658', '93216471', 'Atleta', 'Futebol', '2018-06-08', 70000.00, 'CLT', 30);

INSERT INTO Beneficio (TipoBeneficio,Descricao)
	VALUES ('Plano de Saúde', 'Plano de Saúde Premium'),
		('Plano de Odontologico', 'Plano odonto Plus'),
        ('Vale Refeicao', 'Sedexo');

INSERT INTO Salario (Funcionario_ID,Valor,DataReajuste)
	VALUES (1, 5500.00, '2022-06-01');
    
INSERT INTO Ferias(Funcionario_ID,DataInicio,DataTermino,SaldoFerias)
	VALUES(1,'2017-05-07','2017-06-07',1000);
    
INSERT INTO AvaliacaoDesempenho(Funcionario_ID,Metas,Feedback,Nota,PlanoDesenvolvimento)
	VALUES(1,'Melhor do mundo','Positivo',8,'3 anos para ser o melhor do ano');
    
INSERT INTO Treinamento(Funcionario_ID,Curso,Certificacao,HabilidadesAdquiridas)
	VALUES(1,'Educação Fizica','Superior','Preparo fisico');
    
INSERT INTO RecrutamentoSelecao(Candidato,Vaga,StatusContratacao)
	VALUES('Yuri Aberto','Jogador','Reprovado'),
		('Jamal Musiala','Jogador','Aprovado');
        
INSERT INTO Demissao(Funcionario_ID,Motivo,DataSaida,ProcedimentosDesligamento)
	VALUES(1,'Contrato','2023-09-05','Fim Contrato');
    
#Consulta Simples: Histórico de Salários dos Funcionários
create view historicoSalarios as 
select Funcionario.Funcionario_ID,
Funcionario.Nome,
Salario.Valor as Salario
from Funcionario
join Salario on Funcionario.Funcionario_ID = Salario.Funcionario_ID;

select * from historicoSalarios;

#Funcionario com avaliação de desempenho e treinamento
create view viewFuncAvalicaoDesenpenho as
select Funcionario.Funcionario_ID,
Funcionario.Nome,
AvaliacaoDesempenho.Metas as MetaAvaliacao,
Treinamento.Curso as TreinamentoCurso
from Funcionario
join AvaliacaoDesempenho on Funcionario.Funcionario_ID = AvaliacaoDesempenho.Funcionario_ID
join Treinamento on Funcionario.Funcionario_ID = Treinamento.Funcionario_ID;

select * from viewFuncAvalicaoDesenpenho;


#CRIANDO PROCIDURE PARA INSERIR UM FUNCIONARIO
delimiter //
	create procedure cadastrar_Funcionario(in $Nome varchar(255),
    in $DataNascimento date,
    in $cpf varchar(14),
    in $rg varchar(20),
    in $Endereco varchar(255),
    in $Contato varchar(20),
    in $Cargo varchar(100),
    in $Departamento varchar(100),
    in $Salario decimal,
    in $RegimeTrabalho varchar(50),
    in $CargaHoraria int)
    
    begin
		INSERT INTO Funcionario (Nome,DataNascimento,CPF,RG,Endereco,Contato,Cargo,Departamento,DataAdmissao,Salario,RegimeTrabalho,CargaHoraria)
		VALUES($Nome, $DataNascimento, $cpf, $rg, $Endereco, $Contato, $Cargo, $Departamento, now(), $Salario, $RegimeTrabalho, $CargaHoraria);
    
    end //
    delimiter ; 
    
	call cadastrar_Funcionario('Marco Reus', '1998-05-31', '852.753.951-47', '632147', 'Rheinlanddamm 207/209, 44137 Dortmund, Alemanha', '98523614', 'Atleta', 'Futebol', 80000.00, 'CLT', 40);
    select * from Funcionario;
    
    
    
    #CRIANDO PROCIDURE PARA INSERIR UM TREINAMENTO COM FUNCIONARIO 
    delimiter //
	create procedure Funcionario_Treinamento(in $Funcionario_ID int,
    in $Curso varchar(255),
    in $Certificacao varchar(255),
    in $HabilidadesAdquiridas varchar(255))
    
    begin
		INSERT INTO Treinamento(Funcionario_ID,Curso,Certificacao,HabilidadesAdquiridas)
		VALUES($Funcionario_ID,$Curso,$Certificacao,$HabilidadesAdquiridas);
    
    end //
    delimiter ; 
    
    call Funcionario_Treinamento(2,'Educação Fizica','Superior','Preparo fisico');
    
    
#Trigger para validar o cpf
DELIMITER //
CREATE TRIGGER ValidarTamanhoCPF
before insert on Funcionario
for each row
begin
    declare $tamanho_cpf int;
    
    set $tamanho_cpf = LENGTH(NEW.cpf);
    
    if tamanho_cpf <> 11 then
        signal sqlstate '45000'
        set message_text = 'Erro: O CPF deve ter exatamente 11 dígitos.';
    end if;
end;
//
DELIMITER ;

#Trigger para limite de ferias
DELIMITER //
CREATE TRIGGER LimiteDiasFerias
before insert on Ferias
for each row
begin
    if new.SaldoFerias > 30 then
        signal sqlstate '45000'
        set message_text = 'Erro: A quantidade de dias de férias não pode ser superior a 30.';
    end if;
end;
//
DELIMITER ;

INSERT INTO Ferias(Funcionario_ID,DataInicio,DataTermino,SaldoFerias)
	VALUES(2,'2017-05-07','2017-06-07',303);
    
select * from Ferias;



    
    
    
    