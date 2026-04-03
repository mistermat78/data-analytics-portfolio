/*
=========================================================
File: 03_group_by_aggregations.sql
Objective:
Demonstrate the use of SQL aggregations for analytics:
- COUNT
- SUM
- AVG
- MIN
- MAX
- GROUP BY
- HAVING
=========================================================
*/

---------------------------------------------------------
-- 1. Number of customers by country
---------------------------------------------------------
SELECT
    country,
    COUNT(*) AS total_customers
FROM customers
GROUP BY country
ORDER BY total_customers DESC, country;

---------------------------------------------------------
-- 2. Number of orders by status
---------------------------------------------------------
SELECT
    status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY status
ORDER BY total_orders DESC;

---------------------------------------------------------
-- 3. Revenue by order
-- Revenue is calculated from order line items
---------------------------------------------------------
SELECT
    oi.order_id,
    SUM(oi.quantity * oi.unit_price) AS order_revenue
FROM order_items oi
GROUP BY oi.order_id
ORDER BY order_revenue DESC;

---------------------------------------------------------
-- 4. Total revenue by customer
---------------------------------------------------------
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_revenue DESC;

---------------------------------------------------------
-- 5. Number of orders by customer
---------------------------------------------------------
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_orders DESC, c.customer_id;

---------------------------------------------------------
-- 6. Revenue by product category
---------------------------------------------------------
SELECT
    cat.category_name,
    SUM(oi.quantity * oi.unit_price) AS category_revenue
FROM categories cat
JOIN products p
    ON cat.category_id = p.category_id
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY cat.category_name
ORDER BY category_revenue DESC;

---------------------------------------------------------
-- 7. Average, minimum, and maximum product price
-- by category
---------------------------------------------------------
SELECT
    cat.category_name,
    ROUND(AVG(p.unit_price), 2) AS avg_unit_price,
    MIN(p.unit_price) AS min_unit_price,
    MAX(p.unit_price) AS max_unit_price
FROM categories cat
JOIN products p
    ON cat.category_id = p.category_id
GROUP BY cat.category_name
ORDER BY avg_unit_price DESC;

---------------------------------------------------------
-- 8. Total quantity sold by product
---------------------------------------------------------
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC, p.product_name;

---------------------------------------------------------
-- 9. Customers with more than one order
-- Example using HAVING
---------------------------------------------------------
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC, c.customer_id;

---------------------------------------------------------
-- 10. Monthly revenue
---------------------------------------------------------
SELECT
    DATE_TRUNC('month', o.order_date)::date AS order_month,
    SUM(oi.quantity * oi.unit_price) AS monthly_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY order_month;