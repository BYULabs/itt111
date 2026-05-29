USE bike;

SELECT * FROM product;

SELECT product_name, model_year, list_price + 100 AS marked_up, list_price
FROM product
WHERE list_price + 100 > 1000
ORDER BY marked_up;

SELECT product_name, model_year
FROM product
WHERE (product_name LIKE 'Trek%' OR product_name LIKE 'Surly%') AND model_year <> 2016
ORDER BY model_year;

SELECT product_name, list_price, ROUND(list_price - list_price * .05, 2)AS '50% off'
FROM product;

SELECT product_name, list_price, ROUND(list_price - list_price * .05, 2)AS '50% off'
FROM product;

SELECT product_id, ROUND(DATEDIFF(NOW() shipped_date)/365) AS 'Years since subscription'
FROM cust_order;

SELECT cust_order_id, ROUND(DATEDIFF(NOW(), shipped_date)/365) AS 'Years since product shipped'
FROM cust_order;

SELECT product_name, list_price, list_price - 500 AS 'Discount Price'
FROM product
WHERE list_price > 5000
ORDER BY list_price DESC;

SELECT product_name, list_price, list_price - 500 AS 'Discount Price'
WHERE list_price > 5000
ORDER BY list_price DESC;

SELECT first_name, last_name, phone FROM customer
WHERE state='TX' AND city = 'Houston';

SELECT shipped_date, DATE_FORMAT(DATE_ADD(shipped_date, INTERVAL 2 MONTH), '%c / %e / %y') AS '2 months after shipped'
FROM cust_order;

SELECT shipped_date, DATE_FORMAT(DATE_ADD(shipped_date, INTERVAL 2 MONTH), '%c / %e / %y') AS '2 months after shipped'
FROM cust_order;

SELECT shipped_date, DATE_FORMAT(DATE_ADD(shipped_date, INTERVAL 2 MONTH), '%c / %e / %y') AS '2 months after shipped'
FROM cust_order;

SELECT LEFT(product_name, LOCATE('2016', product_name, 1)) AS 'Year 2016'
FROM product
WHERE product_name LIKE '%girl%'
ORDER BY product_name
LIMIT 14;

SELECT product_name
FROM product;

SELECT LEFT(product_name, LOCATE('2016', product_name, 1)) AS 'Year 2016'
FROM product
WHERE product_name LIKE '%girl%'
ORDER BY product_name
LIMIT 14;

SELECT product_name
FROM product;

SELECT LEFT(product_name, LOCATE('2016', product_name, 1)) AS 'Year 2016'
FROM product
WHERE product_name LIKE '%girl%'
ORDER BY product_name
LIMIT 14;
