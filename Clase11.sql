1)

SELECT country.country, COUNT(city)
FROM country
INNER JOIN city USING (country_id)
GROUP BY country.country_id
ORDER BY country.country, country.country_id;


2)

SELECT country.country, COUNT(city)
FROM country
INNER JOIN city USING (country_id)
GROUP BY country.country_id
HAVING COUNT(city) >10
ORDER BY COUNT(city) DESC;


3)

SELECT CONCAT(customer.last_name, " ", customer.first_name) as name, address.address, COUNT(*) as rented, SUM(payment.amount) as payed
FROM customer 
	INNER JOIN address USING (address_id)
	INNER JOIN rental USING (customer_id)
	INNER JOIN payment USING (rental_id)
GROUP BY customer.customer_id
ORDER BY payed DESC;


SELECT customer.first_name, customer.last_name,
    (SELECT address.address
    FROM address
    WHERE customer.address_id = address.address_id) AS address,
    COUNT(*) AS rents,
    (SELECT SUM(amount)
    FROM payment
    WHERE payment.customer_id = customer.customer_id) AS amount
FROM customer
INNER JOIN rental USING (customer_id)
GROUP BY customer.customer_id
ORDER BY amount DESC;


4)

SELECT film_id, title
FROM film
WHERE film_id NOT IN 
	(SELECT film_id FROM inventory);


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

SELECT DISTINCT city.city, country.country, CONCAT(staff.first_name, '' ,staff.last_name) AS manager, 
	(SELECT SUM(amount)
	FROM payment
	WHERE staff.staff_id = payment.staff_id) AS plata
FROM store
    INNER JOIN address USING(address_id)
    INNER JOIN city USING(city_id)
    INNER JOIN country USING(country_id)
    INNER JOIN staff ON store.store_id = staff.store_id
    INNER JOIN payment ON staff.staff_id = payment.staff_id;


8)

SELECT DISTINCT film.rating, SUM(amount)
FROM film
    INNER JOIN inventory USING(film_id)
    INNER JOIN rental USING(inventory_id)
    INNER JOIN payment USING(rental_id)
GROUP BY film.rating;


9)

SELECT CONCAT(actor.first_name, ' ', actor.last_name) AS actor, COUNT(*) AS total_film
FROM film
    INNER JOIN film_actor USING(film_id)
    INNER JOIN actor USING(actor_id)
GROUP BY actor
ORDER BY total_film DESC
LIMIT 1;


10)

SELECT category.name, AVG(`length`) AS average
FROM film
    INNER JOIN film_category USING(film_id)
    INNER JOIN category USING(category_id)
GROUP BY category.name
ORDER BY average DESC;