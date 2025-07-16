with diff as (
    select * from {{ ref('int_kaggle_diff') }}
)
select
    avg(esg_overall) as avg_esg_overall,
    avg(esg_environmental) as avg_esg_environmental,
    avg(esg_social) as avg_esg_social,
    avg(esg_governance) as avg_esg_governance
from diff
