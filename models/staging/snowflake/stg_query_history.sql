{% if flags.FULL_REFRESH %}
{{ log("we are running a full refresh.") }}
{{
    config(
        materialized='incremental',
        unique_key = 'QUERY_ID',
        snowflake_warehouse='ZERO_DBT_TRANSFORMING'
    )
}}
{% else %}
{{ log("we are NOT running a full refresh.") }}
{{
    config(
        materialized='incremental',
        unique_key = 'QUERY_ID',
        snowflake_warehouse='TRANSFORMING'
    )
}}
{% endif %}


select
    *
from
    {{ source('snowflake_meta', 'query_history') }}

{% if is_incremental() %}

    where QUERY_ID > (select max(QUERY_ID) from {{ this }} )

{% endif %}        