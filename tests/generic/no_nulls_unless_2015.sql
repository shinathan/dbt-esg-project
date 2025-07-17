{% test no_nulls_unless_2015(model, column_name) %}

SELECT *
FROM {{ model }}
WHERE {{ column_name }} IS NULL
  AND Year != 2015

{% endtest %}
