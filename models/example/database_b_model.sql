{{ config(
    database="demo_db",
    materialized="table",
    alias="database_a_model"
    ) 
}}


select * from {{ ref("stg_payments") }} limit 1    