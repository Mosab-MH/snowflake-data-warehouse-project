
     select *
     from {{ source('bronze', 'crm_prd_info') }}
    