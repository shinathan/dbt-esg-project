{% macro esg_out_of_range_expr(column_name) %}
    countif({{ column_name }} < 0 or {{ column_name }} > 100) as {{ column_name }}_out_of_range
{% endmacro %}
