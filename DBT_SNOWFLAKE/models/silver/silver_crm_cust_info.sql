-- silver_crm_cust_info.sql

SELECT
    CST_ID,
    CST_KEY,
    trim(CST_FIRSTNAME) AS CST_FIRSTNAME,
    TRIM(CST_LASTNAME) AS CST_LASTNAME,
    CASE 
        WHEN UPPER(TRIM(CST_MARITAL_STATUS)) IN ('S', 'SINGLE') THEN 'Single'
        WHEN UPPER(TRIM(CST_MARITAL_STATUS)) IN ('M', 'MARRIED') THEN 'Married'
        ELSE 'N/A'
    END AS CST_MARITAL_STATUS,
    CASE 
        WHEN UPPER(TRIM(CST_GNDR)) = 'M' THEN 'Male'
        WHEN UPPER(TRIM(CST_GNDR)) = 'F' THEN 'Female'
        ELSE 'Unknown'
    END AS CST_GNDR,
    CST_CREATE_DATE,
    CURRENT_TIMESTAMP() AS dwh_create_date
FROM (
SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY CST_ID ORDER BY CST_CREATE_DATE DESC) AS FLAG_LAST 
FROM {{ ref('bronze_crm_cust_info') }}
WHERE CST_ID IS NOT NULL
) t 
WHERE FLAG_LAST = 1


--------------

   
    