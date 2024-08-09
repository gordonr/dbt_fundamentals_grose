with 

source as (

    select * from {{ source('my_jaffle_shop', 'customers') }}

),

renamed as (

    select
        id,
        first_name as f_name,
        last_name

    from source

)

select * from renamed
