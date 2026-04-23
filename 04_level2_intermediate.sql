-- ============================================================
-- LEVEL 2: INTERMEDIATE QUERIES
-- Focus: JOINS, AGGREGATIONS, LIMIT, WINDOW FUNCTIONS
-- ============================================================
USE supply_chain;

-- 1. Product Demand Rank
SELECT p.productname, SUM(oi.quantity) AS total_qty,
    RANK() OVER (ORDER BY SUM(oi.quantity) DESC) AS demand_rank
FROM product p JOIN orderitem oi ON p.id = oi.productid
GROUP BY p.id, p.productname ORDER BY demand_rank;

-- 2. Annual Performance
SELECT YEAR(orderdate) AS year, COUNT(id) AS total_orders
FROM orders GROUP BY year ORDER BY year;

-- 3. Revenue Analysis
SELECT YEAR(orderdate) AS year, SUM(totalamount) AS total_revenue
FROM orders GROUP BY year ORDER BY year;

-- 4. Top Spender
SELECT c.firstname, c.lastname, c.country, SUM(o.totalamount) AS total_spent
FROM customer c JOIN orders o ON c.id = o.customerid
GROUP BY c.id ORDER BY total_spent DESC LIMIT 1;

-- 5. Customer Ranking
SELECT c.firstname, c.lastname, c.country, SUM(o.totalamount) AS total_spent
FROM customer c JOIN orders o ON c.id = o.customerid
GROUP BY c.id ORDER BY total_spent DESC;

-- 6. Order History using LAG()
SELECT c.firstname, c.lastname, o.orderdate,
    LAG(o.orderdate) OVER (PARTITION BY c.id ORDER BY o.orderdate) AS prev_order
FROM customer c JOIN orders o ON c.id = o.customerid;

-- 7. Top 3 Supplier Revenue
SELECT s.companyname, SUM(oi.unitprice * oi.quantity) AS revenue
FROM supplier s JOIN product p ON s.id = p.supplierid
JOIN orderitem oi ON p.id = oi.productid
GROUP BY s.id ORDER BY revenue DESC LIMIT 3;

-- 8. Customer Loyalty (latest order, excluding first-timers)
SELECT c.firstname, c.lastname, MAX(o.orderdate) AS latest_order
FROM customer c JOIN orders o ON c.id = o.customerid
GROUP BY c.id HAVING COUNT(o.id) > 1 ORDER BY latest_order DESC;

-- 9. Order Details
SELECT o.id AS order_id, p.productname, s.companyname AS supplier
FROM orders o JOIN orderitem oi ON o.id = oi.orderid
JOIN product p ON oi.productid = p.id
JOIN supplier s ON p.supplierid = s.id ORDER BY o.id;
