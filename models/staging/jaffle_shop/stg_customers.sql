select
    id as customer_id,
    first_name,
    last_name

--from raw.jaffle_shop.customers
from {{ source('my_jaffle_shop', 'customers') }}

 -- dbt run-operation generate_base_model --args '{"source_name": "my_jaffle_shop", "table_name": "customers"}'