# NOOR-Walmart_Sales-SQL-Project-1

📌 About
This SQL project explores Walmart Sales Data to uncover insights about top-performing branches and products, seasonal sales trends, and customer behavior.
The objective is to analyze real-world sales data and draw conclusions that could help optimize business strategies.

📊 Dataset Source: Kaggle - Walmart Sales Forecasting

“In this recruiting competition, participants are provided with historical sales data for 45 Walmart stores. The challenge is to forecast sales, accounting for variables such as holiday markdowns and regional factors.” – Kaggle

🎯 Objectives
Analyze performance of different branches and product lines

Study customer buying behavior and trends

Understand the impact of time, day, and month on sales

Use SQL to extract business insights and build a strong foundation in data analytics

📁 Dataset Overview
Column	Description	Data Type
invoice_id	Unique invoice ID	VARCHAR(30)
branch	Store branch	VARCHAR(5)
city	City of store	VARCHAR(30)
customer_type	Member or Normal	VARCHAR(30)
gender	Customer gender	VARCHAR(10)
product_line	Product category	VARCHAR(100)
unit_price	Price per unit	DECIMAL(10,2)
quantity	Units sold	INT
VAT	5% Tax on COGS	FLOAT(6,4)
total	COGS + VAT	DECIMAL(10,2)
date	Purchase date	DATE
time	Purchase time	TIME
payment_method	Payment type	VARCHAR(30)
cogs	Cost of Goods Sold	DECIMAL(10,2)
gross_margin_percentage	Profit margin %	FLOAT(11,9)
gross_income	VAT (assumed as gross profit)	DECIMAL(10,2)
rating	Customer rating	FLOAT(2,1)

🔍 Project Workflow
1. 🧹 Data Cleaning & Wrangling
Checked for null values (none found, as fields were set to NOT NULL).

Removed duplicates and cleaned formatting.

2. 🏗️ Database Design
Built the database and created the sales table using SQL.

Inserted and verified data integrity.

3. 🧠 Feature Engineering
time_of_day: Morning, Afternoon, Evening

day_name: Weekday name

month_name: Month name

These helped analyze peak hours, busiest days, and most profitable months.

4. 📊 Exploratory Data Analysis (EDA)
Conducted with SQL to answer key business questions and identify trends.

🧠 Business Questions Answered
🎁 Product Analysis
Most popular product lines

Highest-grossing products

Product performance by gender and rating

VAT and revenue contribution per product line

💵 Sales Analysis
Revenue trends by month and branch

Impact of day and time on sales

Branch and product sales comparison with averages

🧍 Customer Analysis
Who buys more: Members or Normal customers?

Which gender spends more?

Payment method trends

Customer segment profitability

🧮 Revenue and Profit Calculations
COGS = unit_price × quantity

VAT = 5% of COGS

total = COGS + VAT

gross_income = total – COGS

gross_margin = gross_income / total

Example (from Row 1):
Unit Price: 45.79

Quantity: 7

COGS: 45.79 × 7 = 320.53

VAT: 5% of COGS = 16.0265

Total: 320.53 + 16.0265 = 336.5565

Gross Margin % = 16.0265 / 336.5565 ≈ 4.76%
