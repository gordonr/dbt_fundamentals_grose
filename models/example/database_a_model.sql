{{ config(
    materialized="table"
    ) 
}}
select * from {{ ref("stg_payments") }} limit 1    