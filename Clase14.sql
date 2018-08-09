1-

SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS 'Name', CONCAT(address.address, ', ',city.city) AS 'Address'
FROM customer
INNER JOIN address USING (address_id)
INNER JOIN city USING (city_id)
INNER JOIN country USING (country_id)
WHERE country.country LIKE 'Argentina';


2-

SELECT title, `language`.name, CASE rating WHEN 'G' THEN 'General Audiences'
    WHEN 'PG' THEN 'Parental Guidance Suggested'
    WHEN 'PG-13' THEN 'Parents Strongly Cautioned'
    WHEN 'R' THEN 'Restricted'
    WHEN 'NC-17' THEN 'Adults Only'
    ELSE 'No rating'
    END AS rating
FROM film
INNER JOIN `language` USING (language_id);


3-

SELECT title, release_year, last_name, first_name
FROM film
	INNER JOIN film_actor USING (film_id)
	INNER JOIN actor USING (actor_id)
    
    
4-

SELECT f.title, CONCAT(c.last_name, ', ', c.first_name) AS name,
		CASE return_date WHEN return_date IS NULL THEN 'No'
				ELSE 'Yes'
				END AS 'return'
FROM rental
INNER JOIN customer c USING (customer_id)
INNER JOIN inventory USING (inventory_id)
INNER JOIN film f USING (film_id)
WHERE MONTH (rental_date) IN ('5', '6');


5-

# Ambos cumplen una misma función, cambiar el tipo de datos.

SELECT CONVERT((SELECT CURRENT_TIME), CHAR);

SELECT CAST((SELECT CURRENT_TIME) AS CHAR);


6-

#INFULL(): La función IFNULL puede devolver valores del tipo INTEGER, REAL o STRING.
#Te permite devolver un valor alternativo si una expresión es NULL:

SELECT IFNULL(return_date, "not returned") from rental;


#COALESCE():La función devuelve la primera expresión no nula en la lista.

SELECT f.title, inventory_id, COALESCE(return_date, 'No devuelta')
FROM rental
INNER JOIN inventory USING (inventory_id)
INNER JOIN film f USING (film_id);