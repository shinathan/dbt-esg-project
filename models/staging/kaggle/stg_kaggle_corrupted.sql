with source as (
    select * from {{ source("raw", "company_esg_financial_dataset") }}
),

add_row_id as (
    select *,
           row_number() over() as row_id
    from source
),

corrupted as (
    select
        companyid,
        companyname,
        industry,
        region,
        year,
        revenue,
        profitmargin,
        marketcap,
        growthrate,
            
        -- ESG_Overall: 1% chance to add random number between 1 and 50
        case 
            when rand() < 0.01 then ESG_Overall + round(rand() * 50, 2)
            else ESG_Overall
        end as ESG_Overall,

        -- ESG_Environmental: 1% below 0, 1% above 100
        case 
            when rand() < 0.01 then -1 * abs(ESG_Environmental)
            when rand() < 0.01 then 100 + rand() * 50
            else ESG_Environmental
        end as ESG_Environmental,

        -- ESG_Social: same logic
        case 
            when rand() < 0.01 then -1 * abs(ESG_Social)
            when rand() < 0.01 then 100 + rand() * 50
            else ESG_Social
        end as ESG_Social,

        -- ESG_Governance: same logic
        case 
            when rand() < 0.01 then -1 * abs(ESG_Governance)
            when rand() < 0.01 then 100 + rand() * 50
            else ESG_Governance
        end as ESG_Governance,

        -- CarbonEmissions: 1% set to 0, 1% negative
        case 
            when rand() < 0.01 then NULL
            when rand() < 0.01 then -1 * abs(CarbonEmissions)
            else CarbonEmissions
        end as CarbonEmissions,

        -- WaterUsage: same logic
        case 
            when rand() < 0.01 then NULL
            when rand() < 0.01 then -1 * abs(WaterUsage)
            else WaterUsage
        end as WaterUsage,

        -- EnergyConsumption: same logic
        case 
            when rand() < 0.01 then NULL
            when rand() < 0.01 then -1 * abs(EnergyConsumption)
            else EnergyConsumption
        end as EnergyConsumption

    from add_row_id
),

-- Duplicate 1% of the rows
duplicates as (
    select * from corrupted where rand() < 0.01
),

final as (
    select * from corrupted
    union all
    select * from duplicates
)

select * from final