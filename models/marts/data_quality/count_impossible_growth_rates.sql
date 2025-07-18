{% set datasets = ['stg_kaggle_2016_corrupted', 'stg_kaggle_2025_corrupted'] %}


WITH growthrate_counts AS (
  {%- for dataset in datasets %}
    SELECT
      '{{ dataset }}' AS dataset,
      COUNT(*) AS count_growthrate_below_minus_100
    FROM {{ ref(dataset) }}
    WHERE growth_rate <= -100
    {%- if not loop.last %} UNION ALL {%- endif %}
  {%- endfor %}
)

SELECT * FROM growthrate_counts
