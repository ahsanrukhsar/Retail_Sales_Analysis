--Data Cleaning

select * from Retail_Sales
where transactions_id is null
or
sale_date is null
or
sale_time is null
or
category is null
or
cogs is null
or
total_sale is null

DELETE FROM Retail_Sales 
where
transactions_id is null
or
sale_date is null
or
sale_time is null
or
category is null
or
cogs is null
or
total_sale is null

--Data Exploration
SELECT COUNT(*) AS total_sales FROM Retail_Sales

--How many customers we have
select count(customer_id)
from Retail_Sales

SELECT DISTINCT category
from Retail_Sales


--Write SQL Query to retrieve all columns for sales made on 2022-11-05

SELECT *
FROM Retail_Sales
where sale_date = '2022-11-05'

--Retrieve all transactions where the category is 'Clothing'
--and the quantity sold is more than 10 in the moonth of Nov 2022

SELECT*
FROM Retail_Sales
WHERE category = 'Clothing'
AND CONVERT(VARCHAR(7), sale_date, 120) = '2022-11'
AND quantiy >= 4

--Write a query to calculate the total sales for each category

SELECT category, sum(total_sale) as net_sale, count(*) as total_order
FROM Retail_Sales
group by category

--Find average age of customers who purchased items from the 'Beauty' categoty

SELECT category,
avg(age)
from Retail_Sales
where category = 'Beauty'
group by category

--all transactions where the total_sale is greater than 1000
Select * from Retail_Sales
where total_sale>1000

--total number of transactions made by each gender in each category

SELECT
category, gender, count(*) as total_transaction
from Retail_Sales
GROUP BY category,gender

--the average sale for each month, find out the best selling year in ech month

select* from(SELECT
year(sale_date) as YearSale, month(sale_date) as MonthSale,
avg(total_sale) as avg_sale,
RANK() OVER(PARTITION BY year(sale_date) ORDER BY AVG(total_sale) desc) as rank
FROM Retail_Sales
GROUP BY year(sale_date),month(sale_date))
 as t1
where rank = 1


--Top 5 Customers based on the highest total sales
select  top 5
customer_id,
sum(total_sale) as SumTotalSale
from Retail_Sales
GROUP BY customer_id
order by  SumTotalSale desc

--number of unique customers who purchased items from each category
select
category,
count(distinct (customer_id)) as unique_customers
from Retail_Sales


--create each shift and number of orders (Example: Morning<=12, Afternoon b/w 12 & 17, Evening > 17)

With hourly_sales
as
(SELECT*,
CASE
     WHEN DATEPART(HOUR, sale_time)<12 then 'Morning'
	 WHEN DATEPART(HOUR, sale_time) between 12 and 17 then 'Afternoon'
	 ELSE 'Evening'
	END AS SHIFT
FROM Retail_Sales)
SELECT shift,
COUNT(*) as total_orders
from hourly_sales
group by shift












