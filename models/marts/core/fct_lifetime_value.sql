with orders as (

    select * from {{ ref('stg_orders') }}

),

payments as (

    select * from {{ ref('stg_payments') }}

)

select 
    o.customer_id, sum(p.payment_amount) as lifetime_value
from   
    orders o inner join 
        payments p on o.order_id = p.order_id
group by o.customer_id