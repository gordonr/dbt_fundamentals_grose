SELECT
    id AS order_id,
    user_id AS customer_id,
    TO_DATE(order_date) AS order_date,
    DATEDIFF('day', order_date, {{ dbt.current_timestamp() }} ) AS days_since_ordered,
    status LIKE '%pending%' AS is_status_pending,
    CASE 
        WHEN status LIKE '%return%' THEN 'returned'
        WHEN status LIKE '%pending%' THEN 'placed'
        ELSE status
    END AS status

FROM {{ source('my_jaffle_shop', 'orders') }}