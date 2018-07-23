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


