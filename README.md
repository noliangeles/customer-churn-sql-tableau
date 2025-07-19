# Customer Churn Analysis (SQL + Tableau)

This project explores customer churn behavior using SQL for data analysis and Tableau for dashboard visualization.

## 🧱 Project Overview

- **Goal**: Identify trends, risk factors, and patterns among churned customers.
- **Tools Used**:
  - MySQL: For data storage and querying
  - Python: To import cleaned `.csv` files into MySQL
  - Tableau: For interactive dashboards

## 📂 Dataset

Data includes customer information, activity records, preferences, support tickets, and churn risk scores. Raw `.csv` files are located in the `data/` folder.

## ⚙️ Database Setup

The SQL schema was built with foreign key relationships and includes the following tables:
- `customers`
- `activity`
- `preferences`
- `support`
- `churn`

To recreate the structure, see [`sql/create_tables.sql`](./sql/create_tables.sql).

Data was bulk imported using a Python script with `pandas` and `SQLAlchemy`.

## 🔍 SQL Analysis

Exploratory SQL queries include:
- Average time spent by membership level
- Churn risk score by region
- Special discount usage by internet option
- Complaint resolution status by membership

See: [`sql/analysis_queries.sql`](./sql/analysis_queries.sql)

## 📊 Tableau Dashboard

View the interactive dashboard here:

👉 [Customer Churn Dashboard on Tableau Public](https://public.tableau.com/app/profile/noli.angeles/viz/Customer_Churn_Analysis_17528723047010/Dashboard1#1)

Dashboard visuals include:
- Churn Rate by Membership Type
- Discount Usage by Internet Option
- Complaint Status by Membership Group
- Churn Score by Region

## 🚀 How to Run

1. Load the database schema from `sql/create_tables.sql`
2. Import the `.csv` files into MySQL (manually or via script)
3. Run analysis queries from `sql/analysis_queries.sql`
4. Open the Tableau dashboard online or download `.twbx` to explore locally

---

Feel free to fork or clone for your own analysis!
