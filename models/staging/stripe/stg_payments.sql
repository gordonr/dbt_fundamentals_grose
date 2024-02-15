{{
    config(
        secure = 'true',
        tags=['finance'],
        post_hook=[
            "grant select on {{ this }} to role transformer"
        ]
    )
}}
select

    id as payment_id ,
    orderid as order_id,
    paymentmethod as payment_method,
    status as status,

    -- change -

    -- amount   is stored in cents. We need to convert it to dollars 
    amount as payment_amount,  

    -- { { cents_to_dollars('amount') }} as payment_amount,
    -- amount/100 as payment_amount,
    created as created_at

from {{ source('my_stripe', 'payment') }}
