-- 1. Give the id and name of the products that have not been purchased yet.
select productID, ProductName
from Product
where ProductID not in (select distinct ProductID from Purchases)

-- 2. Select the names of the suppliers who supply products that have not been ordered yet.
select suppliername
from Supplier s
join Product p on p.SupplierID = s.SupplierID
where p.ProductID not in (select ProductID from OrdersDetail)

-- 3. Select the products (all columns) with a price that is higher than the average price of the "Bicycle" products. Order the results by descending order of the price.
select *
from Product
where Price > (
		select avg(price)
		from product p
		join ProductClass pc on p.ProductClassID = pc.ProductClassID
		where ProductClassName = 'Bicycle'
	)
order by Price desc

-- 4. Show a list of the orderID's of the orders for which the order amount differs from the amount calculated through the ordersdetail.
select OrderID 
from Orders
where OrderAmount <> (select sum(UnitPrice*Quantity) as "order amount" from OrdersDetail where OrderID = Orders.OrderID)



-- 5. Which employee has processed most orders? Show the fullname of the employee and the amount of order he/she processed.
select FirstName+ ' ' + LastName, 
	(
		select count(orderID)
		from Orders
		where EmployeeID = Employee.EmployeeID
	) as "aantal orders"
from Employee

-- 6. Give per employee and per orderdate the total order amount. 
-- Also add the name of the employee and the running total per employee when ordering by orderdate, an example can be seen below. 
-- Note that the running total is the sum of all orders where the employee is responsible at the order date's time. 
-- https://i.imgur.com/FJE3Ebw.png

select
	e.EmployeeID,
	e.LastName,
	e.FirstName,
	o.OrderDate,
	round(sum(OrderAmount),0) as 'SUM ($)',
	(
		select sum(OrderAmount)
		from orders
		where EmployeeID=e.EmployeeID and OrderDate <= o.OrderDate
	) as 'Running total ($)'
from Employee e
join Orders o on o.EmployeeID = e.EmployeeID
group by e.EmployeeID, e.LastName, e.FirstName, o.OrderDate
order by e.EmployeeID, o.OrderDate