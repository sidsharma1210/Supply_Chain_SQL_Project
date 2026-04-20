# 🏭 Supply Chain Database Analysis — SQL Project

> A complete MySQL project exploring customer behaviour, supplier performance and order trends across a multi-table relational database.

---

## 📋 Table of Contents
- [Project Overview](#project-overview)
- [Database Schema](#database-schema)
- [Setup Instructions](#setup-instructions)
- [Query Levels](#query-levels)
- [Key Findings](#key-findings)
- [Technologies Used](#technologies-used)

---

## 🎯 Project Overview

This project analyses a **Supply Chain database** with 5 interconnected tables:
- **830 Orders** placed between July 2012 and May 2014
- **91 Customers** across 21 countries
- **78 Products** from 29 suppliers
- **2,155 Order line items** with price and quantity

The queries are divided into **4 difficulty levels** — from basic SELECT queries to advanced CTEs and business logic.

---

## 🗄️ Database Schema

```
customer (id, firstname, lastname, city, country, phone)
    │
    └──► orders (id, ordernumber, orderdate, totalamount, customerid FK)
              │
              └──► orderitem (id, orderid FK, productid FK, unitprice, quantity)
                        │
                        └──► product (id, productname, unitprice, package, isdiscontinued, supplierid FK)
                                  │
                                  └──► supplier (id, companyname, contactname, city, country, phone, fax)
```

### Relationships
| Table | Foreign Key | References |
|-------|------------|------------|
| orders | customerid | customer.id |
| orderitem | orderid | orders.id |
| orderitem | productid | product.id |
| product | supplierid | supplier.id |

---

## ⚙️ Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/supply-chain-sql.git
   cd supply-chain-sql
   ```

2. **Open MySQL Workbench** (or any MySQL client)

3. **Run files in order:**
   ```sql
   -- Step 1: Create the schema
   source sql/01_schema.sql;

   -- Step 2: Insert all data
   source sql/02_data_insert.sql;

   -- Step 3 onwards: Run queries by level
   source sql/03_level1_basic.sql;
   ```

4. **Open the ER diagram** in MySQL Workbench:
   - `File > Open Model > diagrams/ER_diagram.mwb`

---

## 📂 File Structure

```
supply-chain-sql/
│
├── README.md                       ← You are here
│
├── sql/
│   ├── 01_schema.sql               ← CREATE TABLE statements
│   ├── 02_data_insert.sql          ← All INSERT data
│   ├── 03_level1_basic.sql         ← Basic SELECT queries
│   ├── 04_level2_intermediate.sql  ← JOINs, Aggregations, Window Functions
│   ├── 05_level3_advanced.sql      ← CTEs, Complex Subqueries
│   └── 06_level4_expert.sql        ← Business Logic, Market Research
│
├── diagrams/
│   └── ER_diagram.mwb              ← MySQL Workbench ER diagram
│
└── presentation/
    └── supply_chain.pptx           ← Full slide deck
```

---

## 📊 Query Levels

### 🟢 Level 1 — Basic Queries
> `SELECT · FROM · WHERE · ORDER BY · GROUP BY`

| Query | Description |
|-------|-------------|
| Customer Demographics | Count of customers per country |
| Active Inventory | Products where `isdiscontinued = 0` |
| Supplier Catalog | Company name + products they supply |
| Regional Search | All customers from Mexico |
| High-Value Items | Most expensive item ordered per customer |
| Top Supplier | Supplier with the highest number of products |
| Order Trends | Count of orders grouped by month and year |
| Supplier Concentration | Country with the most suppliers |
| Inactive Customers | Customers who never placed an order |

---

### 🟡 Level 2 — Intermediate Queries
> `JOINs · Aggregations · LIMIT · Window Functions`

| Query | Description |
|-------|-------------|
| Product Demand | Rank products by total quantity ordered using `RANK()` |
| Annual Performance | Total orders per year |
| Revenue Analysis | Total revenue per year |
| Top Spender | Customer with the highest total spend |
| Customer Ranking | All customers ordered by total spend |
| Order History | Current vs previous order dates using `LAG()` |
| Supplier Revenue | Top 3 suppliers by revenue from their products |
| Customer Loyalty | Latest order per customer (excluding first order) |
| Order Details | Order ID + Product Name + Supplier Name for every order |

---

### 🔴 Level 3 — Advanced Queries
> `WITH (CTE) · Complex JOINs · Subqueries`

| Query | Description |
|-------|-------------|
| Bulk Buyers | Customers who ordered > 10 products in a single order |
| Small Orders | Products ordered with quantity = 1 |
| Premium Suppliers | Suppliers with products priced above $100 |
| City-Based Networking | Customers who share the same city and country |

---

### ⚫ Level 4 — Expert Queries
> `Complex Calculations · Business Logic`

| Query | Description |
|-------|-------------|
| Savings Analysis | Total savings per order (listed price vs selling price), ranked |
| Market Research A | High-demand products for a new supplier (Mr. Kavin) |
| Market Research B | Competitor suppliers for those high-demand products |

---

## 💡 Key Findings

| Finding | Detail |
|---------|--------|
| 🌍 Top Customer Countries | USA (13), Germany (11), Brazil (9) |
| 📦 Most Products Supplied | Supplier #12 — Plutzer Lebensmittelgroßmärkte (7 products) |
| 💰 Most Expensive Product | Côte de Blaye — $263.50 per bottle |
| 👑 Top Spending Customer | Customer #63 — Francisco Chang, México D.F. |
| 📈 Peak Order Month | December 2013 — highest order volume |
| 🔗 Reusable View | `jointables` VIEW joins all 5 tables for simplified querying |

---

## 🛠️ Technologies Used

| Tool | Purpose |
|------|---------|
| MySQL 8.x | Database engine |
| MySQL Workbench | Schema design, ER diagrams, query execution |
| GitHub | Version control and project hosting |

---

## 📎 View Created

```sql
CREATE VIEW jointables AS
SELECT 
    c.id AS customer_id,
    c.firstname, c.lastname,
    o.ordernumber, o.orderdate,
    p.productname,
    oi.quantity, oi.unitprice,
    s.companyname
FROM customer c
JOIN orders o ON c.id = o.customerid
JOIN orderitem oi ON o.id = oi.orderid
JOIN product p ON oi.productid = p.id
JOIN supplier s ON p.supplierid = s.id;
```

> **Tip:** Once you create this view, you can run most queries directly against `jointables` without writing complex JOINs every time.

---

*Project built as part of a SQL learning journey — exploring real-world data with structured query techniques.*
