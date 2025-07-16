-- tests/no_nulls_except_growthrate_if_2015.sql
{% test no_nulls_except_growthrate_if_2015(model) %}
SELECT *
FROM {{ model }}
WHERE (
    CompanyID IS NULL OR
    CompanyName IS NULL OR
    Industry IS NULL OR
    Region IS NULL OR
    Year IS NULL OR
    Revenue IS NULL OR
    ProfitMargin IS NULL OR
    MarketCap IS NULL OR
    ESG_Overall IS NULL OR
    ESG_Environmental IS NULL OR
    ESG_Social IS NULL OR
    ESG_Governance IS NULL OR
    CarbonEmissions IS NULL OR
    WaterUsage IS NULL OR
    EnergyConsumption IS NULL OR
    (GrowthRate IS NULL AND Year != 2015)
)
{% endtest %}
