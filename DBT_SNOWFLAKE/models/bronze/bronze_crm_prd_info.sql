

     select *
     from {{ source('raw', 'crm_prd_info') }}
       
    