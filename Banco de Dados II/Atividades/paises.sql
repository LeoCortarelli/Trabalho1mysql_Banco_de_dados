-- Criando a tabela paises 

create table Paises (
	ID_pais int(11) not null auto_increment,
    nome_paises varchar(50) not null default " ",
    sigla varchar(3) not null default " ",
    Primary key(ID_pais)
);

insert into Paises (nome_paises) select Pais from Fornecedores
union 
select Pais from Clientes;

select * from Paises;


