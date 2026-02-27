SELECT 
    *
FROM {{ ref('fact_sales') }} s
LEFT JOIN {{ ref('dim_customers') }} c
ON s.CUSTOMER_KEY = c.CUSTOMER_KEY