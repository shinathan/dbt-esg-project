with source as (
    select * from {{ ref('int_kaggle_cleaned') }}
),

selection as (
    select * from source where year = 2016
)

select * from selection