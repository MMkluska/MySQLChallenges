USE world;

-- 1. Using COUNT, get the number of cities in the USA.
SELECT count(`name`) `Number of cities` FROM city;

-- 2. Find out the population and life expectancy for people in Argentina.
SELECT `Name`, Population, LifeExpectancy `Life Expectancy` FROM country WHERE `Name`="Argentina";

-- 3. Using IS NOT NULL, ORDER BY, and LIMIT, which country has the highest life expectancy?
SELECT `Name`, LifeExpectancy `Life Expectancy` FROM country WHERE LifeExpectancy IS NOT NULL ORDER BY LifeExpectancy DESC LIMIT 1;

-- 4. Using JOIN ... ON, find the capital city of Spain.
SELECT c.Name `Country`, ci.Name `Capital` FROM country c
JOIN city ci ON c.Capital=ci.ID WHERE c.name ="Spain";

-- 5. Using JOIN ... ON, list all the languages spoken in the Southeast Asia region.
SELECT l.Language FROM country c
JOIN countrylanguage l ON c.code=l.countrycode WHERE c.region="Southeast Asia" GROUP BY l.language;

-- 6. Using a single query, list 25 cities around the world that start with the letter F.
SELECT `Name` FROM city WHERE `name` lIKE "F%" LIMIT 25;

-- 7. Using COUNT and JOIN ... ON, get the number of cities in China.
SELECT count(ci.name) `Number of cities in China` FROM country c
JOIN city ci ON c.code=ci.countrycode WHERE c.name="china";

-- 8. Using IS NOT NULL, ORDER BY, and LIMIT, which country has the lowest population? Discard zero populations.
SELECT `Name`, Population FROM country WHERE Population IS NOT NULL AND Population!=0 ORDER BY Population LIMIT 1;

-- 9. Using aggregate functions, return the number of countries the database contains.
SELECT DISTINCT count(`name`) `Number of countries` FROM country;

-- 10. What are the top ten largest countries by area?
SELECT `Name`, surfacearea `Surface area` FROM country ORDER BY surfacearea DESC LIMIT 10;

-- 11. List the five largest cities by population in Japan.
SELECT ci.name `Largest cities in Japan`, ci.Population FROM country c
JOIN city ci ON c.code=ci.countrycode WHERE c.name="japan" ORDER BY ci.Population DESC LIMIT 5;

-- 12. List the names and country codes of every country with Elizabeth II as its Head of State. You will need to fix the mistake first!
UPDATE country SET HeadOfState="Elizabeth II" Where HeadOfState="Elisabeth II";
SELECT `code` `Country code`, `name` `Country`  FROM country WHERE headofstate LIKE "%Elizabeth II%";

-- 13. List the top ten countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0.
SELECT `name` `Country`, Population/SurfaceArea `Ratio` FROM country WHERE Population/SurfaceArea!=0 ORDER BY Population/SurfaceArea ASC LIMIT 10;

-- 14. List every unique world language.
SELECT DISTINCT `Language` FROM countrylanguage;

-- 15. List the names and GNP of the world's top 10 richest countries.
SELECT `name` `Country`, GNP FROM country ORDER BY GNP DESC LIMIT 10;

-- 16. List the names of, and number of languages spoken by, the top ten most multilingual countries.
SELECT c.name `Country` FROM countrylanguage cl 
JOIN country c ON cl.countrycode=c.code GROUP BY cl.countrycode HAVING count(cl.countrycode) ORDER BY count(cl.countrycode) DESC LIMIT 10;

-- 17. List every country where over 50% of its population can speak German.
SELECT c.name `Country`, cl.percentage `Percentage of population speaking German`  FROM countrylanguage cl 
JOIN country c ON cl.countrycode=c.code WHERE cl.percentage>50 AND cl.language = "German";

-- 18. Which country has the worst life expectancy? Discard zero or null values.
SELECT `name` `Country`, lifeexpectancy `Life Expectancy` From country WHERE lifeexpectancy IS NOT NULL AND lifeexpectancy>0 ORDER BY lifeexpectancy LIMIT 1;

-- 19. List the top three most common government forms.
SELECT GovernmentForm `Government Form` FROM country GROUP BY GovernmentForm HAVING count(GovernmentForm) ORDER BY count(GovernmentForm) DESC LIMIT 3;

-- 20. How many countries have gained independence since records began?
SELECT count(indepyear) `Number of countries`  FROM country where indepyear IS NOT NULL;