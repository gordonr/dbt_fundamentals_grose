{{
    config(
        secure = 'true',
        schema = 'a_different_schema',
        tags=['finance'],
        post_hook=[
            "grant select on {{ this }} to role transformer"
        ],
        query_tag = 'this model {{model.name}} was created by dbt'
    )
}}

select
    -- new comment comment comment comment

    id as payment_id ,
    orderid as order_id ,
    paymentmethod as payment_method,
    status as status,
    --1 as col_foo,

    -- change --

    -- amount is stored in cents. We need to convert it to dollars 
    amount as payment_amount,  
    -- { { cents_to_dollars('amount') }} as payment_amount,
    -- amount / 100 as payment_amount,
    created as created_at

from {{ source('my_stripe', 'payment') }}
