-- CompanyID
-- CompanyName
-- Industry
-- Region
-- Year
-- Revenue
-- ProfitMargin
-- MarketCap
-- GrowthRate
-- ESG_Overall
-- ESG_Environmental
-- ESG_Social
-- ESG_Governance
-- CarbonEmissions
-- WaterUsage
-- EnergyConsumption

with 
source as (
    select * from {{ source("raw", "company_esg_financial_dataset") }}
),

renamed as (
    select
    CONCAT(CompanyName, '_', Year) as company_year,
    CompanyID as company_id,
    CompanyName as company_name,
    Industry as industry,
    Region as region,
    Year as year,
    Revenue as revenue,
    ProfitMargin as profit_margin,
    MarketCap as market_cap,
    GrowthRate as growth_rate,
    ESG_Overall as esg_overall,
    ESG_Environmental as esg_environmental,
    ESG_Social as esg_social,
    ESG_Governance as esg_governance,
    CarbonEmissions as carbon_emissions,
    WaterUsage as water_usage,
    EnergyConsumption as energy_consumption
    from source
)

select * from renamed where year = 2025