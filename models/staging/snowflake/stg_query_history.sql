{{
    config(
        materialized='incremental',
        unique_key = 'QUERY_ID'
    )
}}

select
    *
from
    {{ source('snowflake_meta', 'query_history') }}

{% if is_incremental() %}

    where QUERY_ID > (select max(QUERY_ID) from {{ this }} )

{% endif %}        