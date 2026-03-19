# 📊 Layoffs Data Analysis (SQL Project)

## 🔍 Project Overview
This project analyzes global layoffs data using SQL to uncover trends, patterns, and key business insights.  
The dataset was cleaned and transformed before performing exploratory data analysis (EDA).

---

## 📁 Dataset
The dataset contains:
- Company name
- Industry
- Location
- Date of layoffs
- Total employees laid off

---

## 🛠️ Tools & Technologies
- SQL Server (SSMS)
- Excel
- GitHub

---

## 🧹 Data Cleaning Process
- Removed duplicate records
- Handled NULL and blank values
- Standardized text fields (company, industry)
- Converted date columns into proper format
- Fixed inconsistent data entries

---

## 📊 Exploratory Data Analysis

### 🔹 Year-wise Layoffs Trend
- Identified peak layoff periods across years

### 🔹 Top Companies by Layoffs
- Used `DENSE_RANK()` to find top 5 companies per year

### 🔹 Rolling Layoffs Analysis
- Used window functions to calculate cumulative layoffs over time

### 🔹 Layoff Size Distribution
- Categorized layoffs into Small, Medium, Large using CASE statements

---

## 🔥 Key Insights
- Layoffs significantly increased during specific years (post-pandemic impact)
- A small number of companies contributed to a large portion of layoffs
- The tech industry experienced the highest layoffs
- Large-scale layoffs dominate overall trends

---

## 📌 SQL Concepts Used
- CTEs (Common Table Expressions)
- Window Functions (SUM, DENSE_RANK)
- Aggregations (GROUP BY)
- CASE Statements
- Data Cleaning Techniques

---

## 📂 Project Structure
- `data/` → Raw dataset  
- `sql/` → SQL scripts (data cleaning + EDA)  
- `outputs/` → Query result screenshots  

---

## 🚀 Conclusion
This project demonstrates SQL skills in data cleaning, transformation, and analytical thinking to derive meaningful business insights.

---

## 👤 Author
**Abhishek Chatterjee**
