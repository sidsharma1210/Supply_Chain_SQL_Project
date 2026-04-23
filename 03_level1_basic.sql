-- ============================================================
-- LEVEL 1: BASIC QUERIES
-- Focus: SELECT, FROM, WHERE, ORDER BY, GROUP BY
-- ============================================================
USE supply_chain;

-- 1. Customer Demographics: count per country
SELECT COUNT(id) AS total_customers, country 
FROM customer
GROUP BY country ORDER BY total_customers DESC;

-- 2. Active Inventory
SELECT * FROM product WHERE isdiscontinued = 0;

-- 3. Supplier Catalog
SELECT s.companyname, p.productname 
FROM product p JOIN supplier s ON s.id = p.supplierid;

-- 4. Regional Search
SELECT * FROM customer WHERE country = 'Mexico';

-- 5. High-Value Items per customer
SELECT firstname, lastname, productname, unitprice 
FROM jointables
WHERE (unitprice, firstname, lastname) IN (
    SELECT MAX(unitprice), firstname, lastname 
    FROM jointables GROUP BY firstname, lastname);

-- 6. Top Supplier
SELECT supplierid, COUNT(id) AS product_count 
FROM product GROUP BY supplierid ORDER BY product_count DESC LIMIT 1;

-- 7. Order Trends by month
SELECT COUNT(id) AS order_count, DATE_FORMAT(orderdate, '%Y-%m') AS month_year 
FROM orders GROUP BY month_year ORDER BY month_year;

-- 8. Supplier Concentration
SELECT country, COUNT(id) AS supplier_count 
FROM supplier GROUP BY country ORDER BY supplier_count DESC LIMIT 1;

-- 9. Inactive Customers (no orders)
SELECT c.id, c.firstname, c.lastname
FROM customer c LEFT JOIN orders o ON c.id = o.customerid
WHERE o.id IS NULL;
