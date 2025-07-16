SELECT *
FROM  {{ source("raw", "company_esg_financial_dataset") }}
WHERE 
    ABS(ESG_Overall - ((ESG_Environmental + ESG_Social + ESG_Governance) / 3.0)) > 0.1