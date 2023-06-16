use sakila;

/*Busque todos os filmes com categoria action*/
select * from film 
inner join film_category on film.film_id = film_category.film_id
inner join category on film_category.category_id = category.category_id 
where category.name = 'Action';


/*Busque todos os endereços do país South Africa*/
select * from address
inner join city on address.city_id = city.city_id 
inner join country  
where country = 'South Africa';


/*Busque todos os pagamentos de MARY SMITH, limit em 2*/
select payment.* from payment 
inner join customer on payment.customer_id = customer.customer_id
where customer.first_name = 'MARY' and customer.last_name = 'SMITH'
limit 2;


/*Busque todos os filmes que foram assistidos por HELEN HARRIS*/
select film.* from film
inner join inventory on film.film_id = inventory.film_id 
inner join rental on inventory.inventory_id = rental.inventory_id 
inner join customer on rental.customer_id = customer.customer_id 
where customer.first_name = 'HELEN' and customer.last_name = 'HARRIS';