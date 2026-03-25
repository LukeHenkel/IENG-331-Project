-- This is a data quality audit that profiles row counts per table, NULL rates for key columns, orphaned foreigh keys, data range coverage and gaps, and duplicate counts
WITH row_counts AS(
    SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'order_payments', COUNT(*) FROM order_payments
UNION ALL
SELECT 'order_reviews', COUNT(*) FROM order_reviews
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL
SELECT 'geolocation', COUNT(*) FROM geolocation
UNION ALL
SELECT 'category_translation', COUNT(*) FROM category_translation
)
SELECT * FROM row_counts ORDER BY table_name;

WITH null_rates AS (
    SELECT
        'customers.customer_id' AS column_name,
        COUNT(*) AS total_rows,
        SUM(CASE WHEN customers.customer_id IS NULL THEN 1 ELSE 0 END) AS null_count,
        ROUND(100.0 * SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS null_pct
    FROM customers
)
SELECT * FROM null_rates;
