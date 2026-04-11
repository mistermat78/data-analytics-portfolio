/*
=========================================================
File: 04_case_when.sql
Objective:
Illustrate how CASE WHEN helps translate business rules 
into SQL queries.
=========================================================
*/

---------------------------------------------------------
-- 1. Classify orders into revenue segments
-- Objective: identify high-, medium-, and low-value
-- orders based on total order revenue.
---------------------------------------------------------
SELECT
    oi.order_id,
    SUM(oi.quantity * oi.unit_price) AS order_revenue,
    CASE
        WHEN SUM(oi.quantity * oi.unit_price) >= 200 THEN 'High Value'
        WHEN SUM(oi.quantity * oi.unit_price) >= 100 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS order_value_segment
FROM order_items oi
GROUP BY oi.order_id
ORDER BY order_revenue DESC;

---------------------------------------------------------
-- 2. Segment customers by generated revenue
-- Objective: classify customers into value-based segments
-- based on the total revenue generated from completed
-- orders (VIP, Active, and Low Value).
---------------------------------------------------------
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue,
    CASE
        WHEN SUM(oi.quantity * oi.unit_price) >= 200 THEN 'VIP'
        WHEN SUM(oi.quantity * oi.unit_price) >= 100 THEN 'Active'
        ELSE 'Low Value'
    END AS customer_segment
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_revenue DESC;

---------------------------------------------------------
-- 3. Classify products by unit margin level
-- Objective: evaluate product profitability by comparing
-- selling price and cost price, then assign each product
-- to a margin-based category.
-- (High Margin, Medium Margin, Low Margin)
---------------------------------------------------------
SELECT
    product_id,
    product_name,
    unit_price,
    cost_price,
    unit_price - cost_price AS unit_margin,
    CASE
        WHEN unit_price - cost_price >= 30 THEN 'High Margin'
        WHEN unit_price - cost_price >= 15 THEN 'Medium Margin'
        ELSE 'Low Margin'
    END AS margin_level
FROM products
ORDER BY unit_margin DESC;

---------------------------------------------------------
-- 4. Group customers by signup period
-- Objective: categorize customers according to their
-- registration date in order to analyze acquisition
-- periods and cohort distribution.
-- (Early Customers, Mid-Year Signups, Recent Signups)
---------------------------------------------------------
SELECT
    customer_id,
    first_name,
    last_name,
    signup_date,
    CASE
        WHEN signup_date < '2024-03-01' THEN 'Early Customers'
        WHEN signup_date < '2024-05-01' THEN 'Mid-Year Signups'
        ELSE 'Recent Signups'
    END AS signup_period
FROM customers
ORDER BY signup_date;

---------------------------------------------------------
-- 5. Translate technical order statuses into business labels
-- Objective: make order status values easier to interpret
-- by converting system-level statuses into more readable
-- business-friendly categories.
--- Validated, In Progress, Not Completed, Unknown
---------------------------------------------------------
SELECT
    order_id,
    customer_id,
    order_date,
    status,
    CASE
        WHEN status = 'completed' THEN 'Validated'
        WHEN status = 'pending' THEN 'In Progress'
        WHEN status = 'cancelled' THEN 'Not Completed'
        ELSE 'Unknown'
    END AS business_status
FROM orders
ORDER BY order_date;

---------------------------------------------------------
-- 6. Classify payments by amount level
-- Objective: identify small, medium, and large payments
-- based on transaction amount to support payment analysis
-- and revenue monitoring.
---------------------------------------------------------
SELECT
    payment_id,
    order_id,
    payment_method,
    amount,
    CASE
        WHEN amount >= 150 THEN 'Large Payment'
        WHEN amount >= 100 THEN 'Medium Payment'
        ELSE 'Small Payment'
    END AS payment_size
FROM payments
ORDER BY amount DESC;

---------------------------------------------------------
-- 7. Segment products by price range
-- Objective: organize products into price-based categories
-- to support pricing analysis and product positioning.
-- (Prenium, Standard, Budget)
---------------------------------------------------------
SELECT
    product_id,
    product_name,
    unit_price,
    CASE
        WHEN unit_price >= 100 THEN 'Premium'
        WHEN unit_price >= 50 THEN 'Standard'
        ELSE 'Budget'
    END AS price_segment
FROM products
ORDER BY unit_price DESC;

---------------------------------------------------------
-- 8. Count orders by revenue segment
-- Objective: measure how many orders fall into each
-- revenue category after applying value-based segmentation
-- rules at the order level.
---------------------------------------------------------
SELECT
    order_value_segment,
    COUNT(*) AS total_orders
FROM (
    SELECT
        oi.order_id,
        CASE
            WHEN SUM(oi.quantity * oi.unit_price) >= 200 THEN 'High Value'
            WHEN SUM(oi.quantity * oi.unit_price) >= 100 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS order_value_segment
    FROM order_items oi
    GROUP BY oi.order_id
) segmented_orders
GROUP BY order_value_segment
ORDER BY total_orders DESC;