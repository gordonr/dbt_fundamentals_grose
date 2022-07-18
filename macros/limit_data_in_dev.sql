{% macro limit_data_in_dev(numer_of_rows_to_return = 500) %}

    {% if target.name == 'dev' %}

        limit {{ numer_of_rows_to_return }}

    {% endif %}

{% endmacro %}