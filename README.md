

# Retail Sales Data Analysis

## Overview

This project involves performing various data cleaning, exploration, and analysis tasks on a retail sales dataset.
The SQL queries provided are designed to clean the dataset, explore its contents, and extract valuable insights about 
sales performance, customer behavior, and other key metrics.

## Project Structure

The SQL scripts in this project are organized into the following sections:

1. **Data Cleaning**
2. **Data Exploration**
3. **Data Analysis**

### 1. Data Cleaning

The data cleaning section focuses on identifying and removing any incomplete or null records from the dataset to ensure data quality.
The following SQL queries are included:

- **Identify Null Records**: 
  ```sql
  SELECT * FROM Retail_Sales
  WHERE transactions_id IS NULL
  OR sale_date IS NULL
  OR sale_time IS NULL
  OR category IS NULL
  OR cogs IS NULL
  OR total_sale IS NULL;
  ```

- **Delete Null Records**:
  ```sql
  DELETE FROM Retail_Sales
  WHERE transactions_id IS NULL
  OR sale_date IS NULL
  OR sale_time IS NULL
  OR category IS NULL
  OR cogs IS NULL
  OR total_sale IS NULL;
  ```

### 2. Data Exploration

This section includes queries to explore the dataset and understand its contents:

- **Total Sales**:
  ```sql
  SELECT COUNT(*) AS total_sales FROM Retail_Sales;
  ```

- **Number of Customers**:
  ```sql
  SELECT COUNT(DISTINCT customer_id) FROM Retail_Sales;
  ```

- **Distinct Categories**:
  ```sql
  SELECT DISTINCT category FROM Retail_Sales;
  ```

- **Sales on a Specific Date**:
  ```sql
  SELECT * FROM Retail_Sales WHERE sale_date = '2022-11-05';
  ```

- **Transactions in a Specific Category and Date Range**:
  ```sql
  SELECT * FROM Retail_Sales
  WHERE category = 'Clothing'
  AND CONVERT(VARCHAR(7), sale_date, 120) = '2022-11'
  AND quantity >= 4;
  ```

### 3. Data Analysis

This section focuses on deriving insights from the data:

- **Total Sales by Category**:
  ```sql
  SELECT category, SUM(total_sale) AS net_sale, COUNT(*) AS total_order
  FROM Retail_Sales
  GROUP BY category;
  ```

- **Average Age of Customers in a Category**:
  ```sql
  SELECT category, AVG(age)
  FROM Retail_Sales
  WHERE category = 'Beauty'
  GROUP BY category;
  ```

- **Transactions with High Sales**:
  ```sql
  SELECT * FROM Retail_Sales WHERE total_sale > 1000;
  ```

- **Transactions by Gender and Category**:
  ```sql
  SELECT category, gender, COUNT(*) AS total_transaction
  FROM Retail_Sales
  GROUP BY category, gender;
  ```

- **Average Sales and Best-Selling Year**:
  ```sql
  SELECT *
  FROM (
      SELECT YEAR(sale_date) AS YearSale, MONTH(sale_date) AS MonthSale,
             AVG(total_sale) AS avg_sale,
             RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank
      FROM Retail_Sales
      GROUP BY YEAR(sale_date), MONTH(sale_date)
  ) AS t1
  WHERE rank = 1;
  ```

- **Top 5 Customers**:
  ```sql
  SELECT TOP 5 customer_id, SUM(total_sale) AS SumTotalSale
  FROM Retail_Sales
  GROUP BY customer_id
  ORDER BY SumTotalSale DESC;
  ```

- **Unique Customers per Category**:
  ```sql
  SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
  FROM Retail_Sales
  GROUP BY category;
  ```

- **Orders by Shift**:
  ```sql
  WITH hourly_sales AS (
      SELECT *,
             CASE
                 WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
                 WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
                 ELSE 'Evening'
             END AS SHIFT
      FROM Retail_Sales
  )
  SELECT SHIFT, COUNT(*) AS total_orders
  FROM hourly_sales
  GROUP BY SHIFT;
  ```

## Usage

To use these SQL queries:

1. Ensure you have access to the `Retail_Sales` database.
2. Execute the queries in a SQL Server environment.
3. The queries can be run individually depending on the task you want to perform (e.g., data cleaning, exploration, or analysis).

## Contributing

If you find any issues or have suggestions for improvements, feel free to fork the repository and submit a pull request. Contributions are welcome!

