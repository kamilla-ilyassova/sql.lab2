WITH product_sales AS (
    SELECT 
        p.product_id,
        p.product_name,
        cat.category_name AS category,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM products p
    JOIN categories cat ON p.category_id = cat.category_id
    JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.product_name, cat.category_name
)
SELECT * FROM product_sales;