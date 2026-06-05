-- ============================================================================
-- SECTION 1: Artist Database Queries
-- ============================================================================

-- Switch the context to the v_art database
USE v_art;

-- Retrieve the country, first name, and last name of all artists from France
SELECT country, fname, lname
FROM artist
WHERE country = 'France';

-- Count the total number of artists who are from France
SELECT COUNT(country)
FROM artist
WHERE country = 'France';


-- ============================================================================
-- SECTION 2: Bike Database Queries
-- ============================================================================

-- Switch the context to the bike database
USE bike;

-- Calculate the average list price of all products, formatted to 2 decimal places
SELECT FORMAT(AVG(list_price), 2)
FROM product;

-- Calculate the total sum of all product list prices
SELECT SUM(list_price)
FROM product;

-- Retrieve the total sum, highest (maximum), and lowest (minimum) list prices across all products
SELECT SUM(list_price), MAX(list_price), MIN(list_price)
FROM product;

-- Calculate the average list price for each model year
SELECT AVG(list_price), model_year
FROM product
GROUP BY model_year;

-- Calculate the average list price for each model year, 
-- but only include individual products that cost more than $2,800
SELECT model_year, AVG(list_price)
FROM product
WHERE list_price > 2800
GROUP BY model_year;

-- Calculate the total sum of list prices for each model year (only for products > $2,800).
-- The WITH ROLLUP modifier adds a final row showing the grand total sum across all included years.
SELECT model_year, SUM(list_price)
FROM product
WHERE list_price > 2800
GROUP BY model_year WITH ROLLUP;

-- Calculate the average list price for each model year (only for products > $2,800),
-- but DISTINCT ensures duplicate prices within the same year are only counted once.
-- The WITH ROLLUP modifier adds a final row showing the overall average of unique prices.
SELECT model_year, AVG(DISTINCT list_price)
FROM product
WHERE list_price > 2800
GROUP BY model_year WITH ROLLUP;

-- Count the number of products over $2,800 for each model year, including a rollup total.
-- The HAVING clause filters the final grouped results, only displaying years (or the rollup) 
-- where the average list price exceeds $4,000.
SELECT model_year, COUNT(list_price)
FROM product
WHERE list_price > 2800
GROUP BY model_year WITH ROLLUP
HAVING AVG(list_price) > 4000;

-- Similar to the previous query, but this selects and displays the calculated average price 
-- (formatted to 2 decimal places) for each model year and the rollup row.
-- It still filters the final output to only show groups with an average price over $4,000.
SELECT model_year, FORMAT(AVG(list_price), 2)
FROM product
WHERE list_price > 2800
GROUP BY model_year WITH ROLLUP
HAVING AVG(list_price) > 4000;

-- Calculate the average list price (formatted to 2 decimal places) for each model year,
-- including a rollup total, filtering for products with "speed" in their name.
-- The HAVING clause restricts the output to years where the average list price exceeds $300.
SELECT model_year, FORMAT(AVG(list_price), 2)
FROM product
WHERE product_name LIKE "%speed%"
GROUP BY model_year WITH ROLLUP
HAVING AVG(list_price) > 300;

-- Retrieve the average list price for each brand name by joining product and brand tables.
-- The WITH ROLLUP modifier adds a final row showing the overall grand average price.
SELECT brand_name, AVG(list_price)
FROM product p
    JOIN brand b
        ON b.brand_id = p.brand_id
GROUP BY brand_name WITH ROLLUP;

-- Calculate the average list price per brand for products released after 2016, including a rollup.
-- The HAVING clause filters the results to only show brands with an average price over $2,000.
SELECT brand_name, AVG(list_price)
FROM product p
    JOIN brand b
        ON b.brand_id = p.brand_id
WHERE model_year > '2016'
GROUP BY brand_name WITH ROLLUP
HAVING AVG(list_price) > 2000;


-- ============================================================================
-- SECTION 3: Magazine Database Queries
-- ============================================================================

-- Switch the context to the magazine database
USE magazine;

-- Count the total number of subscribers for the magazine named "Beautiful Birds"
SELECT COUNT(subscriberKey) AS subscribers
FROM magazine m
    JOIN subscription sn
        ON m.magazineKey = sn.magazineKey
WHERE magazineName = "Beautiful Birds";

-- Count and display the number of subscribers for each magazine
SELECT magazineName, COUNT(subscriberKey) AS subscribers
FROM magazine m
    JOIN subscription sn
        ON m.magazineKey = sn.magazineKey
GROUP BY magazineName;

-- Count the number of subscribers per magazine, using the alias "subscribers" 
-- in the HAVING clause to filter for magazines with 2 or more subscribers.
SELECT magazineName, COUNT(subscriberKey) AS subscribers
FROM magazine m
    JOIN subscription sn
        ON m.magazineKey = sn.magazineKey
GROUP BY magazineName
HAVING subscribers >= 2;

-- Same as the previous query, but uses the aggregate function COUNT() directly 
-- in the HAVING clause instead of referencing the column alias.
SELECT magazineName, COUNT(subscriberKey) AS subscribers
FROM magazine m
    JOIN subscription sn
        ON m.magazineKey = sn.magazineKey
GROUP BY magazineName
HAVING COUNT(subscriberKey) >= 2;

-- Retrieve the total subscriber count and total revenue (sum of prices) for each magazine,
-- grouped and sorted alphabetically by the magazine name.
SELECT magazineName, COUNT(subscriberKey) AS subscribers, SUM(magazinePrice) AS 'Total Revenue'
FROM magazine m
    JOIN subscription sn
        ON m.magazineKey = sn.magazineKey
GROUP BY magazineName
ORDER BY magazineName;


-- ============================================================================
-- SECTION 4: Bike Database Queries (Continued)
-- ============================================================================

-- Switch the context back to the bike database
USE bike;

-- Find the highest (maximum) and lowest (minimum) list price for each bike brand
SELECT brand_name, MAX(list_price), MIN(list_price)
FROM product p
    JOIN brand b
        ON p.brand_id = b.brand_id
GROUP BY brand_name;

-- Calculate the total stock quantity available for each combination of store and product
SELECT store_name, product_name, SUM(quantity) AS stock
FROM store s
    JOIN stock st
        ON s.store_id = st.store_id
    JOIN product p
        ON st.product_id = p.product_id
GROUP BY product_name, store_name;

-- Calculate total stock for products starting with "Electra Cruiser 1 Ladies", 
-- grouped by product and store. The WITH ROLLUP modifier provides subtotals 
-- per product and an ultimate grand total of all matching stock.
SELECT store_name, product_name, SUM(quantity) AS stock
FROM store s
    JOIN stock st
        ON s.store_id = st.store_id
    JOIN product p
        ON st.product_id = p.product_id
WHERE product_name LIKE "Electra Cruiser 1 Ladies%"
GROUP BY product_name, store_name WITH ROLLUP;