with diff as (
    select * from {{ ref('int_kaggle_diff') }}
)
select
    avg(abs(esg_overall_diff)) as avg_diff_esg_overall,
    avg(abs(esg_environmental_diff)) as avg_diff_esg_environmental,
    avg(abs(esg_social_diff)) as avg_diff_esg_social,
    avg(abs(esg_governance_diff)) as avg_diff_esg_governance,
    avg(abs(carbon_emissions_pct_diff)) as avg_carbon_emissions_pct_diff,
    avg(abs(water_usage_pct_diff)) as avg_water_usage_pct_diff,
    avg(abs(energy_consumption_pct_diff)) as avg_energy_consumption_pct_diff
from diff
