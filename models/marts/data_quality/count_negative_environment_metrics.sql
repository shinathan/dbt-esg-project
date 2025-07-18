{% set datasets = ['stg_kaggle_2016_corrupted', 'stg_kaggle_2025_corrupted'] %}


{% set neg_columns = [
  'water_usage',
  'energy_consumption',
  'carbon_emissions',
] %}

WITH
{%- for dataset in datasets %}
  neg_counts_{{ loop.index }} AS (
    SELECT
      '{{ dataset }}' AS dataset,
      {%- for col in neg_columns %}
      COUNTIF({{ col }} < 0) AS {{ col }}_neg_count{{ "," if not loop.last }}
      {%- endfor %}
    FROM {{ ref(dataset) }}
  ){{ "," if not loop.last }}
{%- endfor %}

SELECT * FROM neg_counts_1
{%- for i in range(2, datasets | length + 1) %}
UNION ALL
SELECT * FROM neg_counts_{{ i }}
{%- endfor %}
