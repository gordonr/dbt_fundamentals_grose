{{ config(
    materialized="dynamic_table",
    on_configuration_change= "fail",
    target_lag= "12 hours",
    snowflake_warehouse="TRANSFORMING"
    ) 
}}

select * from {{ ref("stg_payments") }}   