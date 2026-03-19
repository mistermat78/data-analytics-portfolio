/*
=========================================================
File: 01_basic_select_filter.sql
Objective:
Demonstrate the fundamentals of SQL querying for analytics:
- SELECT
- WHERE
- ORDER BY
- LIMIT
- filtering by text, numbers, and dates
=========================================================
*/

---------------------------------------------------------
-- 1. View all customers
---------------------------------------------------------
SELECT *
FROM customers;

---------------------------------------------------------
-- 2. Select only useful columns
---------------------------------------------------------
SELECT
    customer_id,
    first_name,
    last_name,
    country
FROM customers;

---------------------------------------------------------
-- 3. Filter customers from France
---------------------------------------------------------
SELECT
    customer_id,
    first_name,
    last_name,
    country
FROM customers
WHERE country = 'France';

---------------------------------------------------------
-- 4. Filter products above a price threshold
---------------------------------------------------------
SELECT
    product_id,
    product_name,
    unit_price
FROM products
WHERE unit_price > 50
ORDER BY unit_price DESC;

---------------------------------------------------------
-- 5. Find completed orders only
---------------------------------------------------------
SELECT
    order_id,
    customer_id,
    order_date,
    status
FROM orders
WHERE status = 'completed'
ORDER BY order_date;

---------------------------------------------------------
-- 6. Orders placed after a given date
---------------------------------------------------------
SELECT
    order_id,
    customer_id,
    order_date,
    status
FROM orders
WHERE order_date >= '2024-07-01'
ORDER BY order_date;

---------------------------------------------------------
-- 7. Top 5 most expensive products
---------------------------------------------------------
SELECT
    product_id,
    product_name,
    unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 5;

---------------------------------------------------------
-- 8. Customers who signed up between two dates
---------------------------------------------------------
SELECT
    customer_id,
    first_name,
    last_name,
    signup_date
FROM customers
WHERE signup_date BETWEEN '2024-03-01' AND '2024-05-31'
ORDER BY signup_date;

---------------------------------------------------------
-- 9. Products from the "Books" or "Sports" universe
-- (here using category_id directly for a basic example)
---------------------------------------------------------
SELECT
    product_id,
    product_name,
    category_id,
    unit_price
FROM products
WHERE category_id IN (3, 4)
ORDER BY category_id, product_name;

---------------------------------------------------------
-- 10. Cancelled or pending orders
---------------------------------------------------------
SELECT
    order_id,
    customer_id,
    order_date,
    status
FROM orders
WHERE status IN ('cancelled', 'pending')
ORDER BY order_date;