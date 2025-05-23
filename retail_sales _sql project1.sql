USE SQL_PROJECT;
create table retail_sales (transcation_id int PRIMARY KEY ,
sale_date date ,
sale_time time ,
customer_id int ,
gender varchar (20) ,
age int,
category varchar (20),
quantity int, 
price_per_unit int,
cogs int, 
total_sale int)
 ;
 SELECT * FROM retail_sales limit 20 ;
 set safe_sql_update=0;
 select count(*) from retail_sales;
	 select * from retail_sales where 
	 transcation_id is null 
	 or 
	 sale_date is null
	 or 
	 sale_time is null
	 or 
	 customer_id is null
	 or 
	 gender is null
	 or 
	 age is null
	 or 
	 category is null
	 or 
	 quantity is null
	 or 
	 price_per is null
	 or 
	 cogs is null
	 or 
	 total_sale is null;
 
 --- data cleaning ---
 delete from retail_sales where 
	 transcation_id is null 
	 or 
	 sale_date is null
	 or 
	 sale_time is null
	 or 
	 customer_id is null
	 or 
	 gender is null
	 or 
	 age is null
	 or 
	 category is null
	 or 
	 quantity is null
	 or 
	 price_per is null
	 or 
	 cogs is null
	 or 
	 total_sale is null;
     
     -- data exploration -- 
     -- how many sales we have ?  -- 
     select count(*) as total_sales from retail_sales;
     -- how many customers we have ? -- 
     select count(distinct customer_id) as total_customer from retail_sales;
     -- how many category we have -- 
     select distinct category from retail_sales;
     
     -- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales where sale_date = '2022-11-05';
 -- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022 --
 select * from retail_sales where category = "clothing" and sale_date between '2022-11-01' and '2022-11-30' order by sale_date and quantity >=4;
 -- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category,sum(total_sale) as sales_net, count(*) as total_orders  from retail_sales group by category; 
 -- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age),2) as Avg_age from retail_sales where category ="Beauty";
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select* from retail_sales where transcation_id > '1000'; 
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category ,gender, count(*) as total_sale from retail_sales group by category,gender order by category; 
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select years,months,average_sales from (
select year(sale_date) as years ,month(sale_date) as months,avg(total_sale) as average_sales,
 rank() over(partition by year(sale_date) 
order by avg(total_sale)  desc) as rnk from retail_sales group by years,months
) as T1 where rnk = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
 select customer_id, sum(total_sale) as total_sales from retail_sales group by 1 order by 2 desc limit 5 ;
 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category, count(distinct customer_id) as unique_customer from retail_sales group by category ; 

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with Hourly_sale as 
(
select *,
 case when extract(hour from sale_time) < 12 then 'Morning'
  when extract(hour  from sale_time) between 12 and 17 then 'Afternoon'
 else 'Evening'
 end as Shift 
 from retail_sales 
 ) select Shift , count(*)as total_orders
 from Hourly_sale group by shift ;
 
