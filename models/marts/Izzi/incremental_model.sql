{{
    config(
        materialized='incremental',
        unique_key = 'unique_row_id',
        full_refresh = false,
        incremental_strategy='delete+insert'
    )
}}

-- depends_on: {{ ref('unioned_sources') }}
-- depends_on: {{ ref('stg_source_data') }}

-- can run using 

-- dbt run --vars '{izzi_model_selector : all}' --select 1+incremental_model 
-- dbt run --vars '{izzi_model_selector : sales}' --select 1+incremental_model

-- for testing update
-- delete from analytics.dbt_grose.sales_measure
-- insert into analytics.dbt_grose.sales_measure (Unique_Row_ID,Client_Id,Order_Id,Order_Date,Sales,Upsales,Value)
--    values ('1010_2345_S',1010,2345,'2022-11-05',1,0,55)

-- to reset incremental build entirely
-- drop table analytics.dbt_grose.incremental_model

select 
    unique_row_id, 
    client_id,
    order_id,
    Date(order_date, 'YYYY-MM-DD') as order_date,
    sales,
    upsales,
    value
from

{% if is_incremental() -%}
    {{ ref('unioned_sources') }}
{%- else  -%}
    {{ ref('stg_source_data') }}
{%- endif -%}