SELECT *
FROM  {{ source("raw", "company_esg_financial_dataset") }}
