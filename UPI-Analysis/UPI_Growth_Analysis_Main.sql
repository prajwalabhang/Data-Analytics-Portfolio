-- ==========================================
-- UPI GROWTH ANALYSIS PROJECT
-- Period: April 2025 - March 2026
-- ==========================================
USE upi_project;

-- SECTION 1: TOP 10 BANK ANALYSIS

WITH Remitter_Totals AS (
	SELECT 
		Bank_Name,
        SUM(Remitter_Vol_Mn) AS Total_Sent_Mn
	FROM bank_data
    GROUP BY Bank_Name
),
Beneficiary_Totals AS (
	SELECT 
		Bank_Name,
        SUM(Beneficiary_Vol_Mn) AS Total_Received_Mn
	FROM bank_data
    GROUP BY Bank_Name
)
SELECT
	r.Bank_Name,
    ROUND(r.Total_Sent_Mn,2) AS Total_Sent_Mn,
    ROUND(b.Total_Received_Mn,2) AS Total_Received_Mn,
    ROUND(b.Total_Received_Mn - r.Total_Sent_Mn,2 ) AS Net_Difference
FROM Remitter_Totals r
JOIN Beneficiary_Totals b
	ON r.Bank_Name = b.Bank_Name
ORDER BY Total_Sent_Mn DESC
LIMIT 10; 

-- ==========================================
-- SECTION 2: DATA VERIFICATION
-- ==========================================

-- 2.1 Total number of records
SELECT COUNT(*) AS Total_Records
FROM bank_data;


-- 2.2 Check the number of unique banks
SELECT COUNT(DISTINCT Bank_Name) AS Total_Banks
FROM bank_data;

-- 2.3 Check monthly record distribution
SELECT
    Month,
    COUNT(*) AS Total_Records
FROM bank_data
GROUP BY Month;
