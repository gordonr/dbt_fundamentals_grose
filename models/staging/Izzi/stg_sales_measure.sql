select 
    unique_row_id, 
    client_id,
    order_id,
    Date(order_date, 'YYYY-MM-DD') as order_date,
    sales,
    upsales,
    value
from {{ ref('sales_measure') }}