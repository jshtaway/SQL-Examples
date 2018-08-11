use sakila;

#1a
select first_name + last_name from actor;

#1b
SELECT CONCAT(first_name, ' ', last_name) AS whole_name from actor;

#2a
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name like "John";

#2b
SELECT first_name, last_name FROM actor
WHERE last_name like '%gen%';

#2c
SELECT first_name, last_name FROM actor
WHERE last_name like '%li%'
ORDER BY last_name ASC,first_name ASC;

#2d
SELECT country_id, country FROM country
WHERE country like 'Afghanistan' OR country LIKE 'Bangladesh' OR country LIKE 'China';

#3a
ALTER TABLE actor
ADD middle_name VARCHAR(15)
AFTER first_name;

#3b
ALTER TABLE actor
MODIFY COLUMN middle_name blob;

#3c
ALTER TABLE actor
DROP COLUMN middle_name;

#4a
SELECT last_name, COUNT(*) FROM actor
GROUP BY last_name;

#4b
SELECT last_name, COUNT(*) FROM actor
GROUP BY last_name
HAVING COUNT(*) > 1;

#4c
UPDATE actor 
SET first_name = 'Harpo'
WHERE actor_id = 172;
(SELECT actor_id FROM actor
WHERE first_name = 'groucho' and last_name = 'williams');

#4d
UPDATE actor 
SET first_name = IF(first_name LIKE 'harpo', 'groucho', 'mucho groucho')
WHERE actor_id = 172;

#5a
SHOW CREATE TABLE address;

#6a
SELECT actor.first_name, actor.last_name, address.address FROM actor
INNER JOIN address ON  actor_id = address_id;

#6b
SELECT payment.staff_id, sum(amount) FROM payment
INNER JOIN staff ON payment.staff_id = staff.staff_id
GROUP BY staff.staff_id;

#6c
SELECT title, film.film_id, count(DISTINCT actor_id) AS number_of_actors FROM film
INNER JOIN film_actor ON actor_id = actor_id
GROUP BY film.film_id;

#6d
SELECT title, count(*) as number_of_copies FROM film
WHERE title like '%Hunchback Impossible%';

#6e
SELECT first_name, last_name, sum(payment.amount) as total_payment FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY payment.customer_id
ORDER BY last_name;

#7a
SELECT title, language.name FROM film
INNER JOIN language ON film.language_id = language.language_id
WHERE (title like 'q%' OR title like 'k%' ) and language.name like 'english';

#7b
SELECT DISTINCT actor.first_name, actor.last_name from film_actor
INNER JOIN film ON film_actor.film_id = film.film_id
INNER JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE film.title like 'alone trip';

#7c
SELECT first_name, last_name, email FROM customer
INNER JOIN address on address.address_id = customer.address_id
INNER JOIN city on address.city_id = city.city_id
INNER JOIN country on city.country_id = country.country_id
WHERE country.country LIKE 'canada';

#7d
SELECT title FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON category.category_id = film_category.category_id
WHERE category.name like 'Family';

#7e
SELECT title FROM film
ORDER BY rental_rate DESC;

#7f
SELECT store.store_id, sum(payment.amount) FROM payment
INNER JOIN staff ON payment.staff_id = staff.staff_id
INNER JOIN store ON store.store_id = staff.store_id
GROUP BY store.store_id;

#7g
SELECT store.store_id, country.country, city.city FROM store
INNER JOIN address ON store.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id;

#7h
SELECT name, sum(payment.amount) FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN inventory ON inventory.film_id = film_category.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY film_category.category_id
ORDER BY sum(payment.amount) DESC
LIMIT 5;

#8a
CREATE VIEW top_five AS
SELECT name, sum(payment.amount) FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN inventory ON inventory.film_id = film_category.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY film_category.category_id
ORDER BY sum(payment.amount) DESC
LIMIT 5;

#8b
SELECT * FROM top_five;

#8c
DROP VIEW top_five;

