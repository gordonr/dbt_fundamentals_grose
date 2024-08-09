{{ config(
    materialized="dynamic_table",
    on_configuration_change= "apply",
    target_lag= "12 hours",
    snowflake_warehouse="TRANSFORMING"
    ) 
}}

select * from {{ ref("stg_customers") }}   