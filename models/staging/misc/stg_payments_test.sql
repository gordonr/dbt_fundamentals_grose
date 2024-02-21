select 

{% if target.name == 'alt_account' %}

    ID as payment_id ,
    orderID as order_id,
    paymentMethod as payment_method,
    null as status,
    AMOUNT as payment_amount,  
    CREATED as created_at

{% else %}

    id as payment_id ,
    orderid as order_id,
    paymentmethod as payment_method,
    status as status,
    amount as payment_amount,  
    created as created_at

{% endif %}

from {{ source('my_stripe', 'payment') }}