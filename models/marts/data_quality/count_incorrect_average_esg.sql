{% set datasets = [
  'stg_kaggle_2016',
  'stg_kaggle_2025',
] %}

WITH
{%- for dataset in datasets %}
  esg_check_{{ loop.index }} AS (
    SELECT
      '{{ dataset }}' AS dataset,
      COUNT(*) AS non_average_esg_count
    FROM {{ ref(dataset) }}
    WHERE 
      ABS(esg_overall - ((esg_environmental + esg_social + esg_governance) / 3.0)) > 0.1
  ){{ "," if not loop.last }}
{%- endfor %}

SELECT * FROM esg_check_1
{%- for i in range(2, datasets | length + 1) %}
UNION ALL
SELECT * FROM esg_check_{{ i }}
{%- endfor %}
