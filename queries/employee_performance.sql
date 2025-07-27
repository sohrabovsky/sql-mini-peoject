-- Calculate the total sales handled by each employee.
SELECT employee_name,
       COUNT(order_id) * SUM(quantity) AS total_sales
FROM employees JOIN orders ON employees.employee_id = orders.employee_id
GROUP BY employee_name

-- Use RANK() to rank employees by their total sales.
WITH sales_by_employee AS
    (SELECT employee_name,
       COUNT(order_id) * SUM(quantity) AS total_sales
    FROM employees JOIN orders ON employees.employee_id = orders.employee_id
    GROUP BY employee_name)
SELECT employee_name,
       RANK() OVER(ORDER BY total_sales DESC) AS rank
FROM sales_by_employee;

-- Find the employee with the highest average order value.
WITH employee_orders AS
    (SELECT order_id,
       employee_id,
       quantity * price AS order_price
FROM orders JOIN products ON orders.product_id = products.product_id)
SELECT employee_id,
       AVG(order_price) AS AOV
FROM employee_orders
GROUP BY employee_id
ORDER BY AOV DESC
LIMIT 1;


