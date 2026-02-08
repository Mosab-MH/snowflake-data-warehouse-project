
SELECT
ROW_NUMBER() OVER (ORDER BY CST_ID) AS customer_key,
ci.CST_ID AS Customer_id,
ci.CST_KEY AS Customer_number,
ci.CST_FIRSTNAME AS First_name,
ci.CST_LASTNAME AS Last_name,
la.CNTRY AS Country ,
ci.CST_MARITAL_STATUS AS Marital_status,
CASE 
    WHEN ci.CST_GNDR != 'Unknown' THEN ci.CST_GNDR   --- CRM IS THE MASTER FOR GENDER INFORMATION
        ELSE COALESCE(ca.GEN, 'n/a')
END AS gender ,
ca.BDATE AS Birthdate,
ci.CST_CREATE_DATE AS Create_date
FROM {{ ref('silver_crm_cust_info') }} ci 
LEFT JOIN {{ ref('silver_erp_cust_az12') }} ca 
ON ci.CST_KEY = ca.CID 
LEFT JOIN {{ ref('silver_erp_loc_a101') }} la
ON ci.CST_KEY = la.CID

