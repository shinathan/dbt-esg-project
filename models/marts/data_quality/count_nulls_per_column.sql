{% set datasets = [
  'stg_kaggle_2016',
  'stg_kaggle_2025',
] %}

{% set columns = [
    'company_id',
    'company_name',
    'industry',
    'region',
    'year',
    'revenue',
    'profit_margin',
    'market_cap',
    'esg_overall',
    'esg_environmental',
    'esg_social',
    'esg_governance',
    'carbon_emissions',
    'water_usage',
    'energy_consumption',
    'growth_rate'
] %}


-- For each dataset in the list, create a CTE that calculates null counts for all specified columns.
WITH
{%- for dataset in datasets %}
  null_counts_{{ loop.index }} AS (
    SELECT
      -- Label each row with the dataset name for clarity in the final results.
      '{{ dataset }}' AS dataset,
      -- Generate null counts for each column using the macro.
      {%- for col in columns %}
        {{ null_count_expr(col) }}{{ "," if not loop.last }}
      {%- endfor %}
    FROM {{ ref(dataset) }}
  ){{ "," if not loop.last }}  -- Add a comma between CTEs except after the last one.
{%- endfor %}

-- Final query: UNION ALL all CTEs to combine results vertically.
SELECT * FROM null_counts_1
{%- for i in range(2, datasets | length + 1) %}
UNION ALL
SELECT * FROM null_counts_{{ i }}
{%- endfor %}