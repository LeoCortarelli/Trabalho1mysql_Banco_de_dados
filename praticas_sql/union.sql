use sakila;

/*Em uma única query, verifique todos os atores, cidades e países que contem a letra i dentro do seu nome. Identifique em uma coluna.*/
select first_name, "first_name" as tab from actor where first_name like "%i%" 
union 
select city, "city" as tab from city c  where city like "%i%"
union 
select country, "country" as tab from country  where country like "%i%";

/*Verifique o id de todas as "store" e "address" com last_update maior que "2006-01-01" e que contenha em address o termpo "My". */
select store_id ,"store_id"  as tab from store where last_update > "2006-01-01"
union 
select address_id , "address_id" as tab from address where last_update > "2006-01-01";

/*Verifique em uma única query todos os name em language e title em filme_list que contem as letras ad uma em seguida da outra. Cosiderar um limite de 10 */
select name , "name" as tab from `language` where tittle like "%ad%"; 