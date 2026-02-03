
SELECT 
    PRD_ID,
    REPLACE(SUBSTRING(PRD_KEY, 1, 5) , '-', '_') AS CAT_ID,
    SUBSTRING(PRD_KEY, 7, LEN(PRD_KEY)) AS PRD_KEY,
    PRD_NM,
    COALESCE(PRD_COST, 0)  AS PRD_COST,
    CASE UPPER(TRIM(PRD_LINE))
        WHEN 'M' THEN 'Mountain'
        WHEN 'R' THEN 'Road'
        WHEN 'T' THEN 'Touring'
        WHEN 'S' THEN 'Other Sales'
        ELSE 'n/a'
    END AS PRD_LINE,
    CAST (PRD_START_DT AS DATE) AS PRD_START_DT,
    CAST( DATEADD(DAY, -1, LEAD(PRD_START_DT) OVER (PARTITION BY PRD_KEY ORDER BY PRD_START_DT)) AS DATE ) AS PRD_END_DT,
    CURRENT_TIMESTAMP() AS dwh_create_date
FROM {{ ref('bronze_crm_prd_info') }}
