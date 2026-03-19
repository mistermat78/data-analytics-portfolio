/*
=========================================================
File: 02_joins.sql
Objective:
Demonstrate how to combine tables using joins:
- INNER JOIN
- LEFT JOIN
- multi-table joins
This is essential for relational data analysis.
=========================================================
*/

---------------------------------------------------------
-- 1. Orders with customer details
---------------------------------------------------------
SELECT
    o.order_id,
    o.order_date,
    o.status,
    c.customer_id,
    c.first_name,
    c.last_name,
    c.country
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
ORDER BY o.order_date;

---------------------------------------------------------
-- 2. Order items with product names
---------------------------------------------------------
SELECT
    oi.order_item_id,
    oi.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS line_revenue
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id
ORDER BY oi.order_id, oi.order_item_id;

---------------------------------------------------------
-- 3. Products with their category names
---------------------------------------------------------
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.unit_price,
    p.cost_price
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id
ORDER BY c.category_name, p.product_name;

---------------------------------------------------------
-- 4. Orders + customers + payments
---------------------------------------------------------
SELECT
    o.order_id,
    o.order_date,
    o.status,
    c.first_name,
    c.last_name,
    p.payment_method,
    p.amount
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN payments p
    ON o.order_id = p.order_id
ORDER BY o.order_date;

---------------------------------------------------------
-- 5. Detailed order lines:
-- order + customer + product + category
---------------------------------------------------------
SELECT
    o.order_id,
    o.order_date,
    c.first_name || ' ' || c.last_name AS customer_name,
    pr.product_name,
    cat.category_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS revenue
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products pr
    ON oi.product_id = pr.product_id
INNER JOIN categories cat
    ON pr.category_id = cat.category_id
ORDER BY o.order_id, pr.product_name;

---------------------------------------------------------
-- 6. LEFT JOIN example:
-- show all customers, even those without orders
---------------------------------------------------------
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_date,
    o.status
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_date;

---------------------------------------------------------
-- 7. Revenue by order line with product margin
---------------------------------------------------------
SELECT
    oi.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    p.cost_price,
    (oi.quantity * oi.unit_price) AS revenue,
    (oi.quantity * (oi.unit_price - p.cost_price)) AS gross_margin
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id
ORDER BY oi.order_id;

---------------------------------------------------------
-- 8. Completed orders only with customer and payment info
---------------------------------------------------------
SELECT
    o.order_id,
    o.order_date,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.country,
    p.payment_method,
    p.amount
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN payments p
    ON o.order_id = p.order_id
WHERE o.status = 'completed'
ORDER BY o.order_date;