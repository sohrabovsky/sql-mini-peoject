-- List the top 3 products with the highest total sales value.
SELECT product_name,
       COUNT(order_id) * SUM(quantity) AS total_sales
FROM orders JOIN products ON orders.product_id = products.product_id
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 3;

-- Write a query to show monthly sales totals (by product) using a window function.
SELECT EXTRACT(MONTH FROM order_date) AS month,
       product_name,
       COUNT(order_id) * SUM(quantity) AS sales_total
FROM orders JOIN products ON orders.product_id = products.product_id
GROUP BY product_name, month
ORDER BY month ASC;

-- Identify any product that has not been ordered at all.
SELECT product_name
FROM products
WHERE product_id NOT IN (SELECT product_id FROM orders);





