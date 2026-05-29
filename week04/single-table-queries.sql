-- ========== VIRTUAL ART GALLERY QUERIES ==========
USE v_art;

-- 1. Insert new artist: Johannes Vermeer
INSERT INTO artist (fname, mname, lname, dob, dod, country, local)
VALUES ('Johannes', NULL, 'Vermeer', 1632, 1674, 'Netherlands', 'n');

-- 2. List all artists sorted by last name
SELECT artist_id, fname, mname, lname, dob, dod, country, local
FROM artist
ORDER BY lname ASC;

-- 3. Update artist death year: Vermeer died in 1675
UPDATE artist
SET dod = 1675
WHERE fname = 'Johannes' AND lname = 'Vermeer';

-- 4. Delete artist: Johannes Vermeer
DELETE FROM artist
WHERE fname = 'Johannes' AND lname = 'Vermeer';


-- ========== BIKE SHOP QUERIES ==========
USE bike;

-- 5. Get Houston customers for product demonstration contact list
SELECT first_name, last_name, phone
FROM customer
WHERE city = 'Houston';

-- 6. High-end bikes with $500 discount, sorted by price descending
SELECT product_name, list_price, (list_price - 500.00) AS 'Discount Price'
FROM product
WHERE list_price >= 5000.00
ORDER BY list_price DESC;

-- 7. Staff contact list: all staff not from store 1
SELECT first_name, last_name, email
FROM staff
WHERE store_id <> 1;

-- 8. Find bike with 'spider' in the name
SELECT product_name, model_year, list_price
FROM product
WHERE product_name LIKE '%spider%';

-- 9. Bikes in $500-$550 price range, sorted lowest to highest price
SELECT product_name, list_price
FROM product
WHERE list_price BETWEEN 500.00 AND 550.00
ORDER BY list_price ASC;

-- 10. Find customers by: phone exists AND (city has 'ach'/'och' OR last name is William), limit 5
SELECT first_name, last_name, phone, street, city, state, zip_code
FROM customer
WHERE (phone IS NOT NULL AND (city LIKE '%ach%' OR city LIKE '%och%'))
   OR last_name = 'William'
LIMIT 5;

-- 11. Trek and Surly products with brand names removed, first 10 results
SELECT 
    REPLACE(REPLACE(product_name, 'Trek ', ''), 'Surly ', '') AS 'Model'
FROM product
WHERE product_name LIKE 'Trek %' OR product_name LIKE 'Surly %'
ORDER BY product_id
LIMIT 10;

-- 12. 2025 model bikes with 3-payment price breakdown
SELECT 
    product_name, 
    CONCAT('$', FORMAT(list_price / 3, 2)) AS 'One of 3 payments'
FROM product
WHERE model_year = 2025;


-- ========== MAGAZINE DATABASE QUERIES ==========
USE magazine;

-- 13. List magazines with 3% discount, rounded to 2 decimal places
SELECT 
    magazineName, 
    ROUND(magazinePrice * 0.97, 2) AS '3% off'
FROM magazine;

-- 14. Calculate years since subscription started (as of 2026-05-29)
SELECT 
    subscriberKey, 
    ROUND(DATEDIFF('2026-05-29', subscriptionStartDate) / 365.25, 0) AS 'Years since subscription'
FROM subscription;

-- 15. Calculate subscription end date with formatted output (Month Day, Year)
SELECT 
    subscriptionStartDate, 
    subscriptionLength, 
    DATE_FORMAT(DATE_ADD(subscriptionStartDate, INTERVAL subscriptionLength MONTH), '%M %e, %Y') AS 'subscription end'
FROM subscription;
