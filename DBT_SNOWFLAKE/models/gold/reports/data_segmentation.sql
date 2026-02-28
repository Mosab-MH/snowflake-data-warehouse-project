/*Group customers into three segments based on their spending behavior:
    - vip: customers wiith at least 12 months of history and spending more than $5,000.
    - regular: customers with at least 12 months of history but spending  $5,000. or less.
    - new: customers with lifespan less than 12 months.
 And find the total number of customers by each group*/


WITH CUSTOMER_SPENDING AS (
SELECT 
    c.CUSTOMER_KEY,
    SUM(f.SALES_AMOUNT) AS TOTAL_SPENDING,
    MIN(f.ORDER_DATE) AS FIRST_ORDER_DATE,
    MAX(f.ORDER_DATE) AS LAST_ORDER_DATE,
    DATEDIFF(MONTH, MIN(f.ORDER_DATE), MAX(f.ORDER_DATE)) AS LIFESPAN
FROM {{ ref('fact_sales') }} f
LEFT JOIN {{ ref('dim_customers') }} c
ON f.CUSTOMER_KEY = c.CUSTOMER_KEY
GROUP BY c.CUSTOMER_KEY
)
SELECT
    CUSTOMER_SEGMENT,
    COUNT(CUSTOMER_KEY) AS TOTAL_CUSTOMERS
FROM(
SELECT 
    CUSTOMER_KEY,
    TOTAL_SPENDING,
    LIFESPAN,
    CASE 
        WHEN LIFESPAN >= 12 AND TOTAL_SPENDING > 5000 THEN 'VIP'
        WHEN LIFESPAN >= 12 AND TOTAL_SPENDING <= 5000 THEN 'REGULAR'
        ELSE 'NEW'
    END AS CUSTOMER_SEGMENT
FROM CUSTOMER_SPENDING) t
GROUP BY CUSTOMER_SEGMENT 
ORDER BY CUSTOMER_SEGMENT DESC