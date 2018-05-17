1)

SELECT country.country, COUNT(city)
FROM country, city 
WHERE country.country_id = city.country_id
GROUP BY country.country_id
ORDER BY country.country, country.country_id;


2)

SELECT country.country, COUNT(city)
FROM country
INNER JOIN city
	ON country.country_id = city.country_id
GROUP BY country.country_id
HAVING COUNT(city) >10
ORDER BY COUNT(city) DESC;


3)

SELECT customer.first_name, customer.last_name,
		(SELECT address.address
		FROM address
		WHERE customer.address_id = address.address_id) AS address,
		COUNT(*) AS rents,
		(SELECT SUM(amount)
		FROM payment
		WHERE payment.customer_id = customer.customer_id) AS amount
FROM customer
INNER JOIN rental
	ON rental.customer_id = customer.customer_id
GROUP BY customer.customer_id
ORDER BY amount DESC;


4)

SELECT film_id, title
FROM film
WHERE film_id NOT IN (SELECT film_id FROM inventory);


5)

SELECT film.title, inventory_id
FROM film 
	INNER JOIN inventory USING (film_id)
	LEFT JOIN rental USING (inventory_id)
WHERE rental_id IS NULL;


6)

SELECT CONCAT(customer.last_name, " ",customer.first_name) as Name, customer.store_id, film.title, rental.rental_date, rental.return_date
FROM rental 
	INNER JOIN customer  USING (customer_id)
	INNER JOIN inventory USING (inventory_id)
	INNER JOIN film USING (film_id)
ORDER BY store_id, customer.last_name;

7)

