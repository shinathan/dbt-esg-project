{% set datasets = ['stg_kaggle_2016_corrupted', 'stg_kaggle_2025_corrupted'] %}

{% set columns = [
  'company_year',
  'company_id',
  'company_name',
  'industry',
  'region',
  'year',
  'revenue',
  'profit_margin',
  'market_cap',
  'growth_rate',
  'esg_overall',
  'esg_environmental',
  'esg_social',
  'esg_governance',
  'carbon_emissions',
  'water_usage',
  'energy_consumption'
] %}

select dataset_name, sum(dup_count) as total_duplicates
from (

  {% for dataset in datasets %}
    select
      '{{ dataset }}' as dataset_name,
      count(*) as dup_count
    from {{ ref(dataset) }}
    group by {{ columns | join(', ') }}
    having count(*) > 1

    {% if not loop.last %}
    union all
    {% endif %}
  {% endfor %}

) grouped
group by dataset_name
