## cria a tabela Cidades
create table Cidades (ID_Cidade int not null auto_increment, Nome_Cidade varchar(100) not null, ID_Pais int, primary key (ID_Cidade));
## insere as cidades na Tabela Cidade
insert into Cidades(Nome_Cidade,ID_Pais)
select distinct Cidade, Paises.ID_Pais from Clientes inner join Paises on Clientes.Pais=Paises.Nome_Pais union 
select distinct Cidade, Paises.ID_Pais from Fornecedores inner join Paises on Fornecedores.Pais=Paises.Nome_Pais order by Cidade;
## criar a tabela endereço
create table Enderecos (ID_Endereco int not NUll auto_increment primary key
,Endereco varchar(200) not null,
CEP varchar(20) not null default('')
,ID_Cidade int default(0));

#Cria uma tabela Temporaria para a migração dos endereços
create temporary table Migracao (ID_Endereco int auto_increment,Endereco varchar(255), ID_Cidade int, ID_CF int, Controle Char, primary key (ID_Endereco))  ;
### insere Os dados na Planilha de migração
insert into Migracao(Endereco, ID_Cidade, ID_CF ,Controle) 
select C.endereco, CI.ID_CIdade,C.ID_CLiente, "C"  from Clientes C inner join Cidades CI on C.Cidade=CI.Nome_Cidade union all   
select F.endereco, CI.ID_CIdade,F.ID_Fornecedor, "F"  from Fornecedores F inner join Cidades CI on F.Cidade=CI.Nome_Cidade;

## Insere os dados na Tabela Enderecos
insert into enderecos (ID_Endereco, Endereco, CEP,ID_Cidade)
select M.ID_Endereco,M.Endereco,C.CEP,M.ID_Cidade from Migracao M inner join Clientes C on ID_CF=ID_Cliente where Controle="C" union all
select M.ID_Endereco,M.Endereco,F.CEP,M.ID_Cidade from Migracao M inner join Fornecedores F on ID_CF=ID_Fornecedor where Controle="F";

## Inclui o campo ID endereco na Tabela Clientes
alter table Clientes add column ID_Endereco int;
## Inclui o campo ID endereco na Tabela Fornecedores
alter table Fornecedores add column ID_Endereco int;
#UPdate na Tabela Clientes e Fornecedores com os dados da tabela migração
update Clientes C inner join Migracao M on M.ID_CF=C.ID_Cliente set C.ID_Endereco=M.ID_Endereco where M.Controle="C";
update Fornecedores F inner join Migracao M on M.ID_CF=F.ID_Fornecedor set F.ID_Endereco=M.ID_Endereco where M.Controle="F";
### Apaga a tabela Migracao
drop temporary table Migracao;
