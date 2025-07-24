{% set relation = adapter.get_relation(database=target.database, schema='dbt-hshi', identifier='count_rows_per_year') %}
{% set columns = adapter.get_columns_in_relation(relation) %}