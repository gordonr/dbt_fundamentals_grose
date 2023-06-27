-- materialize as a table and tag as being finance-related
-- grant select to reporter role after model is built
{{
    config(
        materialized = 'table',
        tags=['finance'],
        post_hook=[
            "grant select on {{ this }} to role transformer"
        ]
    )
}}

with orders as (

    select * from {{ ref('stg_orders') }}

),

payments as (

    select * from {{ ref('stg_payments') }}

)

select 
    o.customer_id, sum(p.payment_amount) as lifetime_value, x
from   
    orders o inner join 
        payments p on o.order_id = p.order_id
group by o.customer_id

