{{
    config(
        materialized = 'raw_sql',
        alias = 'foo'
    )
}}

-- even this is a comment, it will be processed. This allows us to insert dependencies.
-- {{ source('my_stripe', 'payment') }}

SHOW PARAMETERS LIKE 'TIMEZONE';


