USE v_art;

-- Question 1
SELECT artfile 
FROM artwork 
WHERE period = 'Impressionism';

-- Question 2
SELECT artfile
FROM artwork a
	JOIN artwork_keyword ak 
		ON a.artwork_id = ak.artwork_id
	JOIN keyword k 
		ON ak.keyword_id = k.keyword_id
WHERE k.keyword LIKE '%flower%';

-- Question 3
SELECT fname, lname, title
FROM artist ar
	LEFT JOIN artwork aw 
		ON ar.artist_id = aw.artist_id;
        
USE magazine;

-- Question 4
SELECT magazineName, subscriberLastName, subscriberFirstName
FROM subscription sub
	JOIN magazine m 
		ON sub.magazineKey = m.magazineKey
	JOIN subscriber s 
		ON sub.subscriberKey = s.subscriberKey
ORDER BY magazineName ASC;

-- Question 5
SELECT magazineName
FROM subscription sub
	JOIN magazine m 
		ON sub.magazineKey = m.magazineKey
	JOIN subscriber s 
		ON sub.subscriberKey = s.subscriberKey
WHERE subscriberFirstName = 'Samantha' 
AND subscriberLastName = 'Sanders';

USE employees;

-- Question 6
SELECT first_name, last_name
FROM employees e
	JOIN dept_emp de 
		ON e.emp_no = de.emp_no
	JOIN departments d 
		ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service'
ORDER BY e.last_name ASC
LIMIT 5;

-- Question 7
SELECT e.first_name, e.last_name, d.dept_name, s.salary, s.from_date
FROM employees e
	JOIN salaries s 
		ON e.emp_no = s.emp_no
	JOIN dept_emp de 
		ON e.emp_no = de.emp_no
	JOIN departments d 
		ON de.dept_no = d.dept_no
WHERE e.first_name = 'Berni' 
AND e.last_name = 'Genin'
ORDER BY s.from_date DESC
LIMIT 1;

USE bike;

-- Question 8
SELECT ROUND(AVG(quantity), 0) AS 'Stock Average'
FROM stock;

-- Question 9
SELECT DISTINCT product_name
FROM stock s
	JOIN product p 
    ON s.product_id = p.product_id
WHERE quantity = 0
ORDER BY product_name ASC;

-- Question 10
SELECT category_name, SUM(quantity) AS instock
FROM stock s
	JOIN product p 
		ON s.product_id = p.product_id
	JOIN category c 
		ON p.category_id = c.category_id
WHERE store_id = 2
GROUP BY category_name
ORDER BY instock ASC;

USE employees;

-- Question 11
SELECT COUNT(*) AS 'Number of Employees'
FROM employees;

-- Question 12
SELECT dept_name, FORMAT(AVG(salary), 2) AS average_salary
FROM departments d
	JOIN dept_emp de 
		ON d.dept_no = de.dept_no
	JOIN salaries s 
		ON de.emp_no = s.emp_no
GROUP BY dept_name
HAVING AVG(salary) < 60000;

-- Question 13
SELECT dept_name, COUNT(e.emp_no) AS 'Number of Females'
FROM departments d
	JOIN dept_emp de 
		ON d.dept_no = de.dept_no
	JOIN employees e 
		ON de.emp_no = e.emp_no
WHERE gender = 'F'
GROUP BY dept_name
ORDER BY dept_name ASC;