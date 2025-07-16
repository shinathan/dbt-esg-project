select year, count(*)
from {{ source("raw", "company_esg_financial_dataset") }}
group by year
