-- this would not override setting in dbt_project.yml
-- { % set izzi_model_selector = 'sales' %}

-- can run using
-- dbt run --vars '{izzi_model_selector : all}' --select izzi_unioned_sources
-- dbt run --vars '{izzi_model_selector : sales}' --select izzi_unioned_sources

select 
    unique_row_id, 
    client_id,
    order_id,
    Date(order_date, 'YYYY-MM-DD') as order_date,
    sales,
    upsales,
    value
from {{ ref('stg_sales_measure') }}
where '{{ var("izzi_model_selector") }}' = 'all' or '{{ var("izzi_model_selector") }}' = 'sales' 

union all

select 
    unique_row_id, 
    client_id,
    order_id,
    Date(order_date, 'YYYY-MM-DD') as order_date,
    sales,
    upsales,
    value
from {{ ref('stg_upsales_measure') }}
where '{{ var("izzi_model_selector") }}' = 'all' or '{{ var("izzi_model_selector") }}' = 'upsales' 
