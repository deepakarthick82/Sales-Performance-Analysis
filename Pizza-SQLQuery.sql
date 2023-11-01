SELECT TOP (1000) [pizza_id]
      ,[order_id]
      ,[pizza_name_id]
      ,[quantity]
      ,[order_date]
      ,[order_time]
      ,[unit_price]
      ,[total_price]
      ,[pizza_size]
      ,[pizza_category]
      ,[pizza_ingredients]
      ,[pizza_name]
  FROM [pizza1].[dbo].[pizza_sales]


    --Total Revenue
SELECT ROUND(SUM(total_price),2) as total_revenue
FROM [pizza1].[dbo].[pizza_sales]


    ---Average Order value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM pizza_sales


  --Total Pizzas sold

SELECT COUNT(quantity) as total_Pizza_sold
FROM [Pizza1].[dbo].[pizza_sales]

   
---Average pizza per order
SELECT AVG(pizzas_sold) as avg_pizza_per_order
FROM (
    SELECT order_id, COUNT(pizza_id) as pizzas_sold
    FROM [Pizza1].[dbo].[pizza_sales]
    GROUP BY order_id
   )
AS subquery

---
SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)


--Hourly trends

SELECT DATEPART(HOUR, order_time) as order_hours, COUNT(DISTINCT order_id) as total_orders
from pizza_sales
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)



--- Percentage of Pizza sale by category

 
SELECT pizza_category, SUM(total_price) AS total_sales ,
       ROUND((SUM(total_price)/(SELECT SUM(total_price) FROM pizza_sales)) * 100,2) AS percentage_of_sales
FROM  pizza_sales
GROUP BY pizza_category
ORDER BY pizza_category


--- Percentage of Pizza sale by SIZE

SELECT pizza_size, SUM(total_price) AS total_sales ,
       ROUND((SUM(total_price)/(SELECT SUM(total_price) FROM pizza_sales)) * 100,2) AS percentage_of_sales
FROM  pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size

	

--Pizza sold by pizza category. 
SELECT pizza_category, ROUND(SUM(total_price),2) AS total_sales 
FROM  pizza_sales
GROUP BY pizza_category
ORDER BY pizza_category



--- Top 5 best sellers by total pizza sold. 


	 SELECT TOP 5
	 pizza_name, COUNT(quantity) AS total_sales
	 FROM pizza_sales
	 GROUP BY pizza_name
	 ORDER BY total_sales DESC


	
--Bottom 5 worst sellers by total pizza sold. 


	 SELECT TOP 5
	 pizza_name, COUNT(quantity) AS total_sales
	 FROM pizza_sales
	 GROUP BY pizza_name
	 ORDER BY total_sales ASC

--List of Pizza category
SELECT DISTINCT(pizza_category)
FROM pizza_sales


-- List of pizza name
SELECT DISTINCT(pizza_name)
FROM pizza_sales
