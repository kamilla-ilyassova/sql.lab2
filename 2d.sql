WITH top_customer AS (
    SELECT 
        o.customer_id
    FROM orders o
    GROUP BY o.customer_id
    ORDER BY COUNT(o.order_id) DESC
    LIMIT 1
)
SELECT 
    c.customer_name,
    SUM(o.total_amount) AS total_revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.customer_id = (SELECT customer_id FROM top_customer)
GROUP BY c.customer_name;