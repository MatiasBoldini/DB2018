SELECT address.address, city.city, country.country
FROM store, address, city, country
WHERE country.country_id = city.country_id
AND city.city_id = address.city_id
AND address.address_id = store.address_id