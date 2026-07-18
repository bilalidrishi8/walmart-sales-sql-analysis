
-- Create table -- 

CREATE TABLE walmart_sales (
    invoice_id VARCHAR(30) PRIMARY KEY,
    branch CHAR(1),
    city VARCHAR(50),
    customer_type VARCHAR(30),
    gender VARCHAR(10),
    product_line VARCHAR(100),
    unit_price DECIMAL(10,2),
    quantity INT,
    tax_5_percent DECIMAL(10,4),
    total DECIMAL(10,2),
    sale_date DATE,
    sale_time TIME,
    payment VARCHAR(30),
    cogs DECIMAL(10,2),
    gross_margin_percentage DECIMAL(10,9),
    gross_income DECIMAL(10,4),
    rating DECIMAL(3,1)
);

-- Data cleaning --

SELECT * FROM walmart_sales


-- 1 Add the time_of_day column

UPDATE walmart_sales
SET time_of_day =
CASE
    WHEN sale_time BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
    WHEN sale_time BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
    ELSE 'Evening'
END;

ALTER TABLE walmart_sales
ADD COLUMN time_of_day VARCHAR(20);

-- 2 In which city is each branch?
SELECT * from walmart_sales

SELECT 
	DISTINCT city,
    branch
FROM walmart_sales

-- 3 What is the most selling product line
SELECT * from walmart_sales

SELECT
	SUM(quantity) as qty,
    product_line
FROM walmart_sales
GROUP BY product_line
ORDER BY qty DESC;

-- 4 What month had the largest COGS?
SELECT * from walmart_sales

SELECT
    TO_CHAR(sale_date, 'Month') AS month_name,
    SUM(cogs) AS total_cogs
FROM walmart_sales
GROUP BY TO_CHAR(sale_date, 'Month')
ORDER BY total_cogs DESC

-- 5 What product line had the largest revenue?
SELECT * from walmart_sales

SELECT
	product_line,
	SUM(total) as total_revenue
FROM walmart_sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- 6 What is the city with the largest revenue?
SELECT * from walmart_sales

SELECT
	branch,
	city,
	SUM(total) AS total_revenue
FROM  walmart_sales
GROUP BY city, branch 
ORDER BY total_revenue;


-- 7 What product line had the largest VAT?
SELECT * from walmart_sales

SELECT
	product_line,
	AVG(tax_5_percent) as avg_tax
FROM walmart_sales
GROUP BY product_line
ORDER BY avg_tax DESC;


-- 8 Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
SELECT * from walmart_sales

SELECT
    product_line,
    ROUND(AVG(total), 2) AS avg_sales,
    CASE
        WHEN AVG(total) > (SELECT AVG(total) FROM walmart_sales)
        THEN 'Good'
        ELSE 'Bad'
    END AS performance
FROM walmart_sales
GROUP BY product_line
ORDER BY avg_sales DESC;

-- 9 Which branch sold more products than average product sold?
SELECT * from walmart_sales

SELECT 
	branch, 
    SUM(quantity) AS qnty
FROM walmart_sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM walmart_sales);


-- 10 What is the most common product line by gender
SELECT * from walmart_sales

SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM walmart_sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- 11 What is the average rating of each product line
SELECT * from walmart_sales

SELECT
	ROUND(AVG(rating), 2) as avg_rating,
    product_line
FROM walmart_sales
GROUP BY product_line
ORDER BY avg_rating DESC;


-- 12 How many unique customer types does the data have?
SELECT * from walmart_sales

SELECT
	DISTINCT customer_type
FROM sales;

-- 13 How many unique payment methods does the data have?
SELECT * from walmart_sales

SELECT
	 DISTINCT payment
FROM walmart_sales;


-- 14 What is the most common customer type?
SELECT * from walmart_sales

SELECT
	customer_type,
	count(*) as count
FROM walmart_sales
GROUP BY customer_type
ORDER BY count DESC;

-- 15 Which customer type buys the most?
SELECT * from walmart_sales

SELECT
	customer_type,
    COUNT(*)
FROM walmart_sales
GROUP BY customer_type;


-- 16 What is the gender of most of the customers?
SELECT * from walmart_sales

SELECT
	gender,
	COUNT(*) as gender_cnt
FROM walmart_sales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- 17 What is the gender distribution per branch?
SELECT * from walmart_sales

SELECT
	gender,
	COUNT(*) as gender_cnt
FROM walmart_sales
WHERE branch = 'C'
GROUP BY gender
ORDER BY gender_cnt DESC;


-- 18 Which time of the day do customers give most ratings?
SELECT * from walmart_sales

SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM walmart_sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;


-- 19 Which time of the day do customers give most ratings per branch?
SELECT * from walmart_sales

SELECT branch,
	time_of_day,
	AVG(rating) AS avg_rating
FROM walmart_sales
WHERE branch = 'A'
GROUP BY branch, time_of_day
ORDER BY avg_rating DESC;

-- 20 Which day fo the week has the best avg ratings?
SELECT * from walmart_sales

SELECT
	rating,
	AVG(rating) AS avg_rating
FROM walmart_sales
GROUP BY rating
ORDER BY avg_rating DESC;

-- ADD branch ALSO --

SELECT
    branch,
	rating,
	AVG(rating) AS avg_rating
FROM walmart_sales
GROUP BY branch, rating
ORDER BY avg_rating DESC;


-- 21 Which day of the week has the best average ratings per branch?
SELECT * from walmart_sales

SELECT 
	branch,
	COUNT(branch) total_sales
FROM walmart_sales
WHERE branch = 'C'
GROUP BY branch
ORDER BY total_sales DESC;


-- 22 Number of sales made in each time of the day per weekday 
SELECT * from walmart_sales

SELECT
    time_of_day,
    COUNT(*) AS total_sales
FROM walmart_sales
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- 23 Which of the customer types brings the most revenue?
SELECT * from walmart_sales

SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM walmart_sales
GROUP BY customer_type
ORDER BY total_revenue;

-- 24 Which city has the largest tax/VAT percent?
SELECT * from walmart_sales

SELECT
    city,
    MAX(tax_5_percent) AS highest_tax
FROM walmart_sales
GROUP BY city
ORDER BY highest_tax DESC
LIMIT 1;

 
-- 25 Which customer type pays the most in VAT?
SELECT * from walmart_sales

SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'walmart_sales';

-- END THE PROJECT ---
