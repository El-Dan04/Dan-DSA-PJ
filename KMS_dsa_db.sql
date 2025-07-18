Create Database KMS_DB

-----DSA Project -----
----- Kultra Mega Stores Inventory-----
------ Case Scenario I ------

Select * From KMS

---- 1. Which product category had the highest sales?

Select Top 1
	Product_Category, 
	sum(Sales) as Total_sales from KMS 

group by product_Category
order by Total_sales DESC;

------ 2. Top 3 and Bottom 3 regions in terms of sales?

---- top
 Select top 3 
	Region, sum(sales) as Total_Sales From KMS 
group by Region 
order by Total_Sales Desc;

-----bottom
 Select top 3 
	Region, sum(sales) as Total_Sales From KMS 
group by Region 
order by Total_Sales ASc;

-------------------------------------
select * from kms	
----- 3. Total sales of appliances in Ontario
select  sum(sales) as Ontario_Appliance_Sales from KMS
where Product_Sub_Category = 'Appliances' and region = 'Ontario'

------4. Advice for improving revenue from the bottom 10 customers
select * from kms	

SELECT TOP 10 
	Order_ID, Customer_Name, SUM(Sales) AS Total_Sales
	FROM kms
GROUP BY Order_ID, Customer_Name
ORDER BY Total_Sales ASC

---- Advise 
----Offer targeted discounts and bundle deals.
----Re-engage them through feedback or loyalty programs.
---Provide better post-purchase experience.

---- 5. Shipping method with the highest total cost

SELECT top 1
	Ship_Mode, SUM(Shipping_Cost) AS Total_Shipping_Cost
FROM kms
GROUP BY Ship_Mode
ORDER BY Total_Shipping_Cost DESC;

------------------ Case Scenario II ---------------
------ Most valuable customers & what they purchase

-- Top customers
SELECT TOP 5 
	Order_ID, Customer_Name, SUM(Sales) AS Total_Sales
	FROM kms
GROUP BY Order_ID, Customer_Name
ORDER BY Total_Sales desc;

select * from kms

-- Their frequent purchases
SELECT Customer_Name, Product_Name, COUNT(*) AS TimesBought
FROM kms
WHERE Customer_Name IN (
    SELECT Customer_Name
    FROM (
        SELECT Top 5
		Customer_Name, SUM(Sales) AS TotalSales
        FROM  kms
        GROUP BY Customer_Name
        ORDER BY TotalSales DESC
    ) AS TopCustomers
)
GROUP BY Customer_Name, Product_Name
ORDER BY Customer_Name;


------ 7. Top small business customer by sales 

SELECT top 5 order_ID, Customer_Name, SUM(Sales) AS TotalSales
FROM kms
WHERE Customer_Segment = 'Small Business'
GROUP BY Order_ID, Customer_Name
ORDER BY TotalSales DESC;

------8. Corporate customer with most orders from 2009 to 2012

SELECT top 5 order_ID, Customer_Name, COUNT(Order_ID) AS Total_Orders
FROM kms
WHERE Customer_Segment = 'Corporate'
  AND datepart(year, Order_Date) BETWEEN '2009' AND '2012'
GROUP BY order_ID, Customer_Name
ORDER BY Total_Orders DESC;

------- 9. Most profitable consumer customer 

SELECT top 1 order_ID, Customer_Name, SUM(Profit) AS Total_Profit
FROM kms
WHERE Customer_Segment = 'Consumer'
GROUP BY order_ID, Customer_Name
ORDER BY Total_Profit DESC;

---------- 10. Customers who returned items and their segment
SELECT DISTINCT Customer_Name, Customer_Segment,
FROM kms

------ 11. If the delivery truck is the most economical but the slowest shipping method and Express Air
-- is the fastest but the most expensive one, do you think the company appropriately
--spent shipping costs based on the Order Priority? Explain your answer.

SELECT Order_Priority, Ship_Mode,
       COUNT(Order_ID) AS Total_Orders,
       SUM(Shipping_Cost) AS Total_Shipping_Cost,
       AVG(Shipping_Cost) AS Avg_Shipping_Cost
FROM kms
GROUP BY Order_Priority, Ship_Mode
ORDER BY Order_Priority, Total_Shipping_Cost DESC;

------------------ ADVISE--------
----------- Interpretation Strategy:
----High Priority + Express Air → expected.
----Low Priority + Delivery Truck → cost-effective.
----If high shipping costs appear under “Low” priority or Delivery Truck is rarely used → flag inefficiencies.



