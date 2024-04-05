select
    id as order_id,
    user_id as customer_id,
    TO_DATE(order_date) as order_date,
    datediff('day', order_date, {{ dbt.current_timestamp() }} ) as days_since_ordered,
    status like '%pending%' as is_status_pending,
    case 
        when status like '%return%' then 'returned'
        when status like '%pending%' then 'placed'
        else status
    end as status

--from raw.jaffle_shop.orders
from {{ source('my_jaffle_shop', 'orders') }}