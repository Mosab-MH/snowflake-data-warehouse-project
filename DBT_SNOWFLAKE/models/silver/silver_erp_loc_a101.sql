    
    
    SELECT 
    REPLACE(CID, '-', '') CID,
        CASE 
            WHEN TRIM(CNTRY) = 'DE' THEN 'Germany'
            WHEN TRIM(CNTRY) IN ('US', 'USA') THEN 'United States'
            WHEN TRIM(CNTRY) =  '' OR CNTRY IS NULL THEN 'n/a'
            ELSE TRIM(CNTRY)
        END AS CNTRY ,
    CURRENT_TIMESTAMP() AS dwh_create_date
    FROM {{ref('bronze_erp_loc_a101')}} 