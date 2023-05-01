



USE WideWorldImporters


select * from Sales.Orders

select * from Purchasing.PurchaseOrderLines
where Description like 'Pack%'
order by ExpectedUnitPricePerOuter desc


select Description, count(Description) as Precio
from Purchasing.PurchaseOrderLines
group by Description
order by precio desc


select * from sales.InvoiceLines
where UnitPrice > 100 and UnitPrice < 200 AND LastEditedWhen > '20150101'
order by UnitPrice desc

select * from Purchasing.PurchaseOrders 
	where ExpectedDeliveryDate > '20150101'


select ExpectedDeliveryDate, count(ExpectedDeliveryDate) as Quantity
from Purchasing.PurchaseOrders
group by ExpectedDeliveryDate
order by Quantity desc


--Having

select SupplierID, SupplierReference, ExpectedDeliveryDate from Purchasing.PurchaseOrders


select SupplierID, count (SupplierID) as Quantities
from Purchasing.PurchaseOrders
group by SupplierID
having count (SupplierID) > 5




--Subconsultas Where

select * from Purchasing.Suppliers

select * from Purchasing.SupplierTransactions

select * from Purchasing.PurchaseOrderLines

select * from Purchasing.SupplierCategories

select SupplierName, SupplierCategoryID,SupplierID from Purchasing.Suppliers


select SupplierName, SupplierCategoryID,SupplierID,
	(select sum (TransactionAmount) from Purchasing.SupplierTransactions
	 where SupplierID = Purchasing.Suppliers.SupplierID) as [TransactionsSum],
	 (select SupplierCategoryName from Purchasing.SupplierCategories
	  where SupplierCategoryID = Purchasing.Suppliers.SupplierID) as [SupplierCategory]
from Purchasing.Suppliers
order by [TransactionsSum] desc


Select * from Sales.CustomerTransactions

Select * from Sales.Customers

Select * from sales.CustomerCategories


select CustomerName, CustomerID,
		(Select sum(TransactionAmount) from Sales.CustomerTransactions
		 where CustomerID = Sales.Customers.CustomerID) as Facturaci nTot

from Sales.Customers
order by Facturaci nTot desc





--Sub Consultas con Joins

select CustomerName, sales.Customers.CustomerID, PostalCityID, 
       sum (Sales.CustomerTransactions.TransactionAmount) as Total, 
       sales.CustomerCategories.CustomerCategoryName

from sales.Customers  join Sales.CustomerTransactions on sales.Customers.CustomerID = Sales.CustomerTransactions.CustomerID
					  join sales.CustomerCategories on sales.Customers.CustomerCategoryID = sales.CustomerCategories.CustomerCategoryID
					  
group by  CustomerName, sales.Customers.CustomerID, PostalCityID, Sales.CustomerTransactions.TransactionAmount, 
          sales.CustomerCategories.CustomerCategoryName

order by Total desc


--inner join


Select * from Sales.CustomerTransactions

Select * from Sales.Customers

Select * from sales.CustomerCategories



Select CustomerID, C.CustomerCategoryID, CAT.CustomerCategoryName 
from Sales.Customers C
join Sales.CustomerCategories CAT
on C.CustomerCategoryID = CAT.CustomerCategoryID




Select C.CustomerID, C.CustomerCategoryID, CAT.CustomerCategoryName, sum(TransactionAmount) as total 
from Sales.Customers C
	  join Sales.CustomerCategories CAT on C.CustomerCategoryID = CAT.CustomerCategoryID
	  join Sales.CustomerTransactions TRC on C.CustomerID = TRC.CustomerID 
group by  C.CustomerID,C.CustomerCategoryID,CAT.CustomerCategoryName
having sum(transactionamount) > 500
order by total desc



Select * from Sales.CustomerTransactions
Select * from Sales.Customers
Select * from sales.CustomerCategories
Select * from Application.DeliveryMethods


select C.CustomerID, C.CustomerName, CAT.CustomerCategoryName,
		DLV.DeliveryMethodName,  TRA.CustomerTransactionID, Sum(TransactionAmount) as Total$
From Sales.Customers C	
	join Sales.CustomerTransactions TRA on C.CustomerID = TRA.CustomerID
	join Sales.CustomerCategories CAT on C.CustomerCategoryID = CAT.CustomerCategoryID
	join Application.DeliveryMethods DLV on C.DeliveryMethodID = DLV.DeliveryMethodID
Group by C.CustomerID, c.CustomerName, cat.CustomerCategoryName, dlv.DeliveryMethodName, tra.CustomerTransactionID
Order by Total$ desc

select * from sales.CustomerTransactions

select C.CustomerID, C.CustomerName, sum(TransactionAmount) as Total$
from Sales.Customers C
     join Sales.CustomerTransactions TRA on C.CustomerID = TRA.CustomerID
	 join Sales.CustomerCategories CAT on C.CustomerCategoryID = CAT.CustomerCategoryID
Group by C.CustomerID, C.CustomerName
order by Total$ desc


Select B.CustomerCategoryName, format(sum(C.TransactionAmount),'C') as Total
from Sales.Customers A
	join Sales.CustomerCategories B on A.CustomerCategoryID = B.CustomerCategoryID
	join Sales.CustomerTransactions C on C.CustomerID = A.CustomerID
Group by B.CustomerCategoryName
order by sum(TransactionAmount) desc



Select D.DeliveryMethodName, sum(TRA.TransactionAmount) as Total
from Sales.Customers C
	join Application.DeliveryMethods D on D.DeliveryMethodID = C.DeliveryMethodID
	join Sales.CustomerTransactions TRA on TRA.CustomerID = C.CustomerID
Group by D.DeliveryMethodName
Order by total desc

Select * from Purchasing.SupplierCategories
Select * from Purchasing.Suppliers
Select * from Purchasing.SupplierTransactions


Select SP.SupplierName, CAT.SupplierCategoryName, Sum(TRA.AmountExcludingTax) as Total 
from Purchasing.Suppliers SP
	join Purchasing.SupplierCategories CAT on SP.SupplierCategoryID = CAT.SupplierCategoryID
	join Purchasing.SupplierTransactions TRA on TRA.SupplierID = SP.SupplierID
Group by CAT.SupplierCategoryName, SP.SupplierName
order by total desc

select * from Purchasing.SupplierCategories


select format(sum(TransactionAmount),'C') as Total
from Sales.CustomerTransactions


--Having 

Select count(CustomerTransactionID) as dups, CustomerID, format(avg(TransactionAmount),'C') as mean, 
format(sum(TransactionAmount),'C') as total, 
format(max(TransactionAmount),'C') as higher
from Sales.CustomerTransactions
group by CustomerID
having sum(TransactionAmount) not between 1000 and 5000
order by total desc

Select  CustomerID, TransactionAmount, TransactionDate
from Sales.CustomerTransactions
where TransactionAmount > 500 and TransactionDate not between '20140101' and '20160101'
group by CustomerID, TransactionAmount, TransactionDate
order by TransactionDate desc



--top

Select top (10) * from Sales.CustomerTransactions
order by TransactionAmount desc


--funciones sql

select max(TransactionAmount) as MaxTransactionAmt
from Sales.CustomerTransactions


-- variables

declare @variable1 int
set @variable1 = 1000
declare @variable2 int
set @variable2 = 400
print @variable1 + @variable2


select count(customerid) - count (distinct CustomerID)
from Sales.CustomerTransactions

select top 3 CustomerID, CustomerName, PrimaryContactPersonID
from sales.Customers
where PrimaryContactPersonID not like '101%'
order by AccountOpenedDate desc

select top 10 C.CustomerName, C.CustomerID, AVG(transactionAmount) as jajajja
from sales.Customers C
	join sales.CustomerTransactions TRA on C.CustomerID = TRA.CustomerID
group by c.CustomerID, c.CustomerName



select * from Sales.Customers
select * from sales.CustomerTransactions
