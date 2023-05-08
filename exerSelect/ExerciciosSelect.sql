use sakila;

/* 1 Monte um select que traga todas as informações possíveis de todas as cidades (city)  */
select * from city;

/* 2 Monte um select que traga apenas o nome das cidades (mas traga todas)  */
select city from city;

/* 3 Monte um select que traga todas as informações possíveis de todos os países (country)  */
select * from country;

/* 4 Monte um select que traga apenas o nome dos países (mas traga todas)  */
select country from country;

/* 5 Em film, traga a descrição dos filmes "BABY HALL", "BETRAYED REAR", "CASSIDY WYOMING" em uma única query  */
select 
	description 
from
	film_text
where 
	title  = "BABY HALL" or title  = "BETRAYED REAR" or title  = "CASSIDY WYOMING";

/* 6 Traga todos os atores que possuem o sobrenome "BALL", "GOODING" ou "TEMPLE"  */
select * from actor
	where 
		last_name = "BALL" or last_name = "GOODING" or last_name = "TEMPLE";
	


show tables;