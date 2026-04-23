-- ============================================================
-- LEVEL 4: EXPERT QUERIES
-- Focus: COMPLEX CALCULATIONS, BUSINESS LOGIC
-- ============================================================
USE supply_chain;

-- 1. Savings Analysis: rank orders by discount savings
WITH savings_cte AS (
    SELECT o.id AS order_id, o.ordernumber,
        SUM((p.unitprice - oi.unitprice) * oi.quantity) AS total_savings
    FROM orders o JOIN orderitem oi ON o.id = oi.orderid
    JOIN product p ON oi.productid = p.id
    GROUP BY o.id, o.ordernumber
)
SELECT order_id, ordernumber, ROUND(total_savings, 2) AS total_savings,
    RANK() OVER (ORDER BY total_savings DESC) AS savings_rank
FROM savings_cte ORDER BY savings_rank;

-- 2a. Market Research: High-demand products for Mr. Kavin
WITH product_demand AS (
    SELECT p.id, p.productname, SUM(oi.quantity) AS total_ordered
    FROM product p JOIN orderitem oi ON p.id = oi.productid
    GROUP BY p.id, p.productname
)
SELECT productname, total_ordered,
    RANK() OVER (ORDER BY total_ordered DESC) AS demand_rank
FROM product_demand ORDER BY demand_rank LIMIT 20;

-- 2b. Market Research: Competitor suppliers for those products
WITH top_products AS (
    SELECT p.id, p.productname, SUM(oi.quantity) AS total_ordered
    FROM product p JOIN orderitem oi ON p.id = oi.productid
    GROUP BY p.id ORDER BY total_ordered DESC LIMIT 20
)
SELECT tp.productname, tp.total_ordered, s.companyname AS competitor_supplier, s.country
FROM top_products tp JOIN product p ON tp.id = p.id
JOIN supplier s ON p.supplierid = s.id ORDER BY tp.total_ordered DESC;
