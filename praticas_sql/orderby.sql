use sakila;

/*Exercício 1: Considere uma tabela chamada "actor". Escreva uma consulta SQL que retorne a partir do quinto registro, limitando o resultado a 3 registros.*/
select * from actor order by actor_id limit 3;
/*Exercício 2: Suponha que você tenha uma tabela chamada "city" . Escreva uma consulta SQL que retorne os nomes dos clientes a partir do segundo registro, ordenando-os em ordem alfabética.*/
select * from city where city_id order by city limit 100 offset 1;
/*Exercício 3: Considere uma tabela chamada "store". Escreva uma consulta SQL que retorne a partir do terceiro registro, 
	limitando o resultado a 5 registros, ordenando-os por nome em ordem decrescente.*/
select * from store order by store_id desc limit 5;
/*Exercício 4: Suponha que você tenha uma tabela chamada rental. Escreva uma consulta SQL que retorne os nomes dos funcionários a partir do oitavo registro, 
limitando o resultado a 4 registros, ordenando-os por id em ordem crescente.*/
select * from rental order by rental_id limit 4 offset 3;

/*Exercício 5: Busque todas as cidades que assistiram o filme de KEVIN BLOOM. Limite em 3 registros e traga a partir do terceiro*/
select * from city where (select * from film where (select * from actor where ));