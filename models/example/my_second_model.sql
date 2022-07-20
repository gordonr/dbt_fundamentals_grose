{{
    config(
        materialized = 'table',
        tags=['finance']
    )
}}

-- Use the `ref` function to select from other models

select 
    id,
    sale_amount,
    my_ratio / 100,
    current_timestamp as _loaded_at
from 
    {{ ref('my_first_model') }} 
