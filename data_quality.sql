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

WITH orphaned_keys AS (
    SELECT
        'orders.customer_id -> customers.customer_id' AS relationship,
        COUNT(*) AS orphan_count
    FROM orders o
    LEFT JOIN customers c
        ON o.customer_id = c.customer_id
    WHERE o.customer_id IS NOT NULL
      AND c.customer_id IS NULL
)
SELECT * FROM orphaned_keys;

WITH date_ranges AS (
    SELECT
        'orders.order_purchase_timestamp' AS date_field,
        MIN(order_purchase_timestamp) AS min_date,
        MAX(order_purchase_timestamp) AS max_date
    FROM orders

    UNION ALL

    SELECT
        'orders.order_approved_at',
        MIN(order_approved_at),
        MAX(order_approved_at)
    FROM orders
)
SELECT * FROM date_ranges;

WITH monthly_orders AS (
    SELECT
        DATE_TRUNC('month', order_purchase_timestamp) AS order_month,
        COUNT(*) AS order_count
    FROM orders
    WHERE order_purchase_timestamp IS NOT NULL
    GROUP BY 1
),
monthly_gaps AS (
    SELECT
        order_month,
        order_count,
        LAG(order_month) OVER (ORDER BY order_month) AS previous_month,
        DATE_DIFF('month',
            LAG(order_month) OVER (ORDER BY order_month),
            order_month
        ) AS month_gap
    FROM monthly_orders
)
SELECT *
FROM monthly_gaps
WHERE month_gap IS NOT NULL
  AND month_gap > 1
ORDER BY order_month;
