with diff as (
    select * from {{ ref('int_kaggle_diff') }}
)
select
    growth_rate_decile,
    avg(esg_overall_diff) as avg_diff_esg_overall,
    avg(esg_environmental_diff) as avg_diff_esg_environmental,
    avg(esg_social_diff) as avg_diff_esg_social,
    avg(esg_governance_diff) as avg_diff_esg_governance,
    avg(carbon_emissions_pct_diff) as avg_carbon_emissions_pct_diff,
    avg(water_usage_pct_diff) as avg_water_usage_pct_diff,
    avg(energy_consumption_pct_diff) as avg_energy_consumption_pct_diff
from diff
group by growth_rate_decile
order by growth_rate_decile
