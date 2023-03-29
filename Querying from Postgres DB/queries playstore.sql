-- Comments in SQL Start with dash-dash --

SELECT * FROM analytics
WHERE id = 1880;

SELECT id, app_name FROM analytics
WHERE last_updated = '2018-08-01';

SELECT category, COUNT(*) FROM analytics
GROUP BY category;

SELECT * FROM analytics
ORDER BY reviews DESC
LIMIT 5;

SELECT * FROM analytics
WHERE rating >= 4.8
ORDER By reviews DESC
LIMIT 1;

SELECT category, AVG(rating) FROM analytics 
GROUP BY category 
ORDER BY avg DESC;

SELECT app_name, price, rating FROM analytics
WHERE rating < 3
ORDER BY price < DESC
LIMIT 1;

SELECT * FROM analytics 
WHERE min_installs <= 50 
AND rating IS NOT NULL 
ORDER BY rating DESC;

SELECT app_name FROM analytics
WHERE rating < 3 AND reviews >= 10000;

SELECT * FROM analytics
WHERE price BETWEEN 0.1 and 1 
ORDER BY reviews DESC 
LIMIT 10;

SELECT * FROM analytics 
WHERE last_updated = (SELECT MIN(last_updated) FROM analytics);

SELECT * FROM analytics 
WHERE price = (SELECT MAX(price) FROM analytics);

SELECT SUM(reviews) AS "All Reviews" FROM analytics;

SELECT category FROM analytics 
GROUP BY category 
HAVING COUNT(*) > 300;

SELECT app_name, reviews, min_installs,  min_installs / reviews AS proportion
FROM analytics
WHERE min_installs >= 100000
ORDER BY proportion DESC
LIMIT 1;

SELECT app_name, rating, category FROM analytics
WHERE (rating, category) in (
SELECT MAX(rating), category FROM analytics
WHERE min_installs >= 50000
GROUP BY category)
ORDER BY category;

SELECT * FROM analytics 
WHERE app_name ILIKE '%facebook%';

SELECT * FROM analytics 
WHERE genres @> '{"Education"}';

SELECT * FROM analytics 
WHERE  array_length(genres, 1) = 2; --a bit confused on this one--