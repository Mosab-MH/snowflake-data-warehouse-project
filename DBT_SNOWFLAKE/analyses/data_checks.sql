
/*
--QUALITY CHECKS 
--1. Check for NULL or duplicate IN PRAIMARY KEY
--EXPECTED RESULT: No RESULTS
SELECT 
    PRD_ID,
    COUNT(*)
FROM {{ ref('silver_crm_prd_info') }}
GROUP BY PRD_ID
HAVING COUNT(*) > 1 OR PRD_ID IS NULL
*/



/*
--2. Check for UNTRIMMED SPACES
-- EXPECTED RESULT: No RESULTS
SELECT PRD_NM
FROM {{ ref('silver_crm_prd_info') }}
WHERE PRD_NM != TRIM(PRD_NM)
*/


/*
--3. Check for NEGATIVE or NULL NUMBER
-- EXPECTED RESULT: No RESULTS
SELECT PRD_COST 
FROM {{ ref('silver_crm_prd_info') }}
WHERE PRD_COST < 0 OR PRD_COST IS NULL
*/


/*
--4. DATA STANDARDIZATION & CONSISTENCY CHECK
-- EXPECTED RESULT: Only values from the CASE statement in the model
SELECT DISTINCT PRD_LINE
FROM {{ ref('silver_crm_prd_info') }}
*/


/*
--5. CHECK FOR INVALID DATE
-- EXPECTED RESULT: No RESULTS
SELECT * 
FROM {{ ref('silver_crm_prd_info') }}
WHERE PRD_END_DT < PRD_START_DT
*/