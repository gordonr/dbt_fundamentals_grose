select * from {{ ref('fct_orders', v='2') }}

-- experiment with latest_version value, alias, file naming
select * from {{ ref('fct_orders') }}

select * from {{ ref('fct_orders', v='1') }}