-- =========================================
-- Retail Sales Analytics Portfolio Project
-- Author: Andrew MacDonald
-- =========================================

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    order_id INT,
    order_date DATE,
    customer_id INT,
    customer_name VARCHAR(100),
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    region VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(10,2),
    discount DECIMAL(4,2),
    total_sales DECIMAL(10,2)
);

INSERT INTO sales (
    order_id,
    order_date,
    customer_id,
    customer_name,
    product_id,
    product_name,
    category,
    region,
    quantity,
    unit_price,
    discount,
    total_sales
)
VALUES
(1, '2025-01-05', 101, 'Andrew Smith', 201, 'Wireless Mouse', 'Electronics', 'Northeast', 2, 25.00, 0.10, 45.00),
(2, '2025-01-07', 102, 'Sarah Johnson', 202, 'Office Chair', 'Furniture', 'South', 1, 120.00, 0.15, 102.00),
(3, '2025-01-10', 103, 'Michael Brown', 203, 'Notebook Set', 'Stationery', 'West', 5, 8.00, 0.00, 40.00),
(4, '2025-01-15', 101, 'Andrew Smith', 204, 'Desk Lamp', 'Furniture', 'Northeast', 1, 35.00, 0.05, 33.25),
(5, '2025-02-01', 104, 'Emily Davis', 205, 'Water Bottle', 'Accessories', 'Midwest', 3, 15.00, 0.00, 45.00),
(6, '2025-02-03', 105, 'James Wilson', 206, 'Bluetooth Speaker', 'Electronics', 'South', 1, 75.00, 0.20, 60.00),
(7, '2025-02-08', 106, 'Olivia Miller', 207, 'Backpack', 'Accessories', 'West', 2, 40.00, 0.10, 72.00),
(8, '2025-02-12', 102, 'Sarah Johnson', 208, 'Monitor Stand', 'Furniture', 'South', 1, 50.00, 0.00, 50.00),
(9, '2025-02-18', 107, 'Daniel Moore', 209, 'Pens Pack', 'Stationery', 'Midwest', 4, 5.00, 0.00, 20.00),
(10, '2025-03-01', 108, 'Sophia Taylor', 210, 'Keyboard', 'Electronics', 'Northeast', 1, 45.00, 0.10, 40.50),
(11, '2025-03-05', 109, 'William Anderson', 211, 'Desk Organizer', 'Stationery', 'West', 2, 18.00, 0.05, 34.20),
(12, '2025-03-09', 104, 'Emily Davis', 212, 'Travel Mug', 'Accessories', 'Midwest', 2, 20.00, 0.00, 40.00),
(13, '2025-03-12', 110, 'Ava Thomas', 213, 'Laptop Stand', 'Electronics', 'South', 1, 60.00, 0.15, 51.00),
(14, '2025-03-15', 103, 'Michael Brown', 214, 'Bookshelf', 'Furniture', 'West', 1, 140.00, 0.10, 126.00),
(15, '2025-03-20', 111, 'Benjamin Martin', 215, 'Sticky Notes', 'Stationery', 'Northeast', 6, 3.00, 0.00, 18.00);

SELECT * FROM sales;

SELECT
    category,
    SUM(total_sales) AS revenue
FROM sales
GROUP BY category
ORDER BY revenue DESC;

SELECT
    region,
    SUM(total_sales) AS revenue
FROM sales
GROUP BY region
ORDER BY revenue DESC;

SELECT
    customer_name,
    SUM(total_sales) AS total_spent
FROM sales
GROUP BY customer_name
ORDER BY total_spent DESC;

SELECT
    product_name,
    SUM(total_sales) AS revenue
FROM sales
GROUP BY product_name
ORDER BY revenue DESC;

SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(total_sales) AS monthly_revenue
FROM sales
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

WITH customer_totals AS (
    SELECT
        customer_name,
        SUM(total_sales) AS total_spent
    FROM sales
    GROUP BY customer_name
)
SELECT
    customer_name,
    total_spent
FROM customer_totals
WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM customer_totals
)
ORDER BY total_spent DESC;

SELECT 
    customer_name,
    SUM(total_sales) AS total_spent,
    CASE 
        WHEN SUM(total_sales) >= 300 THEN 'High Value'
        WHEN SUM(total_sales) >= 150 THEN 'Mid Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM sales
GROUP BY customer_name
ORDER BY total_spent DESC;

SELECT 
    product_name,
    SUM(total_sales) AS revenue,
    RANK() OVER (ORDER BY SUM(total_sales) DESC) AS product_rank
FROM sales
GROUP BY product_name;

SELECT 
    customer_name,
    COUNT(order_id) AS total_orders,
    SUM(total_sales) AS total_spent
FROM sales
GROUP BY customer_name
HAVING COUNT(order_id) > 1
ORDER BY total_orders DESC;