-- tests/growthrate_above_minus_100.sql
{% test growthrate_above_minus_100(model) %}
SELECT *
FROM {{ model }}
WHERE GrowthRate <= -100
{% endtest %}
