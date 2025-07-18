{% set datasets = ['stg_kaggle_2016_corrupted', 'stg_kaggle_2025_corrupted'] %}

{% set esg_columns = [
    'esg_overall',
    'esg_environmental',
    'esg_social',
    'esg_governance'
] %}

-- For each dataset in the list, create a CTE that calculates out-of-range counts for ESG columns.
WITH
{%- for dataset in datasets %}
  esg_out_of_range_{{ loop.index }} AS (
    SELECT
      '{{ dataset }}' AS dataset,
      {%- for col in esg_columns %}
        {{ esg_out_of_range_expr(col) }}{{ "," if not loop.last }}
      {%- endfor %}
    FROM {{ ref(dataset) }}
  ){{ "," if not loop.last }}
{%- endfor %}

-- Final query: UNION ALL all CTEs to combine results vertically.
SELECT * FROM esg_out_of_range_1
{%- for i in range(2, datasets | length + 1) %}
UNION ALL
SELECT * FROM esg_out_of_range_{{ i }}
{%- endfor %}
