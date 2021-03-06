
-- 1. Rewrite the following query using a common table expressions.
-- https://i.imgur.com/AFKy9Vc.png
WITH
Ordered(Month,amount) as
(
SELECT 
 FORMAT(OrderDate, 'yyyy-MM')
,SUM(OrderAmount)
FROM Orders
GROUP BY FORMAT(OrderDate, 'yyyy-MM')
),
Purchased(Month, Amount) as
(
SELECT 
 FORMAT(OrderDate, 'yyyy-MM')
,SUM(Product.Price * Purchase.UnitsOnOrder)
FROM Purchases AS Purchase
    JOIN Product ON Purchase.ProductId = Product.ProductId
GROUP BY FORMAT(OrderDate, 'yyyy-MM')
) 

SELECT 
 ISNULL(Ordered.Month, Purchased.Month) AS [Month]
,ISNULL(Ordered.Amount, 0) - ISNULL(Purchased.Amount, 0) AS [Margin]
FROM
 Ordered
FULL JOIN
Purchased ON Ordered.Month = Purchased.Month
ORDER BY [Month];

-- 2. Make a histogram of the number of orders per customer (not the Excel equivalent shown below but as raw data in rows and columns). 
-- Show how many times each number occurs. E.g. in the graph below: 190 customers placed 1 order, 1 customer placed 2 orders, 1 customer placed 14 orders, etc.
with OrdersPerCustomer(amount) as
(
select count(*) as 'Amount'
from Orders
group by CustomerID
)

select Amount, count(*) as 'Aantal Customers'
from OrdersPerCustomer
group by amount
order by amount

-- 3. Show all parts that are directly or indirectly part of O2, so all parts of which O2 is composed. Use the new Parts table you added in the Getting Started section.
WITH Relation(Super,Sub) as
(
select super, sub 
from parts
where super = 'O2'

union all

select Parts.Super, Parts.Sub
from Parts
	join Relation on Parts.Super = Relation.Sub
)
select * from Relation


-- 4. Add an extra column to the last query with the Path as shown below:

WITH Relation(Super,Sub) as
(
select super, sub,     ,[Path] =  CAST(CONCAT(Super, ' <- ',Sub) AS NVARCHAR(MAX))
from parts
where super = 'O2'

union all

select Parts.Super, Parts.Sub
from Parts
	join Relation on Parts.Super = Relation.Sub
)
select * from Relation