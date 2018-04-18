1)

SELECT DISTINCT first_name , last_name 
FROM actor a1
WHERE EXISTS (SELECT *
		FROM actor a2
		WHERE a1.last_name = a2.last_name AND a1.actor_id <> a2.actor_id)
		ORDER BY last_name;


2)

SELECT *
FROM actor a1
WHERE NOT EXISTS (SELECT *
                    FROM film_actor a2
                    WHERE a1.actor_id = a2.actor_id)
                    ORDER BY actor_id;
        
        
3)

SELECT *
FROM customer c1
WHERE EXISTS (SELECT *
                FROM rental c2
                WHERE c1.customer_id = c2.customer_id
                AND NOT EXISTS (SELECT *
                                  FROM rental c3
                                  WHERE c1.customer_id = c3.customer_id AND c2.rental_id <> c3.rental_id))
                                  
                                  
4)

SELECT *
FROM customer c1
WHERE EXISTS (SELECT *
                FROM rental c2
                WHERE c1.customer_id = c2.customer_id
                AND EXISTS (SELECT *
                              FROM rental c3
                              WHERE c1.customer_id = c3.customer_id AND c2.rental_id <> c3.rental_id))


5)

SELECT *
FROM actor b1
WHERE EXISTS(SELECT *
                FROM film_actor b2, film b3
                WHERE b1.actor_id = b2.actor_id AND b2.film_id = b3.film_id AND b3.title IN ('BETRAYED REAR', 'CATCH AMISTAD'))


6)

SELECT *
FROM actor d1
WHERE EXISTS(SELECT *
                FROM film_actor d2, film d3
                WHERE d1.actor_id = d2.actor_id AND d2.film_id = d3.film_id AND d3.title IN ('BETRAYED REAR') AND d3.title NOT IN ('CATCH AMISTAD'))
                
7)

SELECT e1.actor_id, e1.first_name, e1.last_name
	FROM actor e1
		WHERE EXISTS(SELECT * 
			             FROM film_actor e2, film e3 
				         WHERE e2.actor_id = e1.actor_id AND e3.film_id = e2.film_id AND e3.title = 'BETRAYED REAR')
		AND EXISTS (SELECT * 
			            FROM film_actor e2, film e3 
				        WHERE e2.actor_id = e1.actor_id AND e3.film_id = e2.film_id AND e3.title = 'CATCH AMISTAD')
