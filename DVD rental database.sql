---/* DVD Rental Database Queries in SQL using PostgreSQL */---


SELECT first_name, last_name
FROM actor
WHERE first_name = 'Penelope'

SELECT first_name, last_name
FROM actor
WHERE actor_id <5

SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id >3 AND actor_id <=5

SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id BETWEEN 3 AND 5

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Penelope'
OR actor_id <5
OR first_name = 'Nick'

--

/* Filtering Using Like, IN (matches any of the following), and Wildcards*/
SELECT *
FROM actor
WHERE first_name IN ('Penelope', 'Nick', 'Ed')

SELECT *
FROM actor
WHERE first_name NOT IN ('Penelope', 'Nick', 'Ed')

SELECT *
FROM actor
WHERE first_name LIKE 'John%'

SELECT *
FROM actor
WHERE first_name LIKE 'Ja_ne'

SELECT * 
FROM address
WHERE district = 'Buenos Aires'
AND (address like '%El%' OR address like '%Al%')

--

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Penelope'
ORDER BY last_name ASC

--
/* String functions - formula on text*/
SELECT first_name, LENGTH (first_name)
FROM actor

SELECT CONCAT(first_name, ' ', last_name)
FROM actor
OR
SELECT first_name || ' ' || last_name
FROM actor

SELECT CONCAT(first_name, ' ', last_name), LENGTH(CONCAT(first_name, ' ', last_name))
FROM actor

SELECT CONCAT(first_name, ' ', last_name), LENGTH(CONCAT(first_name, ' ', last_name))
FROM actor
ORDER BY LENGTH(CONCAT(first_name, ' ', last_name)) DESC

SELECT INITCAP(first_name)
FROM actor

SELECT LEFT(first_name, 1)
FROM actor

SELECT CONCAT(LEFT(first_name, 1), LOWER(RIGHT(first_name, LENGTH(first_name)-1)))
FROM actor

SELECT SUBSTRING(first_name, 1, 1)
FROM actor

/* with fewer arguments, start position 2 and take rest of word */
SELECT SUBSTRING(first_name, 2)
FROM actor

SELECT CONCAT(SUBSTRING(first_name, 1,1), LOWER(SUBSTRING(first_name,2)))
FROM actor

/* USE Trim and Locate */
SELECT *
FROM actor
WHERE TRIM(first_name) = 'Grace'

SELECT description as original, TRIM(LEADING 'A ' from description) as modified
FROM film
/* LTRIM and RTRIM in Microsoft but can also use TRIM from both ends at same time*/

SELECT POSITION('lope' in first_name) 
FROM actor
/* LOCATE or other function may need to be used in other platforms. CHARINDEX in microsoft*/

--
/* Change report headings with alias*/

SELECT CONCAT(first_name, ' ', last_name),
LENGTH(CONCAT(first_name, ' ', last_name))
FROM actor
ORDER BY CONCAT (first_name, ' ', last_name) DESC

/* OR use this to shorten headings */
SELECT CONCAT(first_name, ' ', last_name) as name,
LENGTH(CONCAT(first_name, ' ', last_name)) as len
FROM actor
ORDER BY len DESC

SELECT CONCAT(first_name, ' ', last_name) as name, LENGTH(CONCAT(first_name, ' ', last_name)) as len
FROM actor
WHERE LENGTH(CONCAT(first_name, ' ', last_name))>17
ORDER BY len DESC

--
/* Date functions */
SELECT *
FROM address
WHERE last_update > '2006-02-15' 
/*because not including time*/

/*Get exact match. Microsoft timestamp has a different data type and now deprecated. nearest data time is called datetime*/
SELECT *
FROM address
WHERE last_update = '2006-02-15 09:45:30'

SELECT *
FROM address
WHERE EXTRACT(YEAR FROM(last_update)) = 2006
/* date_part to extract year or year-month etc. in Microsoft */

SELECT *
FROM address
WHERE DATE(last_update) = '2006-02-15'
/*Microsoft uses CONVERT function*/

/*Change format from european to american or vice versa*/
SELECT TO_CHAR(last_update, 'MM-DD-YYYY')
FROM address
/*Likely will be different in other platforms, like date_format or format*/

--

/* Grouping results */

SELECT *
FROM address
WHERE address2 IS null

/* GROUP BY with count*/
SELECT district, count(*) as ct
FROM address
GROUP BY district
ORDER BY ct DESC

SELECT district, count(*) as ct
FROM address
WHERE address_id<10
GROUP BY district
ORDER BY ct DESC

/* Filter grouped results with HAVING */
SELECT district, count(*)
FROM address
WHERE district LIKE '%B%' /*District needs to have a B in it */
GROUP BY district
HAVING count(*) > 8
ORDER BY count(*) DESC

SELECT MIN(rental_duration), MAX(rental_duration), AVG(rental_duration)
FROM film

SELECT rating, SUM(rental_duration)
FROM film
GROUP BY rating

SELECT AVG(EXTRACT(YEAR FROM last_update))
FROM actor

/* De duplicate with SELECT DISTINCT */
SELECT DISTINCT district
FROM address

SELECT DISTINCT customer_id, inventory_id
FROM rental

/* how many staff? */
SELECT DISTINCT staff_id
FROM rental

/* shows every customer has been served by both members of staff */
SELECT DISTINCT staff_id, customer_id
FROM rental

/* Has any cust rented same dvd twice. 16044*/
SELECT DISTINCT customer_id, inventory_id
FROM rental

/*This shows 4 fewer. should be same as previous query. 16040 */
SELECT DISTINCT CONCAT(customer_id, inventory_id)
FROM rental

/* Investigate: */
SELECT CONCAT(customer_id, inventory_id) AS conc, count(*) as ct
FROM rental
GROUP BY conc
ORDER BY ct DESC

/* This showed that concatenations for 4 were not registering or separated properly, so added underscore: */
SELECT CONCAT(customer_id, '_', inventory_id) AS conc, count(*) as ct
FROM rental
GROUP BY conc
ORDER BY ct DESC

/* Merge rows with GROUP BY. return all phone numbers grouped by city*/
SELECT district, GROUP_CONCAT(phone)
FROM address
GROUP BY district
/*good for creating arrays in other languates. STRINGAG or LISTAG to change the separator*/

--

/* Merge data from multiple tables */
SELECT *
FROM payment
LIMIT 25
/*in microsoft would use SELECT TOP 25 fieldname FROM payment*/

/* Merge data across tables with join */
SELECT *
FROM customer
JOIN address
ON customer.address_id = address.address_id

/* OR this way: */
SELECT *
FROM customer c
JOIN address a
ON c.address_id = a.address_id

SELECT *
FROM customer AS c JOIN address AS a
ON c.address_id = a.address_id
WHERE district = 'Buenos Aires'

/*LOOK FOR ERRORS... using two fake tables, table a = day of week with person_id of worker and table b is person_id for worker and worker name*/
/*records in table a lack a corresponding record in table b*/
SELECT a.day, a.person_id
FROM tableA AS a LEFT JOIN tableB as b
ON a.person_id = b.person_id
WHERE b.person_id IS NULL

/* Use UNION to combine rows */
/* Unions work vertically and don't care about matching records. */
/* Joins for 2 tables with 3 columns and 6 rows each output 6 cols and 6 rows*/
/* Unions for same output 3 cols and 12 rows*/

SELECT 'actor' as tbl, DATE(last_update)
FROM actor
UNION ALL
SELECT 'address' as tbl, DATE(last_update)
FROM address

/* Runs select distinct by default*/
SELECT 'actor' as tbl, DATE(last_update)
FROM actor
UNION
SELECT 'address' as tbl, DATE(last_update)
FROM address

SELECT 'actor' as tbl, DATE(last_update)
FROM actor
UNION ALL
SELECT 'address' as tbl, DATE(last_update)
FROM address 
WHERE address_id <5

--

/* Merge using IN */
/* where cust id matches any of customer id in other select. so all rentals by mary*/
SELECT *
FROM rental 
WHERE customer_id IN(
SELECT customer_id
FROM customer
WHERE first_name = 'Mary')

--

/* Select from selection wtih subqueries */
SELECT f.first_name FROM   /*from result set f use first_name*/
(SELECT first_name FROM actor) as f   /*select this and call it f*/

/* OR SIMILAR: */
SELECT f.fn FROM
(SELECT first_name AS fn FROM actor) as f

--
/*View is a stored query*/
/* VIEWs in pgadmin can be taken from properties. */
SELECT a.actor_id,
    a.first_name,
    a.last_name,
    group_concat(DISTINCT (c.name::text || ': '::text) || (( SELECT group_concat(f.title::text) AS group_concat
           FROM film f
             JOIN film_category fc_1 ON f.film_id = fc_1.film_id
             JOIN film_actor fa_1 ON f.film_id = fa_1.film_id
          WHERE fc_1.category_id = c.category_id AND fa_1.actor_id = a.actor_id
          GROUP BY fa_1.actor_id))) AS film_info
   FROM actor a
     LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
     LEFT JOIN film_category fc ON fa.film_id = fc.film_id
     LEFT JOIN category c ON fc.category_id = c.category_id
  GROUP BY a.actor_id, a.first_name, a.last_name;

/*BREAKDOWN of the above view*/
/* mass of film names*/
SELECT group_concat(f.title::text) AS group_concat
           FROM film f
             JOIN film_category fc_1 ON f.film_id = fc_1.film_id
             JOIN film_actor fa_1 ON f.film_id = fa_1.film_id
/*Taking unique values and adding film category name and colon*/
group_concat(DISTINCT (c.name::text || ': '::text) ||
/*Then perform final group_concat organizing by category name*/
WHERE fc_1.category_id = c.category_id AND fa_1.actor_id = a.actor_id
          GROUP BY fa_1.actor_id))) AS film_info
          
/*Join views to tables or views to other views*/
CREATE VIEW view_name AS SELECT group_concat(f.title::text) AS group_concat
           FROM film f
             JOIN film_category fc_1 ON f.film_id = fc_1.film_id
             JOIN film_actor fa_1 ON f.film_id = fa_1.film_id

--

/* Use Variables as filter or to store results into a variable with SELECT INTO */
/* Good for long query and making reference to id multiple times */

/*MYSQL but may be different in other platforms*/
SET @variable1 = 5; 
SELECT * FROM actor WHERE actor_id < @variable1;

/*MICROSOFT transact sql or t-sql*/
DECLARE @var1 varchar(30);
SET @var1 = 'Penelope';
SELECT * FROM actor WHERE first_name = @var1

/* PostGre PL/pgSQL */
DECLARE var1 text;
BEGIN 
    SELECT * FROM employees WHERE first_name = var1;
END

/* Store result set into a variable */
/* Return a single row. # vars = # cols */
SELECT col1, col2 INTO @x, @y FROM table1 LIMIT 1;

--

/* FUNCTIONS take input and calculate output along rules provided*/
/* in PGADMIn found under functions. To call:*/
/*SELECT name_of_function (what to search)*/

/*Here's the function:*/
DECLARE
    v_customer_id INTEGER;
BEGIN

  SELECT customer_id INTO v_customer_id
  FROM rental
  WHERE return_date IS NULL
  AND inventory_id = p_inventory_id;

  RETURN v_customer_id;
END 

/* returns 155 for customer id of person who has inventory ID on loan*/
SELECT inventory_held_by_customer(2047) 

/*NULL, either neither customer has on loan or has ever had on loan, so investigage further*/
SELECT inventory_held_by_customer(367) 

/* DVD has been rented, but return date is filled in so not currently out*/
SELECT * FROM rental WHERE inventory_id=367 

/* want email address of customer who still has a movie on loan */
SELECT email FROM customer
WHERE inventory_held_by_customer(2047) = customer_id
AND inventory_held_by_customer(2047) IS NOT NULL

--

/*STORED procedures, edit or delete data. Return value*/
/*Which copies of film are on loan from particulare store*/
/*Film not in stock is listed as a function in PgADMIN rather than a procedure*/
/*in MYSQL can't call stored procedure from function but can call function from stored procedure*/

    SELECT inventory_id
    FROM inventory
    WHERE film_id = $1
    AND store_id = $2
    AND NOT inventory_in_stock(inventory_id); /*checking if in or out of stock in rental tale*/

SELECT film_not_in_stock(39,2)

SELECT * from inventory where film_id=39 AND store_id=2

SELECT * FROM rental WHERE inventory_id IN (177, 178, 179, 180) /* returns 12 with 1 null in rtrun date, and that's the one that is still out. Tells us how the first one came back with 177*/ 
