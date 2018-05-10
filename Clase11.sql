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

