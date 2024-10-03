  {% macro log_env() %}
      {{ log('\nGenerating cleanup queries...\n', info=True) }}
      {{ log("DBT_ENV                 : " ~ env_var('DBT_ENV', 'NOT DEFINED') ~ '\n', info=True) }}
      {{ log("DBT_CLOUD_JOB_ID        : " ~ env_var('DBT_CLOUD_JOB_ID', 'NOT DEFINED') ~ '\n', info=True) }}
      {{ log("DBT_CLOUD_ENVIRONMENT_ID: " ~ env_var('DBT_CLOUD_ENVIRONMENT_ID', 'NOT DEFINED') ~ '\n', info=True) }}
      {{ log("DBT_CLOUD_PR_ID         : " ~ env_var('DBT_CLOUD_PR_ID', 'NOT DEFINED') ~ '\n', info=True) }}
      {{ log("DBT_CLOUD_RUN_ID        : " ~ env_var('DBT_CLOUD_RUN_ID', 'NOT DEFINED') ~ '\n', info=True) }}
      {{ log("DBT_CLOUD_RUN_ID        : " ~ env_var('DBT_CLOUD_RUN_ID', 'NOT DEFINED') ~ '\n', info=True) }}
      {{ log("target.name.            : " ~ target.name ~ '\n', info=True) }}      
  {% endmacro %}