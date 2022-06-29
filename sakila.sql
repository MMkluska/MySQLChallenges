USE sakila;

-- 1. List all actors. 
SELECT DISTINCT first_name `First Name`, last_name `Last Name` FROM actor; 

-- 2. Find the surname of the actor with the forename 'John'.
SELECT last_name `Last Name` FROM actor WHERE first_name="John";

-- 3. Find all actors with surname 'Neeson'.
SELECT first_name `First Name`, last_name `Last Name` FROM actor WHERE last_name="Neeson";

-- 4. Find all actors with ID numbers divisible by 10.
SELECT actor_id `ID`, first_name `First Name`, last_name `Last Name` FROM actor WHERE actor_id%10=0;

-- 5. What is the description of the movie with an ID of 100?
SELECT film_id `ID`, `Description` FROM film WHERE film_id=100;
 
-- 6. Find every R-rated movie.
SELECT `Title`, `Rating` FROM film WHERE rating="R";

-- 7. Find every non-R-rated movie.
SELECT `Title`, `Rating` FROM film WHERE rating!="R";

-- 8. Find the ten shortest movies.
SELECT `Title`, `Length` FROM film ORDER BY length LIMIT 10; 

-- 9. Find the movies with the longest runtime, without using LIMIT.
SELECT `Title`, `Length` FROM film WHERE length IN (SELECT MAX(length) FROM film);

-- 10. Find all movies that have deleted scenes.
SELECT `Title`, special_features `Special Features` FROM film WHERE special_features LIKE "%Deleted Scenes%";

-- 11. Using HAVING, reverse-alphabetically list the last names that are not repeated.
SELECT last_name `Last Name` FROM actor GROUP BY last_name HAVING count(last_name)=1 ORDER BY last_name DESC;

-- 12. Using HAVING, list the last names that appear more than once, from highest to lowest frequency.
SELECT last_name, count(last_name) `Count` FROM actor GROUP BY last_name HAVING count(last_name)>=2 ORDER BY count(last_name) DESC, last_name ASC;

-- 13. Which actor has appeared in the most films?
SELECT first_name `First Name`, last_name `Last Name` FROM actor WHERE actor_id =(
SELECT actor_id FROM film_actor GROUP BY actor_id HAVING count(actor_id)>1 ORDER BY count(actor_id) DESC LIMIT 1 );

-- 14. When is 'Academy Dinosaur' due?
SELECT `Title`, release_year `Relase Year` FROM film WHERE title='Academy Dinosaur';

-- 15. What is the average runtime of all films?
SELECT AVG(Length) `Average Length` FROM film;

-- 16. List the average runtime for every film category.
SELECT AVG(f.Length) `Average Length`, c.name `Category` FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id GROUP BY c.name;

-- 17. List all movies featuring a robot.
SELECT `Title`, `Description`  FROM film WHERE `Description` LIKE "%robot%";

-- 18. How many movies were released in 2010?
SELECT Count(Title) `Title`, count(release_year) `Relase Year` FROM film WHERE release_year=2010;

-- 19. Find the titles of all the horror movies.
SELECT f.title `Title`, c.name `Category` FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id WHERE c.name="horror";

-- 20. List the full name of the staff member with the ID of 2.
SELECT first_name `First Name`, last_name `Last Name` FROM staff WHERE staff_id=2;

-- 21. List all the movies that Fred Costner has appeared in.
SELECT `Title` FROM film WHERE film_id IN (
SELECT film_id FROM film_actor WHERE actor_id = ( 
SELECT actor_id FROM actor WHERE first_name = "FRED" AND last_name = "Costner"));

-- 22. How many distinct countries are there?
SELECT count(DISTINCT Country) `Number of countries` FROM country;

-- 23. List the name of every language in reverse-alphabetical order.
SELECT `Name` FROM `language` ORDER BY `name` DESC;

-- 24. List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename.
SELECT first_name `First Name`, last_name `Last Name` FROM actor WHERE last_name LIKE "%son" ORDER BY first_name;

-- 25. Which category contains the most films?
SELECT DISTINCT c.name `Category`, count(*) `Count` FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id WHERE c.category_id =(
SELECT category_id FROM film_category GROUP BY category_id ORDER BY count(category_id) DESC LIMIT 1);