
 select * 
 from {{ source('bronze', 'crm_sales_details') }}

    