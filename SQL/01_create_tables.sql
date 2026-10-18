-- Customer Churn Analysis Project
-- Create the customers table

USE customer_churn;

CREATE TABLE IF NOT EXISTS customers (
    CustomerID VARCHAR(20) PRIMARY KEY,
    Age INT NULL,
    Gender VARCHAR(20),
    Region VARCHAR(30),
    ContractType VARCHAR(20),
    MonthlyCharges DECIMAL(10,2),
    SignupDate DATE NULL
);


-- Create the usage table

CREATE TABLE IF NOT EXISTS `usage` (
    CustomerID VARCHAR(20) NOT NULL,
    Month VARCHAR(20),
    CallMinutes DECIMAL(10,2),
    DataUsageGB DECIMAL(10,2),
    SMSCount INT,
    Complaints INT
);

-- Create the churn_labels table

CREATE TABLE IF NOT EXISTS churn_labels (
    CustomerID VARCHAR(20) PRIMARY KEY,
    Churn TINYINT NOT NULL
);

