{% set datasets = ['stg_kaggle_2016_corrupted', 'stg_kaggle_2025_corrupted'] %}

{% for dataset in datasets %}
SELECT
  '{{ dataset }}' AS dataset_name,
  COUNT(*) AS num_rows
FROM {{ ref(dataset) }}

{% if not loop.last %}
UNION ALL
{% endif %}
{% endfor %}
