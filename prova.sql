/* Leonardo Tavares Cortarelli */
drop database hotel;
create database hotel;
use hotel;

drop table cliente;

create table if not exists cliente(
	id_cliente int primary key auto_increment,
	nome varchar(255) not null,
	sobrenome varchar(255) not null,
	tipo_documento enum("Cpf", "rg", "passaporte") default "Cpf",
	endereco varchar(255) default 'Não Constado' not null
);

insert into cliente(nome, sobrenome,tipo_documento,endereco)
	values
		('Leonardo','Cortarelli','cpf','endereco'),
		('Alexandre','Fonceca','passaporte','endereco2'),
		('Robert','Lewandowiski','rg','endereco3');
select * from cliente;


drop table reservas;

create table if not exists reservas(
	id_reserva INT not null PRIMARY KEY AUTO_INCREMENT,
    data_entrada DATETIME,
    data_saida DATETIME,
    data_registro DATETIME DEFAULT NOW(),
    observacao VARCHAR(255) NULL,
    id_cliente int,
    foreign KEY (id_cliente) REFERENCES cliente(id_cliente)
);

insert into reservas(data_entrada, data_saida, observacao, id_cliente)
	values
		('2023-07-20 09:07:00', '2023-07-20 18:07:00','Hotel muito bom',1),
		('2023-08-19 10:06:00', '2023-08-19 19:06:00','Um exelente atendimento',2),
		('2023-09-18 11:05:00', '2023-09-18 20:05:00','Falta quartos',3);


select * from reservas;

alter table reservas 
	drop column observacao,
	add column comentario_clientes varchar(100);

update 
		cliente 
	set 
		nome = 'Leandro'
	where  
		sobrenome = 'Cortarelli';
	
	
	update 
		cliente 
	set 
		nome = 'Eduada'
	where  
		sobrenome = 'Fonceca';
	
	
	
	update 
		cliente 
	set 
		nome = 'Julio'
	where  
		sobrenome = 'Lewandowiski';
	
	
	select
		reservas.id_reserva , cliente.nome from cliente, reservas
	where 
		reservas.id_reserva = 1 and cliente.id_cliente = reservas.id_cliente ;

	select
		reservas.id_reserva , cliente.nome from cliente, reservas
	where 
		reservas.id_reserva = 2 and cliente.id_cliente = reservas.id_cliente ;
	
	select
		reservas.id_reserva , cliente.nome from cliente, reservas
	where 
		reservas.id_reserva = 3 and cliente.id_cliente = reservas.id_cliente ;