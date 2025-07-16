-- tests/esg_between_0_100.sql
{% test esg_between_0_100(model) %}
SELECT *
FROM {{ model }}
WHERE 
    ESG_Overall NOT BETWEEN 0 AND 100 OR
    ESG_Environmental NOT BETWEEN 0 AND 100 OR
    ESG_Social NOT BETWEEN 0 AND 100 OR
    ESG_Governance NOT BETWEEN 0 AND 100
{% endtest %}
