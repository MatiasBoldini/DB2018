1)


#Create a view named list_of_customers, it should contain the following columns:
#-customer id
#-customer full name, 
#-address
#-zip code
#-phone 
#-city
#-country
#-status (when active column is 1 show it as 'active', otherwise is 'inactive') 
#-store id



create or replace view list_of_customers as
    select 
        customer_id,
        concat(c.first_name, c.last_name) as name,
        address,
        postal_code,
        phone, 
        city, 
        country, 
        case  
            when c.active = 1 then 'Active'
            else 'Inactive'
        end as 'status',
        c.store_id 
    from customer c
        inner join address using (address_id) 
        inner join city using (city_id) 
        inner join country using (country_id);
        
select * from list_of_customers;



2)


#Create a view named film_details, it should contain the following columns:
#film id,  title, description,  category,  price,  length,  rating, actors  - as a string of all the actors separated by comma. Hint use GROUP_CONCAT


create or replace view film_details as
    select 
        film_id, 
        title, 
        description, 
        (select c.name from film_category inner join category c using(category_id) limit 1) as category, 
        rental_rate as price, 
        length, 
        rating, 
        group_concat(concat(last_name) separator ', ') as actors
    from film 
        inner join film_actor using (film_id)
        inner join actor using (actor_id)
        inner join film_category using (film_id)
        inner join category using (category_id)
    group by film_id;
        
select * from film_details;



3)


#Create view sales_by_film_category, it should return 'category' and 'total_rental' columns.


create or replace view sales_by_film_category as 
    select 
    name, 
    count(r.rental_id) as total_rental 
    from rental r 
        inner join inventory using (inventory_id) 
        inner join film using (film_id)
        inner join film_category using (film_id) 
        inner join category using (category_id) 
    group by category_id
;

select * from sales_by_film_category;



4) 

#Create a view called actor_information where it should return, actor id, first name, last name and the amount of films he/she acted on.




create or replace view actor_information as
    select 
        a.actor_id, 
        a.first_name, 
        a.last_name, 
        count(fa.film_id)
    from actor a
        inner join film_actor fa using (actor_id)
    group by a.actor_id
;

select * from actor_information;



6) 

#Materialized views, write a description, why they are used, alternatives, DBMS were they exist, etc.


Son vistas que  muestran su resultado en una tabla temporaria.
Se utilizan para no tener que repetir una misma query varias veces, y para tener un acceso mas rapido a la informacion.