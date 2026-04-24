


SELECT *
FROM {{ ref('fact_sales') }} f
LEFT JOIN {{ ref('dim_customers') }} c
ON f.CUSTOMER_KEY = c.CUSTOMER_KEY