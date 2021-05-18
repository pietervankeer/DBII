
-- 1. Give the unique names of all products containing the word 'helmet' or with a name of 6 characters.
SELECT DISTINCT ProductName, len(productname) Naamlengte
FROM Product
WHERE ProductName LIKE '%helmet%' OR LEN(productname) = 6

-- 2. Show the name and the reorderlevel of all products with a level between 50 and 500 (boundaries included)
SELECT ProductName, ReorderLevel
FROM Product
where ReorderLevel BETWEEN 50 and 500

-- 3. Count the amount of products, give the column the following name "Amount of Products". In a second column, count the amount of products where the unit in stock is known. Give the second column a descriptive column name.
SELECT COUNT(ProductID) as "Amount of Products", COUNT(UnitsInStock) as "Amount of unique products in stock"
FROM Product

-- 4. How many unique supervisors are there?
SELECT COUNT(supervisorID) as 'Amount of supervisors'
FROM Employee

-- 5. Give the date of birth of the youngest employee and the oldest
SELECT MIN(birthdate) as "oudste werknemer", MAX(birthdate) as "jongste werknemer" 
FROM Employee

-- 6.What’s the number of employees who will retire (at 65) within the first 30 years?
SELECT COUNT(employeeId) as "amount retired within 30 years"
FROM Employee
WHERE YEAR(BirthDate) + 30 >= 65

-- 7. Show a list of different countries where 2 of more suppliers live in, make sure to order alphabeticaly.
SELECT Country, COUNT(supplierID) as 'aantal suppliers'
FROM Supplier
group by Country
having COUNT(supplierID) >= 2
order by Country asc


-- 8. Which suppliers offer at least 10 products with a price less then 100 dollar? 
-- Show supplierId and the number of different products. 
-- The supplier with the highest number of products comes first.
SELECT distinct SupplierID, count(*)
FROM Product 
WHERE Price < 100
group by SupplierID
having COUNT(*) >= 10
order by SupplierID desc

-- 9. Count the number of workers (salary below 40.000), clerks (salary between 40.000 and 50.000 EUR) and managers (salary > 50000). 
-- Show 2 columns the name of the role and the amount of people in that role.
select distinct
case
	when salary < 40000 then 'Worker'
	when salary >= 40000 and salary <= 50000 then 'Clerk'
	else 'Manager'
end as "functie",
count(*) as "aantal werknemers in categorie"
from Employee
group by case
	when salary < 40000 then 'Worker'
	when salary >= 40000 and salary <= 50000 then 'Clerk'
	else 'Manager'
end