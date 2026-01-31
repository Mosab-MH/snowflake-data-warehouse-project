
 select * 
 from {{ source('bronze', 'crm_cust_info') }}

    