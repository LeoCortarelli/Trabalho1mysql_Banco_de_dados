/*Aluno: Leonardo Tavares Cortarellli*/

drop table pet;

create table if not exists pet(
	nome varchar(255),
	idade int,
	raca varchar(255)
);

insert into pet
	(nome, idade, raca)
	
	values
		('Apolo',8,'Golden'),
		('Meg',6,'Yaser'),
		('Pandora',3,'Husky siberiano');
		
select * from pet;

/*-----------------------------------------------------*/
/*Segunda pergunta */

drop table registro_ponto;

create table if not exists registro_ponto(
	data_dia DateTime,
	nome_do_funcionario varchar(255),
	horario_entrada DateTime,
	horario_saida_almoco DateTime,
	horario_entrada_almoco DateTime,
	horario_saida_fim_expediente DateTime
);

insert into registro_ponto
	(nome_do_funcionario, data_dia, horario_entrada, horario_saida_almoco, horario_entrada_almoco, horario_saida_fim_expediente)
	
	values
		('Matheus Cunha','2023-03-23 08:00','2023-03-23 08:00','2023-03-23 12:00','2023-03-23 13:00','2023-03-23 17:00'),
		('Alex Paulo','2023-03-23 08:00','2023-03-23 08:00','2023-03-23 12:00','2023-03-23 13:00','2023-03-23 17:00'),
		('Julia Tavares','2023-03-23 08:00','2023-03-23 08:00','2023-03-23 12:00','2023-03-23 13:00','2023-03-23 17:00'),
		('Amanda Nunes','2023-03-23 08:00','2023-03-23 08:00','2023-03-23 12:00','2023-03-23 13:00','2023-03-23 17:00'),
		('Talita Medeiros','2023-03-23 08:00','2023-03-23 08:00','2023-03-23 12:00','2023-03-23 13:00','2023-03-23 17:00'),
		('Isabela Pinheiro','2023-03-23 08:00','2023-03-23 08:00','2023-03-23 12:00','2023-03-23 13:00','2023-03-23 17:00'),
		('Maria Clara','2023-03-23 08:00','2023-03-23 08:00','2023-03-23 12:00','2023-03-23 13:00','2023-03-23 17:00'),
		('Guilherme Moraes','2023-03-23 08:00','2023-03-23 08:00','2023-03-23 12:00','2023-03-23 13:00','2023-03-23 17:00'),
		('Marcos Guilherme','2023-03-23 08:00','2023-03-23 08:00','2023-03-23 12:00','2023-03-23 13:00','2023-03-23 17:00'),
		('Kayo Fonceca','2023-03-23 08:00','2023-03-23 08:00','2023-03-23 12:00','2023-03-23 13:00','2023-03-23 17:00');
		
select * from registro_ponto;





/*-----------------------------------------------------*/
/*Terceira pergunta */



drop table refrigerante;

create table if not exists refrigerante(
	id_refrigerantes INT not null primary key auto_increment,
	refrigerante enum('Coca', 'Pepsi'),
	volume_L double,
	quantidade Integer,
	data_registro datetime
);


insert into refrigerante
	(refrigerante, volume_L, quantidade, data_registro)
	
	
	values
		('Coca', 2.6, 5, '2023-03-24 12:00'),
		('Coca', 2.5, 12, '2023-03-24 17:25'),
		('Pepsi', 3.6, 65, '2023-03-24 15:32'),
		('Coca', 2.9, 74, '2023-03-24 09:50'),
		('Pepsi', 2.8, 32, '2023-03-24 07:25');
	
select * from refrigerante;




/*-----------------------------------------------------*/
/*Quarta pergunta */

drop table mercadorias;

create table if not exists mercadorias(
	nome varchar(255) not null default'Não consta',
	quantidade int not null default 0,
	vendedor_autorizado varchar(255) not null default'Não consta',
	tipo_de_medida enum('L','g','kg'),
	data_registro datetime not null default now(),
	data_atualizacao datetime not null default now()
);


insert into mercadorias
	(nome, quantidade, vendedor_autorizado, tipo_de_medida, data_registro, data_atualizacao)

	
	values
		('Chocolate',30,'Lucas Rocha','kg','2023-03-24 07:25','2023-03-24 07:40'),
		('Banana',20,'Maycon','g','2023-03-24 08:32','2023-03-24 08:50'),
		('Ovo',30,'Rocha','kg','2023-03-24 14:25','2023-03-24 14:40'),
		('Leite',14,'Cleiton','L','2023-03-24 15:25','2023-03-24 15:40'),
		('Refrigerante',3,'Orban','L','2023-03-24 05:00','2023-03-24 06:00'),
		('Bala',1,'Alexandre','g','2023-03-24 22:25','2023-03-24 22:40'),
		('Bolo',3,'Pablo','kg','2023-03-24 15:30','2023-03-24 16:20'),
		('Bolacha',300,'Lucas','g','2023-03-24 09:25','2023-03-24 10:40'),
		('Biscoito',250,'Rayane','g','2023-03-24 11:02','2023-03-24 12:10'),
		('Palmito',200,'Isabela','g','2023-03-24 12:25','2023-03-24 12:40'),
		('Ostra',3,'Talita','kg','2023-03-24 09:25','2023-03-24 10:00'),
		('Cacau',300,'Nicoly','g','2023-03-24 06:25','2023-03-24 06:40'),
		('Suco del valle',3,'Selena','L','2023-03-24 13:25','2023-03-24 13:40'),
		('Suco Tang',2,'Manuela','L','2023-03-24 14:15','2023-03-24 13:40'),
		('Fanta Uva',1,'Luiz','L','2023-03-24 16:25','2023-03-24 16:40');


select * from mercadorias;


