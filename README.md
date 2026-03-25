# IENG-331-Project
# IENG 331 SQL Analytics Project

## Overview
This project analyzes e-commerce data using SQL to answer key business questions.  
Each query focuses on extracting insights from orders, customers, products, and sellers using joins, aggregations, and window functions.

The goal is to demonstrate the ability to:
- Write clear, structured SQL queries
- Perform multi-step analytical reasoning using CTEs
- Apply business concepts like retention, performance scoring, and Pareto analysis

---

## Dataset
The dataset includes:
- orders
- order_items
- customers
- products
- sellers

Only delivered orders were used where relevant to ensure accurate business insights.

---

## Analytical Queries

### 1. Cohort Retention Analysis
Identifies customer cohorts based on their first purchase date and measures retention at 30, 60, and 90 days.

**Key Concepts:**
- MIN() for first purchase
- Date calculations
- Cohort grouping
- Retention percentages

---

### 2. Seller Performance Score
Evaluates seller performance based on revenue and order volume.

**Key Concepts:**
- Aggregations (SUM, COUNT)
- Joins across multiple tables
- Ranking or scoring logic

---

### 3. ABC Inventory Classification
Classifies product categories into A, B, and C tiers using the Pareto principle:
- A: Top 80% of revenue
- B: Next 15%
- C: Remaining 5%

**Key Concepts:**
- Window functions
- Revenue percentages
- Running totals (cumulative %)
- CASE statements for classification

---

### 4. Delivery Time Analysis by Geography
Analyzes how delivery time varies across different regions.

**Key Concepts:**
- Date differences
- Grouping by location
- Average delivery time
