{% macro null_count_expr(column) %}
    COUNT(
      CASE
        WHEN {{ column }} IS NULL
        THEN 1 END
    ) AS {{ column }}_null_count
{% endmacro %}