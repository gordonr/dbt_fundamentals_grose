-- example of showing which columns are retrieved
{%- set columns = adapter.get_columns_in_relation(this) -%}

{% for column in columns %}
  {{ log("Column: " ~ column, info=true) }}
{% endfor %}


select 
    1 as id,
    2 as sale_amount,
    3 / 4 as my_ratio

union all

select 
    2 as id,
    5 as sale_amount,
    1 / 3 as my_ratio
   

