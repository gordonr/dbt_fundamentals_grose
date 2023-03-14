select
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,
    -- amount is stored in cents, convert it to dollars
    -- amount as payment_amount,
    -- { { cents_to_dollars('amount') }} as payment_amount,
    amount/100 as payment_amount,
    created as created_at 

from {{ source('my_stripe', 'payment') }}