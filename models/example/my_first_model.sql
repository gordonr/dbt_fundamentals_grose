/*
{{
    config(
        materialized = 'view',
        tags=['finance']
    )
}}
*/

select 
    1 as id,
    1 / 4 as my_ratio

/*
union all

select 
    null as id,
    1 / 3 as my_ratio
*/   

