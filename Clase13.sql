1)

INSERT INTO customer
(store_id, first_name, last_name, email, address_id)
VALUES
(1, 'Matias', 'Boldini', 'matiboldini2000@gmail.com', 
(SELECT address_id 
FROM address
 INNER JOIN city USING (city_id)
 INNER JOIN country USING (country_id)
WHERE country.country LIKE 'United States'
ORDER BY address_id DESC LIMIT 1));


2)

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id) 
VALUES
(CURRENT_DATE(),
(SELECT inventory_id FROM inventory INNER JOIN film USING (film_id) WHERE title = 'COWBOY DOOM' LIMIT 1),
(SELECT customer_id FROM customer WHERE store_id = 1 LIMIT 1),
(SELECT staff_id FROM staff WHERE store_id = 1 LIMIT 1));


3)

UPDATE film
SET release_year = '2001'
WHERE rating = 'G';

UPDATE film
SET release_year = '2002'
WHERE rating = 'PG';

UPDATE film
SET release_year = '2003'
WHERE rating = 'PG-13';

UPDATE film
SET release_year = '2004'
WHERE rating = 'R';

UPDATE film
SET release_year = '2005'
WHERE rating = 'NC-17';


4-

SELECT MAX(rental_id) FROM film
INNER JOIN inventory USING (film_id)
INNER JOIN rental t USING (inventory_id)
WHERE t.return_date IS NULL;

UPDATE rental
SET return_date = CURRENT_TIMESTAMP
WHERE rental_id = 15966;


5-

#Seleccionamos la pelicula.
SELECT * FROM film LIMIT 1;

#Eliminamos todos los registros que tengan esa pelicula de la tabla 'film_category'.
DELETE FROM film_category WHERE film_id = (SELECT film_id FROM film LIMIT 1);

#Eliminamos todos los registros que tengan esa pelicula de la tabla 'film_actor'.
DELETE FROM film_actor WHERE film_id = (SELECT film_id FROM film LIMIT 1);

#Eliminamos todos los registros de rentas de los inventarios que pertenezcan a nuesta pelicula.
DELETE FROM rental WHERE inventory_id IN
(SELECT inventory_id FROM inventory WHERE film_id = (SELECT film_id FROM film LIMIT 1));

#Eliminamos todos los inventarios de la pelicula.
DELETE FROM inventory WHERE film_id = (SELECT film_id FROM film LIMIT 1);

#Finalmente eliminamos la pelicula.
DELETE FROM film WHERE film_id = 1;


6-

SELECT inventory_id
FROM inventory
INNER JOIN rental USING (inventory_id)
WHERE rental.return_date IS NOT NULL
AND inventory.store_id = 1;


INSERT INTO rental
(rental_date, inventory_id, customer_id, staff_id)
VALUES(
CURRENT_DATE(),
10,
(SELECT customer_id FROM customer ORDER BY customer_id DESC LIMIT 1),
(SELECT staff_id FROM staff WHERE store_id = (SELECT store_id FROM inventory WHERE inventory_id = 10))
);


INSERT INTO payment
(customer_id, staff_id, rental_id, amount, payment_date)
VALUES(
(SELECT customer_id FROM customer ORDER BY customer_id DESC LIMIT 1),
(SELECT staff_id FROM staff LIMIT 1),
(SELECT rental_id FROM rental ORDER BY rental_id DESC LIMIT 1) ,
(SELECT rental_rate FROM film WHERE film_id = 2),
CURRENT_DATE());
