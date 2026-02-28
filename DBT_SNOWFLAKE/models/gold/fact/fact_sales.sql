SELECT 
    sd.SLS_ORD_NUM AS ORDER_NUMBER,
    pr.PROUDACT_KEY,
    cu.CUSTOMER_KEY,
    sd.SLS_ORDER_DT AS ORDER_DATE,
    sd.SLS_SHIP_DT AS SHIPING_DATE,
    sd.SLS_DUE_DT AS DUE_DATE,
    sd.SLS_SALES AS SALES_AMOUNT,
    sd.SLS_QUANTITY AS QUANTITY,
    sd.SLS_PRICE AS PRICE
FROM {{ ref('silver_crm_sales_details') }} sd
LEFT JOIN {{ ref('dim_products') }} pr
ON sd.SLS_PRD_KEY = pr.PROUDACT_NUMBER
LEFT JOIN {{ ref('dim_customers') }} cu
ON sd.SLS_CUST_ID = cu.CUSTOMER_ID



