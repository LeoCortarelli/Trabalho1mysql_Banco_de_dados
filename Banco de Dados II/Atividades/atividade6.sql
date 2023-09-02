create temporary table Clientes_teste select * from Clientes;

select * from Clientes_teste;

create temporary table fornecedores_Temp select * from Fornecedores;
select * from fornecedores_Temp;

insert into fornecedores_Temp (ID_Fornecedor,Nome_Fornecedor,Nome_Contato,Endereco,Cidade,CEP,Pais,Telefone)
values
(30,'Leonardo Cortarelli','Leo','Rua jose voluz 831','Curitiba','81870170','Brazil','(41)997419569');

/* Quando fiz a incersao na tabela temporaria ela adcionou na tabela sem ter existino na tabela principal */