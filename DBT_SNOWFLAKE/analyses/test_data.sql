

SELECT DISTINCT 
ci.CST_GNDR,
ca.GEN,
CASE 
    WHEN ci.CST_GNDR != 'Unknown' THEN ci.CST_GNDR   --- CRM IS THE MASTER FOR GENDER INFORMATION
        ELSE COALESCE(ca.GEN, 'n/a')
END AS new_gen                                                   
FROM {{ ref('silver_crm_cust_info') }} ci 
LEFT JOIN {{ ref('silver_erp_cust_az12') }} ca 
ON ci.CST_KEY = ca.CID 
LEFT JOIN {{ ref('silver_erp_loc_a101') }} la
ON ci.CST_KEY = la.CID
ORDER BY 1,2