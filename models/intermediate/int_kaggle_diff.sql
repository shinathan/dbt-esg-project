with
t16 as (
    select *
    from {{ ref('stg_kaggle_2016') }}
),
t25 as (
    select *
    from {{ ref('stg_kaggle_2025') }}
),

joined as (
    select
        t25.company_year,
        t25.company_id,
        t25.company_name,
        t25.industry,
        t25.region,
        t25.year,

        t25.revenue,
        t25.profit_margin,
        t25.market_cap,
        t25.growth_rate,

        -- ESG Score Differences
        t25.esg_overall - t16.esg_overall as esg_overall_diff,
        t25.esg_environmental - t16.esg_environmental as esg_environmental_diff,
        t25.esg_social - t16.esg_social as esg_social_diff,
        t25.esg_governance - t16.esg_governance as esg_governance_diff,

        -- % Difference = (New - Old) / Average
        case
            when (t25.carbon_emissions + t16.carbon_emissions) = 0 then 0
            else (t25.carbon_emissions - t16.carbon_emissions) / ((t25.carbon_emissions + t16.carbon_emissions) / 2.0)
        end as carbon_emissions_pct_diff,

        case
            when (t25.water_usage + t16.water_usage) = 0 then 0
            else (t25.water_usage - t16.water_usage) / ((t25.water_usage + t16.water_usage) / 2.0)
        end as water_usage_pct_diff,

        case
            when (t25.energy_consumption + t16.energy_consumption) = 0 then 0
            else (t25.energy_consumption - t16.energy_consumption) / ((t25.energy_consumption + t16.energy_consumption) / 2.0)
        end as energy_consumption_pct_diff

    from t25
    join t16
      on t25.company_id = t16.company_id
)

select *
from joined
