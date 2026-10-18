
-- Customer Churn Analysis
-- SQL Business Analysis

USE customer_churn;


-- 1. Overall churn rate

SELECT
    COUNT(*) AS total_customers,
    SUM(Churn) AS customers_churned,
    ROUND(AVG(Churn) * 100, 2) AS churn_rate_percentage
FROM churn_labels;


-- 2. Churn by contract type

SELECT
    c.ContractType,
    COUNT(*) AS total_customers,
    SUM(cl.Churn) AS customers_churned,
    ROUND(AVG(cl.Churn) * 100, 2) AS churn_rate_percentage
FROM customers AS c
JOIN churn_labels AS cl
    ON c.CustomerID = cl.CustomerID
GROUP BY c.ContractType
ORDER BY churn_rate_percentage DESC;


-- 3. Churn by region

SELECT
    c.Region,
    COUNT(*) AS total_customers,
    SUM(cl.Churn) AS customers_churned,
    ROUND(AVG(cl.Churn) * 100, 2) AS churn_rate_percentage
FROM customers AS c
JOIN churn_labels AS cl
    ON c.CustomerID = cl.CustomerID
GROUP BY c.Region
ORDER BY churn_rate_percentage DESC;


-- 4. Churn by age group

SELECT
    CASE
        WHEN c.Age <= 25 THEN '18-25'
        WHEN c.Age <= 35 THEN '26-35'
        WHEN c.Age <= 45 THEN '36-45'
        WHEN c.Age <= 55 THEN '46-55'
        ELSE '56+'
    END AS age_group,
    COUNT(*) AS total_customers,
    SUM(cl.Churn) AS customers_churned,
    ROUND(AVG(cl.Churn) * 100, 2) AS churn_rate_percentage
FROM customers AS c
JOIN churn_labels AS cl
    ON c.CustomerID = cl.CustomerID
WHERE c.Age IS NOT NULL
GROUP BY age_group
ORDER BY churn_rate_percentage DESC;


-- 5. Churn by gender

SELECT
    c.Gender,
    COUNT(*) AS total_customers,
    SUM(cl.Churn) AS customers_churned,
    ROUND(AVG(cl.Churn) * 100, 2) AS churn_rate_percentage
FROM customers AS c
JOIN churn_labels AS cl
    ON c.CustomerID = cl.CustomerID
GROUP BY c.Gender
ORDER BY churn_rate_percentage DESC;


-- 6. Churn by monthly charge group
-- Approximate quartile cutoffs; validate unusual charge values.

SELECT
    CASE
        WHEN c.MonthlyCharges < 39.80 THEN 'Low'
        WHEN c.MonthlyCharges < 50.02 THEN 'Medium'
        WHEN c.MonthlyCharges < 60.50 THEN 'High'
        ELSE 'Very High'
    END AS charge_group,
    COUNT(*) AS total_customers,
    SUM(cl.Churn) AS customers_churned,
    ROUND(AVG(cl.Churn) * 100, 2) AS churn_rate_percentage
FROM customers AS c
JOIN churn_labels AS cl
    ON c.CustomerID = cl.CustomerID
GROUP BY charge_group
ORDER BY churn_rate_percentage DESC;


-- 7. Churn by total complaint group

SELECT
    CASE
        WHEN cc.Total_Complaints = 0 THEN 'No Complaints'
        WHEN cc.Total_Complaints <= 5 THEN '1-5 Complaints'
        ELSE '6+ Complaints'
    END AS complaint_group,
    COUNT(*) AS total_customers,
    SUM(cl.Churn) AS customers_churned,
    ROUND(AVG(cl.Churn) * 100, 2) AS churn_rate_percentage
FROM (
    SELECT
        CustomerID,
        SUM(Complaints) AS Total_Complaints
    FROM `usage`
    GROUP BY CustomerID
) AS cc
JOIN churn_labels AS cl
    ON cc.CustomerID = cl.CustomerID
GROUP BY complaint_group
ORDER BY churn_rate_percentage DESC;


-- 8. Churn by signup year

SELECT
    YEAR(c.SignupDate) AS signup_year,
    COUNT(*) AS total_customers,
    SUM(cl.Churn) AS customers_churned,
    ROUND(AVG(cl.Churn) * 100, 2) AS churn_rate_percentage
FROM customers AS c
JOIN churn_labels AS cl
    ON c.CustomerID = cl.CustomerID
WHERE c.SignupDate IS NOT NULL
GROUP BY YEAR(c.SignupDate)
ORDER BY signup_year;


-- 9. Monthly data usage by churn status

SELECT
    cl.Churn,
    u.Month,
    ROUND(AVG(u.DataUsageGB), 2) AS average_data_usage_gb,
    COUNT(DISTINCT u.CustomerID) AS total_customers
FROM `usage` AS u
JOIN churn_labels AS cl
    ON u.CustomerID = cl.CustomerID
GROUP BY cl.Churn, u.Month
ORDER BY u.Month, cl.Churn;


-- 10. Monthly call minutes by churn status

SELECT
    cl.Churn,
    u.Month,
    ROUND(AVG(u.CallMinutes), 2) AS average_call_minutes,
    COUNT(DISTINCT u.CustomerID) AS total_customers
FROM `usage` AS u
JOIN churn_labels AS cl
    ON u.CustomerID = cl.CustomerID
GROUP BY cl.Churn, u.Month
ORDER BY u.Month, cl.Churn;


-- 11. Monthly complaints by churn status

SELECT
    cl.Churn,
    u.Month,
    ROUND(AVG(u.Complaints), 2) AS average_complaints,
    COUNT(DISTINCT u.CustomerID) AS total_customers
FROM `usage` AS u
JOIN churn_labels AS cl
    ON u.CustomerID = cl.CustomerID
GROUP BY cl.Churn, u.Month
ORDER BY u.Month, cl.Churn;


-- 12. Customer-level usage summary

SELECT
    u.CustomerID,
    SUM(u.CallMinutes) AS total_call_minutes,
    SUM(u.DataUsageGB) AS total_data_usage_gb,
    SUM(u.SMSCount) AS total_sms,
    SUM(u.Complaints) AS total_complaints,
    cl.Churn
FROM `usage` AS u
JOIN churn_labels AS cl
    ON u.CustomerID = cl.CustomerID
GROUP BY u.CustomerID, cl.Churn
ORDER BY total_complaints DESC;


-- 13. Compare average customer usage by churn status

WITH customer_usage AS (
    SELECT
        CustomerID,
        SUM(CallMinutes) AS total_call_minutes,
        SUM(DataUsageGB) AS total_data_usage_gb,
        SUM(SMSCount) AS total_sms,
        SUM(Complaints) AS total_complaints
    FROM `usage`
    GROUP BY CustomerID
)
SELECT
    cl.Churn,
    COUNT(*) AS total_customers,
    ROUND(AVG(cu.total_call_minutes), 2) AS avg_call_minutes,
    ROUND(AVG(cu.total_data_usage_gb), 2) AS avg_data_usage_gb,
    ROUND(AVG(cu.total_sms), 2) AS avg_sms,
    ROUND(AVG(cu.total_complaints), 2) AS avg_complaints
FROM customer_usage AS cu
JOIN churn_labels AS cl
    ON cu.CustomerID = cl.CustomerID
GROUP BY cl.Churn
ORDER BY cl.Churn;


-- 14. Find customers with unusually high or negative monthly charges
-- Flag for investigation; do not automatically delete these records.

SELECT
    CustomerID,
    MonthlyCharges,
    ContractType,
    Region
FROM customers
WHERE MonthlyCharges < 0
   OR MonthlyCharges > 200
ORDER BY MonthlyCharges;


-- 15. Data quality checks

SELECT
    COUNT(*) AS total_customers,
    COUNT(DISTINCT CustomerID) AS unique_customer_ids,
    SUM(Age IS NULL) AS missing_ages,
    SUM(SignupDate IS NULL) AS missing_signup_dates,
    SUM(MonthlyCharges IS NULL) AS missing_monthly_charges
FROM customers;

-- 16. Validate churn label distribution

SELECT
    Churn,
    COUNT(*) AS customer_count,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM churn_labels),
        2
    ) AS percentage_of_all_customers
FROM churn_labels
GROUP BY Churn
ORDER BY Churn;