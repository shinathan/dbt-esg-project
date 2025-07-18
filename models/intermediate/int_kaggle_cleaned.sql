with source as (
    select * from {{ ref('stg_kaggle_corrupted') }}
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
        ESG_Environmental as esg_environmental,
        ESG_Social as esg_social,
        ESG_Governance as esg_governance,
        CarbonEmissions as carbon_emissions,
        WaterUsage as water_usage,
        EnergyConsumption as energy_consumption
    from source
),

valid_esg as (
    select *
    from renamed
    where esg_social between 0 and 100
      and esg_environmental between 0 and 100
      and esg_governance between 0 and 100
),

no_nulls as (
    select *
    from valid_esg
    where
        company_year is not null and
        company_id is not null and
        company_name is not null and
        industry is not null and
        region is not null and
        year is not null and
        revenue is not null and
        profit_margin is not null and
        market_cap is not null and
        growth_rate is not null and
        esg_environmental is not null and
        esg_social is not null and
        esg_governance is not null and
        carbon_emissions is not null and
        water_usage is not null and
        energy_consumption is not null
),

esg_calculated as (
    select
        *,
        (
            (esg_social + esg_environmental + esg_governance) / 3.0
        ) as esg_overall_new
    from no_nulls
),

deduped as (
    select distinct 
        company_year,
        company_id,
        company_name,
        industry,
        region,
        year,
        revenue,
        profit_margin,
        market_cap,
        growth_rate,
        esg_overall_new as esg_overall,
        esg_environmental,
        esg_social,
        esg_governance,
        carbon_emissions,
        water_usage,
        energy_consumption
    from esg_calculated
)

select * from deduped
order by company_year
