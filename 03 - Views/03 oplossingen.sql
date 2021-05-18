
--  EXERCISE 1
-- The company wants to weekly check the stock of their products, if the stock is below 15, they'd like to order more to fulfill the need.
-- 1. Create a QUERY that shows the ProductId, ProductName and the name of the supplier, do not forget the WHERE clause.
select ProductID as 'ID', ProductName as 'Name', SupplierName as 'Supplier'
from Product p
join Supplier s on p.SupplierID = s.SupplierID
where UnitsInStock < 15

-- 2. Turn this SELECT statement into a VIEW called: vw_products_to_order. 
DROP VIEW IF EXISTS vw_products_to_order
GO -- See Deep Dive

CREATE VIEW vw_products_to_order AS
select 
	Product.ProductID as 'ID',.
	Product.ProductName as 'Name',
	Supplier.SupplierName as 'Supplier'
from Product
	join Supplier on Product.SupplierID = Supplier.SupplierID
where UnitsInStock < 15

GO
-- 3. Query the VIEW to see the results.
select * from vw_products_to_order


--  EXERCISE 2
-- The Xtreme company has to increase prices of certain products. To make it seem the prices are not increasing dramatically they're planning to spread the price increase over multiple years. 
-- In total they'd like a 10% price for certain products. The list of impacted products can grow over the coming years. 
-- We'd like to keep all the logic of selecting the correct products in 1 SQL View, in programming terms 'keeping it DRY'. 
-- The updating of the items is not part of the view itself.

-- 1. Create a simple SQL Query to get the following resultset: The products in scope are all the products that start with the term 'Guardian' and 1 special product the one with the productId: '4101'.
select ProductID as 'ID', ProductName as 'Name', Price as 'Price'
from Product
where ProductName like 'Guardian%' or ProductID in ( 4101 )

-- 2. Turn this SELECT statement into a VIEW called: vw_price_increasing_products
DROP VIEW IF EXISTS vw_price_increasing_products
GO

Create view vw_price_increasing_products as
select ProductID as 'ID', ProductName as 'Name', Price as 'Price'
from Product
where ProductName like 'Guardian%' or ProductID in ( 4101 )

go
-- 3. Query the VIEW to see the results
select * from vw_price_increasing_products
-- 4. Increase the price of the resultset of the VIEW: vw_price_increasing_products by 2%
update vw_price_increasing_products
set Price = Price*1.02
-- 5. Query the VIEW to see the updated results. 
select * from vw_price_increasing_products