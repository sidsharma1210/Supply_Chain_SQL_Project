-- ============================================================
-- LEVEL 3: ADVANCED QUERIES
-- Focus: WITH (CTE), COMPLEX JOINS, SUBQUERIES
-- ============================================================
USE supply_chain;

-- 1. Bulk Buyers (> 10 products in one order)
SELECT c.firstname, c.lastname, o.ordernumber, COUNT(oi.productid) AS product_count
FROM customer c JOIN orders o ON c.id = o.customerid
JOIN orderitem oi ON o.id = oi.orderid
GROUP BY c.id, o.id HAVING COUNT(oi.productid) > 10 ORDER BY product_count DESC;

-- 2. Small Orders (quantity = 1)
SELECT p.productname, p.unitprice, oi.quantity
FROM product p JOIN orderitem oi ON p.id = oi.productid
WHERE oi.quantity = 1 ORDER BY p.productname;

-- 3. Premium Suppliers (price > 100)
SELECT DISTINCT s.companyname, p.productname, p.unitprice
FROM supplier s JOIN product p ON s.id = p.supplierid
WHERE p.unitprice > 100 ORDER BY p.unitprice DESC;

-- 4. City-Based Networking
SELECT c1.firstname AS customer1, c2.firstname AS customer2, c1.city, c1.country
FROM customer c1 JOIN customer c2
    ON c1.city = c2.city AND c1.country = c2.country AND c1.id < c2.id
ORDER BY c1.country, c1.city;
