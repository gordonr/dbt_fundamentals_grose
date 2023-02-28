select
    id as order_id,
    user_id as customer_id,
    TO_DATE(order_date) as order_date,
    status

--from raw.jaffle_shop.orders
from {{ source('my_jaffle_shop', 'orders') }}