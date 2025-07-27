-- Find the top 5 customers by total purchase amount.
SELECT customer_id,
       COUNT(order_id) * SUM(quantity) AS total_purchase
FROM orders
GROUP BY customer_id
ORDER BY total_purchase DESC
LIMIT 5;

-- Identify customers who haven’t made any orders.
SELECT customer_id
FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM orders)

-- Write a view called customer_order_summary with customer name, total order count, and total amount spent.
CREATE VIEW customer_order_summary AS (
SELECT customer_name,
       COUNT(order_id) AS total_order_count,
       SUM(price) AS total_price,
       SUM(quantity) AS total_amount,
       total_price * total_amount AS total_amount_spent
FROM orders JOIN customers ON orders.customer_id = customers.customer_id
    JOIN products ON orders.product_id = products.product_id
GROUP BY customer_name)
SELECT * FROM customer_order_summary
