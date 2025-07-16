-- tests/environmental_metrics_positive.sql
{% test environmental_metrics_positive(model) %}
SELECT *
FROM {{ model }}
WHERE 
    CarbonEmissions <= 0 OR
    WaterUsage <= 0 OR
    EnergyConsumption <= 0
{% endtest %}
