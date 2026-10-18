# Customer Churn & Retention Analysis

An end-to-end data analytics project exploring customer churn patterns using Python, SQL, and Power BI. The goal is to understand customer retention, identify segments with higher churn rates, and translate the findings into actionable business recommendations.

## Dashboard Preview

![Customer Churn Analysis Dashboard](images/dashboard.png)

## Project Overview

Customer churn is an important business metric because losing customers can affect revenue, retention, and long-term growth. In this project, I analyzed customer information, usage records, and churn labels to understand how churn varies across different customer segments.

The project covers data cleaning, exploratory data analysis (EDA), SQL-based analysis, and interactive dashboard development in Power BI.

### Project Highlights

- Analyzed **10,000 unique customers** and **120,000 usage records**.
- Identified **786 churned customers**, representing an overall churn rate of **7.86%**.
- Compared churn across contract types, regions, age groups, gender, and signup years.
- Used Python and SQL to analyze the data and cross-check key results.
- Built a Power BI dashboard to present customer retention KPIs and segment-level churn patterns.

## Tools & Technologies

- **Python:** Data cleaning, analysis, and visualization
- **Pandas and NumPy:** Data manipulation and numerical analysis
- **Matplotlib and Seaborn:** Data visualization
- **SQL (MySQL):** Data querying, joins, aggregations, and segmentation
- **Power BI:** KPI cards, charts, and interactive dashboard
- **Jupyter Notebook:** Analysis workflow and documentation

## Dataset

The project uses three datasets:

| Dataset | Description |
|---|---|
| Customer information | Customer demographics, contract type, monthly charges, and signup date |
| Usage data | Monthly call minutes, data usage, SMS counts, and complaints |
| Churn labels | Indicates whether each customer stayed or churned |

The customer dataset initially contained 10,200 rows, including duplicate records and conflicting signup dates. The cleaned customer dataset contains 10,000 unique customer records.

## Analysis Workflow

### 1. Data Cleaning and Quality Checks

- Inspected dataset dimensions, column types, missing values, and duplicate records.
- Removed exact duplicate customer records.
- Identified five customer IDs with conflicting signup dates and treated those dates as missing rather than arbitrarily choosing one.
- Examined missing age values and retained them as missing instead of inventing customer ages.
- Investigated suspicious monthly charge values, including negative values and unusually high charges.
- Exported cleaned datasets for further analysis.

### 2. Exploratory Data Analysis (EDA)

Analyzed customer churn by:

- Contract type
- Geographic region
- Age group
- Gender
- Signup year

Also compared usage metrics and complaint counts between customers who stayed and those who churned.

### 3. SQL Analysis

Used MySQL to analyze churn distribution, customer segments, usage patterns, complaint metrics, and data quality.

SQL techniques included joins, aggregate functions, `GROUP BY`, conditional calculations, and customer-level summaries. Key results were cross-checked against the Python analysis.

### 4. Power BI Dashboard

Developed a dashboard containing:

- Total customers
- Churned customers
- Retained customers
- Overall churn rate
- Churn rate by contract type
- Churn rate by region
- Churn rate by age group
- Churn rate by gender
- Churn rate by signup year

The dashboard provides a consolidated view of customer retention and helps compare churn patterns across customer segments.

## Key Findings

### Overall Churn

| Metric | Result |
|---|---:|
| Total customers | 10,000 |
| Retained customers | 9,214 |
| Churned customers | 786 |
| Overall churn rate | 7.86% |

### Churn by Contract Type

| Contract Type | Customers | Churned | Churn Rate |
|---|---:|---:|---:|
| Monthly | 3,953 | 299 | 7.56% |
| Prepaid | 4,041 | 310 | 7.67% |
| Yearly | 2,006 | 177 | 8.82% |

Yearly contract customers had the highest observed churn rate at 8.82%. This is a segment worth investigating further rather than assuming that contract duration explains churn.

### Churn by Region

| Region | Customers | Churned | Churn Rate |
|---|---:|---:|---:|
| Urban | 3,287 | 267 | 8.12% |
| Suburban | 3,402 | 274 | 8.05% |
| Rural | 3,311 | 245 | 7.40% |

Urban and suburban customers had slightly higher churn rates than rural customers. The differences are relatively small and would need further investigation before drawing conclusions about their causes.

### Churn by Age Group

| Age Group | Customers | Churned | Churn Rate |
|---|---:|---:|---:|
| 18–25 | 991 | 74 | 7.47% |
| 26–35 | 1,267 | 92 | 7.26% |
| 36–45 | 1,293 | 99 | 7.66% |
| 46–55 | 1,226 | 108 | 8.81% |
| 56+ | 1,723 | 133 | 7.72% |

Customers aged 46–55 had the highest churn rate among the age groups with recorded ages. However, 3,500 customers had missing age values, so this analysis does not represent the full customer population by age.

### Other Observations

- **Gender:** The observed churn rate was 8.02% for male customers and 7.71% for female customers.
- **Signup year:** Churn rates ranged from 7.34% to 8.22% across the signup years analyzed, without a clear year-over-year pattern.
- **Usage patterns:** Average call minutes, data usage, and SMS counts were broadly similar between retained and churned customers.
- **Complaints:** Churned customers averaged 6.17 total complaints, compared with 6.02 among retained customers. This difference is small and does not establish a causal relationship.

## Business Recommendations

Based on the observed patterns, the following areas could be investigated further:

1. **Investigate yearly-contract churn:** Review renewal experiences, service expectations, and customer feedback for this segment.
2. **Understand the 46–55 age group:** Explore whether service needs, pricing, or customer experience differ for this group.
3. **Review urban and suburban retention:** Examine complaints, service quality, and other factors that might explain the modest regional differences.
4. **Investigate complaint handling:** Compare complaint types, resolution times, and outcomes for customers who stay versus those who leave.
5. **Improve data quality:** Investigate missing demographic information and unusual monthly charge values before using these fields for further business decisions.

These are recommendations for further investigation, not proven causes of churn.

## Data Quality and Limitations

- The customer dataset contained 3,500 missing age values.
- Five conflicting signup dates were treated as missing.
- Five negative monthly charges and 38 charges above 200 were flagged for investigation.
- Age-based analysis excludes customers whose ages are missing.
- The findings are descriptive and do not establish causation.
- Usage metrics and complaint counts showed relatively small differences between churned and retained customers.
- The analysis depends on the quality and representativeness of the supplied datasets.

## How to Reproduce

### Prerequisites

- Python 3
- Jupyter Notebook
- Pandas and the other libraries imported by the notebook
- MySQL Server and MySQL Workbench
- Power BI Desktop

### Steps

1. Place the source CSV files in `Data/raw/`.
2. Install the Python dependencies documented in `requirements.txt`.
3. Open and run `churn_analysis.ipynb` to perform the documented cleaning and analysis.
4. Run `SQL/01_create_tables.sql` to create the database tables.
5. Import the corresponding cleaned CSV files into MySQL.
6. Run `SQL/02_data_analysis.sql` to execute the SQL analysis.
7. Open `churn_analysis_dashboard.pbix` in Power BI Desktop. Update data-source paths if the project is opened from a different location.

MySQL import settings and local file paths may need to be adjusted for your environment.

## Skills Demonstrated

- Data cleaning and quality validation
- Exploratory data analysis (EDA)
- Python and Pandas data manipulation
- SQL joins, aggregations, grouping, and segmentation
- Cross-checking key results between Python and SQL
- KPI design and Power BI dashboard development
- Business interpretation and communicating analytical limitations

## Project Structure

```text
Customer_Churn_Analysis/
├── Data/
│   ├── raw/
│   └── cleaned/
├── SQL/
│   ├── 01_create_tables.sql
│   └── 02_data_analysis.sql
├── images/
│   └── dashboard.png
├── churn_analysis.ipynb
├── churn_analysis_dashboard.pbix
├── requirements.txt
├── README.md
└── .gitignore
```

## Contact

**Aryan Yadav** — Aspiring Data Analyst

- **LinkedIn:** [Aryan Yadav](https://www.linkedin.com/in/aryan-yadav-234762292)
- **Email:** [aryannyadavv5555@gmail.com](mailto:aryannyadavv5555@gmail.com)

Open to Data Analyst internships and entry-level opportunities involving SQL, Python, Power BI, and business analytics.
