-- Use a correlated subquery to find customers whose total order value is
-- above the average total across all customers.
SELECT customer_name,
       SUM(price * quantity) AS total_amount
FROM orders JOIN customers ON orders.customer_id = customers.customer_id
    JOIN products ON orders.product_id = products.product_id
GROUP BY customer_name
HAVING SUM(price * quantity) > (
    SELECT AVG(price * quantity) AS average_total
    FROM orders JOIN customers ON orders.customer_id = customers.customer_id
    JOIN products ON orders.product_id = products.product_id
    )
ORDER BY total_amount DESC

-- Create a view called high_value_orders listing orders where the order total exceeds the 90th percentile of all order totals.
CREATE VIEW high_value_orders AS (
    WITH all_order_totals AS (
        SELECT price * quantity AS order_price
        FROM orders JOIN products ON orders.product_id = products.product_id),
    ninetieth_perc AS (
    SELECT PERCENTILE_DISC(0.9) WITHIN GROUP (ORDER BY order_price) FROM all_order_totals AS ninetieth_perc)

SELECT order_id
FROM orders JOIN products ON orders.product_id = products.product_id
WHERE (
    price * quantity > (SELECT * FROM ninetieth_perc)
           ));
SELECT * FROM high_value_orders




