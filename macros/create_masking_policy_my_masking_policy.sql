{% macro create_masking_policy_my_masking_policy(node_database, node_schema) %}

CREATE MASKING POLICY IF NOT EXISTS {{ node_database }}.{{ node_schema }}.my_masking_policy AS (data_val STRING)
RETURNS STRING ->
    CASE 
        WHEN CURRENT_ROLE() IN ('SYSADMIN') THEN data_val
        ELSE '***********'
    END

{% endmacro %}