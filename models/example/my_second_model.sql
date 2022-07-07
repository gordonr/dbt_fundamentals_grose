
-- Use the `ref` function to select from other models

select 
    *,
    current_timestamp as _loaded_at
from 
    {{ ref('my_first_model') }} 
where
    id = 1
