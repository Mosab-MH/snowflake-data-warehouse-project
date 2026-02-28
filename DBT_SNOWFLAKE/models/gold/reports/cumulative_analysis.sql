
--Calculate The total sales per year
-- and the running total sales over time
SELECT 
    ORDER_DATE,
    TOTAL_SALES,
    SUM(TOTAL_SALES) OVER ( ORDER BY ORDER_DATE ) AS RUNNING_TOTAL_SALES,
    ROUND(AVG (AVG_PRICE) OVER ( ORDER BY ORDER_DATE ),0) AS MOVING_AVERAGE_PRICE
FROM 
(
    SELECT 
    date_trunc(year,ORDER_DATE) AS ORDER_DATE,
    SUM(SALES_AMOUNT) AS TOTAL_SALES,
    AVG(PRICE) AS AVG_PRICE
    FROM {{ ref('fact_sales') }}
    WHERE ORDER_DATE IS NOT NULL
    GROUP BY 1
) t