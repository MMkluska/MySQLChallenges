USE movielens;

-- 1. List the titles and release dates of movies released between 1983-1993 in reverse chronological order.
SELECT `Title`, release_date `Release Date` FROM movies WHERE release_date BETWEEN '1983-01-01' AND '1993-12-31' ORDER BY release_date DESC;

-- 2. Without using LIMIT, list the titles of the movies with the lowest average rating.
SELECT `Title` FROM movies WHERE id IN (
SELECT movie_id FROM ratings GROUP BY movie_id HAVING AVG(rating)=MIN(rating) ORDER BY AVG(rating) ASC);
 
-- 3. List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.
SELECT DISTINCT m.Title FROM ratings r
JOIN users u ON r.user_id=u.id
JOIN occupations o ON u.occupation_id=o.id
JOIN genres_movies gm ON r.movie_id=gm.movie_id
JOIN genres g ON gm.genre_id=g.id
JOIN movies m ON r.movie_id=m.id WHERE u.gender="m" AND u.age=24 AND o.name="student" AND g.name="Sci-Fi" AND r.rating=5;

-- 4. List the unique titles of each of the movies released on the most popular release day.
SELECT DISTINCT Title FROM movies WHERE release_date = (
SELECT release_date FROM movies GROUP BY release_date ORDER BY count(release_date) DESC LIMIT 1);

-- 5. Find the total number of movies in each genre; list the results in ascending numeric order.
SELECT g.name `Genre`, count(gm.genre_id) `Number of movies` FROM genres_movies gm
JOIN genres g ON gm.genre_id=g.id GROUP BY gm.genre_id ORDER BY count(gm.genre_id) ASC;