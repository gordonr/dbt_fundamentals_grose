select
    order_id,
    average(payment_amount) as average_amount
from {{ ref('stg_payments') }}
group by 1
having not(average_amount >= 250)
