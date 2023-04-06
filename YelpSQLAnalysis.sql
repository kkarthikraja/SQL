---1. Find the total number of records for each table:---
SELECT *
FROM [] --where [] is replaced by the desired table for each query

---2. Find the total distinct records for each table:---
SELECT COUNT (DISTINCT {}) --where {} is replaced by desired primary or foreign key column name
FROM [] --where [] is replaced by the desired table

---3. Are there any columns with null values in the Users table?---
SELECT *
    FROM user
    WHERE id IS NULL
      OR name IS NULL
      OR review_count IS NULL
      OR yelping_since IS NULL
      OR useful IS NULL
      OR funny IS NULL
      OR cool IS NULL
      OR fans IS NULL
      OR average_stars IS NULL
      OR compliment_hot IS NULL
      OR compliment_more IS NULL
      OR compliment_profile IS NULL
      OR compliment_cute IS NULL
      OR compliment_list IS NULL
      OR compliment_note IS NULL
      OR compliment_plain IS NULL
      OR compliment_cool IS NULL
      OR compliment_funny IS NULL
      OR compliment_writer IS NULL
      OR compliment_photos IS NULL

---4. For each table and column listed below, display the smallest, largest, and average value for the following fields:---

    SELECT --replace "stars" with desired column 
      MIN(stars), 
      MAX(stars),
      AVG(stars)
    FROM review --replace "review" with desired table 

---5. List the cities with the most reviews in descending order:---

    SELECT city,
      SUM(review_count) AS review_count
    FROM business
    GROUP BY city
    ORDER BY review_count DESC

---6. Find the distribution of star ratings to the business in the following cities:---
    SELECT stars,
      COUNT (review_count) as reviews
    FROM business
    WHERE city = 'Avon'
    GROUP BY stars

    SELECT stars,
      COUNT (review_count) as reviews
    FROM business
    WHERE city = 'Beachwood'
    GROUP BY stars

---7. Find the top 3 users based on their total number of reviews:---

    SELECT name,
      review_count
    FROM user
    ORDER BY review_count DESC
    LIMIT 3

---8. Does posting more reviews correlate with more fans?---

    SELECT name,
      review_count AS most_reviews,
      fans
    FROM user
    ORDER BY review_count DESC
    LIMIT 5

SELECT name,
      review_count,
      fans AS most_fans
    FROM user
    ORDER BY fans DESC
    LIMIT 5

---9. Are there more reviews with the word "love" or with the word "hate" in them?---

    SELECT 
      SUM(CASE WHEN text LIKE '%love%' THEN 1 ELSE 0 END) AS love_reviews,--counts reviews with love in text
      SUM(CASE WHEN text LIKE '%hate%' THEN 1 ELSE 0 END) AS hate_reviews--counts reviews with hate in text
    FROM review

       SELECT
         stars,
         CASE WHEN text LIKE '%love%' THEN text ELSE 0 END AS love_reviews
       FROM review
       WHERE stars IN ('1', '2')
         AND love_reviews IS NOT 0
       ORDER BY stars

---10. Find the top 10 users with the most fans:---

    SELECT name,
      fans
    FROM user
    ORDER BY fans DESC
    LIMIT 10

---Section 1: High vs Mid-range Ratings---

    SELECT b.name,
      h.hours,
      b.stars,
      b.review_count,
      b.neighborhood,
      b.postal_code
    FROM business b
      LEFT JOIN category c ON c.business_id = b.id
      LEFT JOIN hours h ON h.business_id = c.business_id
    WHERE b.city = 'Phoenix'  
      AND c.category = 'Restaurants'
    GROUP BY b.name

    SELECT b.name,
      h.hours
    FROM business b
      LEFT JOIN category c ON c.business_id = b.id
      LEFT JOIN hours h ON h.business_id = c.business_id
    WHERE b.city = 'Phoenix'
      AND c.category = 'Restaurants'
      AND b.stars BETWEEN '4.0' AND '5.0'
    ORDER BY b.stars DESC
    --Do not GROUP BY b.name, otherwise full operating hours will not be show---

    SELECT b.name,
      h.hours
    FROM business b
      LEFT JOIN category c ON c.business_id = b.id
      LEFT JOIN hours h ON h.business_id = c.business_id
    WHERE b.city = 'Phoenix'
      AND c.category = 'Restaurants'
      AND b.stars BETWEEN '2.0' AND '3.9'
    ORDER BY b.stars DESC
    --Do not GROUP BY b.name, otherwise full operating hours will not be shown---

---Section 1, part ii: Do the two groups you chose to analyze have a different number of reviews?---

  SELECT SUM(CASE WHEN b.stars BETWEEN '4.0' and '5.0' THEN b.review_count ELSE 0 END) AS '4-5 star rating',
    SUM(CASE WHEN b.stars BETWEEN '2.0' and '3.9' THEN b.review_count ELSE 0 END) AS '2-3 star rating'
  FROM business b
    LEFT JOIN category c ON c.business_id = b.id
  WHERE b.city = 'Phoenix'
    AND c.category = 'Restaurants'

    SELECT DISTINCT b.name,
      b.stars,
      b.review_count
    FROM business b
      LEFT JOIN category c ON c.business_id = b.id
      LEFT JOIN hours h ON h.business_id = c.business_id
    WHERE b.city = 'Phoenix'
      AND c.category = 'Restaurants'
    ORDER BY b.stars DESC

  SELECT
    CASE WHEN b.is_open IS 1 THEN 'Yes' ELSE 'No' END AS 'Is Open?',--rename boolean integers to 'yes' or 'no' values
    COUNT(b.is_open) AS '# of Businesses',
    ROUND(AVG(b.stars),1) AS 'Average Star Rating',
    SUM(b.review_count) AS 'Total Reviews'
  FROM business b
  GROUP BY b.is_open


    SELECT b.state,
      b.postal_code
    FROM category c
      JOIN business b ON c.business_id = b.id
    WHERE c.category IN ('Chinese', 'Japanese', 'Indian', 'Mexican', 'Italian', 
        'Irish', 'American (Traditional)', 'French', 'Greek')
      AND LENGTH(b.postal_code) = 5
    ORDER BY state

    SELECT c.category AS 'Category',
      CASE WHEN b.is_open IS 1 THEN 'Yes' ELSE 'No' END AS 'Is Open?',
      COUNT(c.category) AS '# of Businesses',
      SUM(b.review_count) AS 'Total Reviews',
      ROUND(AVG(b.review_count),0) AS 'Average # of Reviews',
      ROUND(AVG(b.stars),1) AS 'Average Star Rating'
    FROM category c
      JOIN business b ON c.business_id = b.id
    WHERE c.category IN ('Chinese', 'Japanese', 'Indian', 'Mexican', 'Italian', 
        'Irish', 'American (Traditional)', 'French', 'Greek')
      AND LENGTH (postal_code) = 5
    GROUP BY b.is_open,
      c.category
    ORDER BY b.is_open DESC,
      SUM(b.review_count) DESC

