CREATE DATABASE WALMART_SALES;
USE WALMART_SALES;
DROP TABLE IF EXISTS WALMART_SALES;


CREATE TABLE IF EXISTS WALMART_SALES (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct DECIMAL(6,4) NOT NULL,
    total DECIMAL(12,4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct DECIMAL(11,9),
    gross_income DECIMAL(12,4),
    rating DECIMAL(2,1)
);

DROP TABLE IF EXISTS WALMART_SALES;

CREATE TABLE WALMART_SALES (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct DECIMAL(6,4) NOT NULL,
    total DECIMAL(12,4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct DECIMAL(11,9),
    gross_income DECIMAL(12,4),
    rating DECIMAL(2,1)
);

-- Data cleaning
SELECT
	*
FROM WALMART_SALES;


-- Add the time_of_day column

SELECT
TIME FROM 
WALMART_SALES;

SELECT 
  TIME,
  CASE 
    WHEN TIME BETWEEN '00:00:00' AND '12:00:00' THEN 'MORNING'
    WHEN TIME BETWEEN '12:01:00' AND '16:00:00' THEN 'AFTERNOON'
    ELSE 'EVENING'
  END AS TIME_OF_DAY
FROM walmart_sales.walmart_sales;


DESCRIBE WALMART_SALES;
ALTER TABLE WALMART_SALES DROP COLUMN time_of_day;
ALTER TABLE WALMART_SALES ADD COLUMN time_of_day VARCHAR(20);


SET SQL_SAFE_UPDATES = 0;


-- Add day_name column

SELECT
    date
FROM WALMART_SALES;

SELECT
	date,
	DAYNAME(date)
FROM WALMART_SALES;

SELECT
	date,
	DAYNAME(date) AS DAY_NAME
FROM WALMART_SALES;

ALTER TABLE WALMART_SALES ADD COLUMN day_name VARCHAR(10);


UPDATE WALMART_SALES
SET day_name = DAYNAME(date);


-- Add month_name column
SELECT
	date,
	MONTHNAME(date)
FROM WALMART_SALES;

ALTER TABLE WALMART_SALES ADD COLUMN month_name VARCHAR(10);

UPDATE WALMART_SALES
SET month_name = MONTHNAME(date);

-- --------------------------------------------------------------------
-- ---------------------------- Generic ------------------------------
-- --------------------------------------------------------------------
-- How many unique cities does the data have?
SELECT 
	DISTINCT city
FROM WALMART_SALES;

SELECT 
	DISTINCT BRANCH
FROM WALMART_SALES;

-- In which city is each branch?
SELECT 
	DISTINCT city,
    branch
FROM WALMART_SALES;

-- --------------------------------------------------------------------
-- ---------------------------- Product -------------------------------
-- --------------------------------------------------------------------

-- How many unique product lines does the data have?
SELECT
	DISTINCT product_line
FROM WALMART_SALES;

SELECT
	COUNT(DISTINCT product_line)
FROM WALMART_SALES;

-- What is the most common payment method ?
SELECT 
*
FROM WALMART_SALES;

SELECT 
PAYMENT METHOD
FROM WALMART_SALES;

SELECT COUNT(PAYMENT)
FROM WALMART_SALES;

SELECT PAYMENT, COUNT(PAYMENT) AS CNT
FROM WALMART_SALES
GROUP BY PAYMENT
ORDER BY cnt DESC;


-- What is the most selling product line
SELECT
    product_line,
	COUNT(product_line) as CNT,
    product_line
FROM WALMART_SALES
GROUP BY product_line
ORDER BY CNT DESC;

-- What is the total revenue by month

SELECT
	month_name AS month
    FROM WALMART_SALES;
    
SELECT
	month_name AS month,
	SUM(total) AS total_revenue
FROM WALMART_SALES
GROUP BY month_name 
ORDER BY total_revenue;


-- What month had the largest COGS?
SELECT
	month_name AS month,
	SUM(cogs) AS cogs
FROM WALMART_SALES
GROUP BY month_name 
ORDER BY cogs DESC;


-- What product line had the largest revenue?
SELECT
	product_line,
	SUM(total) as total_revenue
FROM WALMART_SALES
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?
SELECT
	branch,
	city,
	SUM(total) AS total_revenue
FROM WALMART_SALES
GROUP BY city, branch 
ORDER BY total_revenue DESC;


-- What product line had the largest VAT?
SELECT
	product_line,
	AVG(tax_pct) as avg_tax
FROM WALMART_SALES
GROUP BY product_line
ORDER BY avg_tax DESC;


-- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales

SELECT 
	AVG(quantity) AS avg_qnty
FROM WALMART_SALES;

SELECT
	product_line,
	CASE
		WHEN AVG(quantity) > 6 THEN "Good"
        ELSE "Bad"
    END AS remark
FROM WALMART_SALES
GROUP BY product_line;


-- Which branch sold more products than average product sold?
SELECT 
	branch, 
    SUM(quantity) AS qnty
FROM WALMART_SALES
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM WALMART_SALES);


-- What is the most common product line by gender
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM WALMART_SALES
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- What is the average rating of each product line

SELECT
	AVG(rating) as avg_rating,
    product_line
FROM WALMART_SALES
GROUP BY product_line
ORDER BY avg_rating DESC;

SELECT
	ROUND(AVG(rating), 2) as avg_rating,
    product_line
FROM WALMART_SALES
GROUP BY product_line
ORDER BY avg_rating DESC;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------

-- Number of sales made in each time of the day per weekday 

SELECT
  *
FROM WALMART_SALES;



SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM WALMART_SALES
GROUP BY time_of_day;

SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM WALMART_SALES
WHERE day_name = "Sunday"
GROUP BY time_of_day 
ORDER BY total_sales DESC;


-- Evenings experience most sales, the stores are 
-- filled during the evening hours.

-- Which of the customer types brings the most revenue?

SELECT
	customer_type
FROM WALMART_SALES;

SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM WALMART_SALES
GROUP BY customer_type
ORDER BY total_revenue;

-- Which city has the largest tax/VAT percent?
SELECT
	city,
    ROUND(AVG(tax_pct), 2) AS avg_tax_pct
FROM WALMART_SALES
GROUP BY city 
ORDER BY avg_tax_pct DESC;

-- Which customer type pays the most in VAT?
SELECT
	customer_type,
	AVG(tax_pct) AS total_tax
FROM WALMART_SALES
GROUP BY customer_type
ORDER BY total_tax DESC;

-- --------------------------------------------------------------------
-- -------------------------- Customers -------------------------------
-- --------------------------------------------------------------------

-- How many unique customer types does the data have?
SELECT
	DISTINCT customer_type
FROM WALMART_SALES;

-- How many unique payment methods does the data have?
SELECT
	DISTINCT payment
FROM WALMART_SALES;


-- What is the most common customer type?
SELECT
	customer_type,
	count(*) as count
FROM  WALMART_SALES
GROUP BY customer_type
ORDER BY count DESC;

-- Which customer type buys the most?
SELECT
	customer_type,
    COUNT(*)
FROM  WALMART_SALES
GROUP BY customer_type;


-- What is the gender of most of the customers?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM  WALMART_SALES
GROUP BY gender
ORDER BY gender_cnt DESC;

-- What is the gender distribution per branch?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM WALMART_SALES
WHERE branch = "C"
GROUP BY gender
ORDER BY gender_cnt DESC;

-- Gender per branch is more or less the same hence, I don't think has
-- an effect of the sales per branch and other factors.

-- Which time of the day do customers give most ratings?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM WALMART_SALES
GROUP BY time_of_day
ORDER BY avg_rating DESC;


-- Looks like time of the day does not really affect the rating, its
-- more or less the same rating each time of the day.alter


-- Which time of the day do customers give most ratings per branch?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM WALMART_SALES
WHERE branch = "C"
GROUP BY time_of_day
ORDER BY avg_rating DESC;

SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM WALMART_SALES
WHERE branch = "B"
GROUP BY time_of_day
ORDER BY avg_rating DESC;

SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM WALMART_SALES
WHERE branch = "A"
GROUP BY time_of_day
ORDER BY avg_rating DESC;


-- Branch A and C are doing well in ratings, branch B needs to do a 
-- little more to get better ratings.


-- Which day fo the week has the best avg ratings?
SELECT
	day_name,
	AVG(rating) AS avg_rating
FROM WALMART_SALES
GROUP BY day_name 
ORDER BY avg_rating DESC;


-- Mon, Tue and Friday are the top best days for good ratings
-- why is that the case, how many sales are made on these days?


-- Which day of the week has the best average ratings per branch?
SELECT 
	day_name,
	COUNT(day_name) total_sales
FROM WALMART_SALES
WHERE branch = "C"
GROUP BY day_name
ORDER BY total_sales DESC;


-- --------------------------------------------------------------------
-- --------------------------------------------------------------------


-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

