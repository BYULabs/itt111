-- ============================================================================
-- DATABASE: v_art (Art Gallery Database Practice)
-- ============================================================================
USE v_art;

-- Retrieve only the titles of all artworks
SELECT title
FROM artwork;

-- Retrieve the internal artist ID and the title for all artworks
SELECT artist_id, title
FROM artwork;

-- WRONG APPROACH: Attempting to pull artist names and artwork titles.
-- Missing an 'ON' clause creates a CARTESIAN PRODUCT (Cross Join),
-- matching every single artist with every single artwork blindly.
SELECT fname, lname, title
FROM artwork JOIN artist;

-- Same as above: Demonstrates that 'JOIN' defaults to an 'INNER JOIN', 
-- but still lacks the matching logic, resulting in a Cartesian product.
SELECT fname, lname, title
FROM artwork INNER JOIN artist;

-- CORRECT APPROACH: Uses the 'ON' clause to explicitly state the relationship.
-- Properly matches the artwork to the correct artist using the 'artist_id' foreign key.
SELECT fname, lname, title
FROM artwork 
	JOIN artist 
	ON artwork.artist_id = artist.artist_id;

-- Adding a filter (WHERE clause) to restrict the correct join results 
-- exclusively to artworks created by 'da Vinci'.
SELECT fname, lname, title
FROM artwork 
	JOIN artist 
	ON artwork.artist_id = artist.artist_id
WHERE lname = 'da Vinci';

-- Quick lookup to see all columns and data available in the artist table
SELECT * FROM artist;


-- ============================================================================
-- DATABASE: bike (Bicycle Retail Database Practice)
-- ============================================================================
USE bike;

-- Inspect all available product categories
SELECT * FROM category;

-- Inspect all available products and their attributes
SELECT * FROM product;

-- Two-Table Join: Pulls product details along with their human-readable category name
SELECT product_name, category_name, list_price
FROM product
	JOIN category
    ON product.category_id = category.category_id;
    
-- Three-Table Join: Extends the previous query to also pull in the brand name 
-- by linking the 'brand' table via 'brand_id'.
SELECT product_name, category_name, brand_name, list_price
FROM product
	JOIN category
    ON product.category_id = category.category_id
    JOIN brand
    ON product.brand_id = brand.brand_id;
    
-- Three-Table Join with Filter: Restricts the previous query to only show 
-- items belonging to the "Children Bicycles" category.
SELECT product_name, category_name, brand_name, list_price
FROM product
	JOIN category
    ON product.category_id = category.category_id
    JOIN brand
    ON product.brand_id = brand.brand_id
WHERE category_name = "Children Bicycles";

-- Three-Table Join with Table Aliases: Identical to the query above, 
-- but uses short aliases (p, c, b) to make the SQL cleaner and easier to read.
SELECT product_name, category_name, brand_name, list_price
FROM product p
	JOIN category c
    ON p.category_id = c.category_id
    JOIN brand b
    ON p.brand_id = b.brand_id
WHERE category_name = "Children Bicycles";

-- Two-Table Join with Filter: Retrieves staff names who work specifically 
-- at the "Rowlett Bikes" store location.
SELECT first_name, last_name
FROM staff f
	JOIN store e
    ON f.store_id = e.store_id 
WHERE store_name = "Rowlett Bikes";


-- ============================================================================
-- DATABASE: v_art (Many-to-Many Relationship Practice)
-- ============================================================================
USE v_art;

-- Many-to-Many Join: Finds all artwork titles tagged with the keyword "water".
-- Requires joining through the bridge/associative table 'artwork_keyword'.
SELECT title
FROM artwork a
	JOIN artwork_keyword ak
    ON a.artwork_id = ak.artwork_id
    JOIN keyword k
    ON ak.keyword_id = k.keyword_id
WHERE keyword = "water";


-- ============================================================================
-- DATABASE: employees (Complex Multi-Table Practice)
-- ============================================================================
USE employees;

-- Four-Table Join with Date Filter: Compiles employee names, their department, 
-- their salary history, and the start date, filtering for records after Dec 31, 2000.
SELECT first_name, last_name, dept_name, salary, s.from_date
FROM employees e
	JOIN dept_emp de
    ON e.emp_no = de.emp_no
    JOIN departments d
    ON d.dept_no = de.dept_no
    JOIN salaries s
    ON e.emp_no = s.emp_no
WHERE s.from_date > "2000-12-31";


-- ============================================================================
-- DATABASE: world (Geographical Data Practice)
-- ============================================================================
USE world;

-- Inspect the schema and data for countries
SELECT * FROM country;

-- Inspect the schema and data for cities
SELECT * FROM city;

-- Two-Table Join: Matches cities to their respective countries.
-- Note: 'code' comes from country, 'countrycode' comes from city.
SELECT co.name, ci.name
FROM city ci
	JOIN country co
    ON code = countrycode;
    

-- ============================================================================
-- DATABASE: bike (Deep Relational Join Practice)
-- ============================================================================
USE bike;

-- Four-Table Join: Traces back what products a specific customer bought.
-- Connects: Customer -> Orders -> Order Items -> Products, 
-- filtered specifically for customers with the last name "Baldwin".
SELECT product_name, order_date
FROM customer c
	JOIN cust_order co
    ON c.customer_id = co.customer_id
    JOIN cust_order_item coi
    ON co.cust_order_id = coi.cust_order_id
    JOIN product p
    ON coi.product_id = p.product_id
WHERE last_name = "Baldwin";