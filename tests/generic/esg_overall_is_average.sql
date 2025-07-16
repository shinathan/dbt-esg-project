-- tests/esg_overall_is_average.sql
{% test esg_overall_is_average(model) %}
SELECT *
FROM {{ model }}
WHERE 
    ABS(ESG_Overall - ((ESG_Environmental + ESG_Social + ESG_Governance) / 3.0)) > 0.1
{% endtest %}
