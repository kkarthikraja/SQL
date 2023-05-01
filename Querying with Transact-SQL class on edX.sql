1)##Retrieving Customer Data
AdventureWorks Cycles is a company that sells directly to retailers, who then sell products to consumers. Each retailer that is an AdventureWorks customer has provided a named contact for all communication from AdventureWorks.
The sales manager at AdventureWorks has asked you to generate some reports containing details of the company's customers to support a direct sales campaign. Let's start with some basic exploration.
##Familiarize yourself with the Customer table by writing a Transact-SQL query that retrieves all columns for all customers.

SELECT * FROM SalesLT.Customer;

2)##Create List of Customer Contacts
As a next step, it would be good to have a structured view of the names of your customer contacts.
##Create a table that lists all customer contact names. The table should include the Title, FirstName, MiddleName, LastName and Suffix of all customers.

SELECT TITLE, FirstName, MiddleName, LastName, Suffix
FROM SalesLT.Customer;

3)##Create List of Customer Contacts (2)
Each customer has an assigned salesperson. Can you finish the query to include the salesperson and a nicely structured display of the customers' names?
##Complete the query to list the following elements for all customers:
The salesperson
A column named CustomerName that displays how the customer contact should be greeted (e.g. "Mr Smith").
The customer's phone number (Phone)
Don't forget to space out the contents of your CustomerName column with + ' ' + and use the alias provided.

SELECT Salesperson, Title + ' ' + LastName AS CustomerName, Phone
FROM SalesLT.Customer;

4)##Retrieving Customer and Sales Data
As a reminder, if you want to build a string with an integer (e.g. id) you can use:
CAST(id AS VARCHAR)
Put it to the test; as you continue to work with the AdventureWorks customer data, you must create queries for reports that have been requested by the sales team.
##Provide a list of all customer companies in the format <Customer ID>: <Company Name> (e.g. 78: Preferred Bikes). You'll need to use VARCHAR in your solution. Don't forget to use the alias provided.

SELECT CAST(CustomerID AS varchar) + ': ' + CompanyName AS CustomerCompany
FROM SalesLT.Customer;

5)##Retrieving Customer and Sales Data (2)
The SalesLT.SalesOrderHeader table contains records of sales orders. You have been asked to retrieve data for a report that shows:
The sales order number and revision number in the format <Order Number> (<Revision>) (e.g. SO71774 (2)).
The order date converted to ANSI standard format yyyy.mm.dd (e.g. 2015.01.31).
##Complete the query on the right to create the 2-column table that's specified above.

SELECT SalesOrderNumber + ' (' + STR(RevisionNumber, 1) + ')' AS OrderRevision,
CONVERT(nvarchar(30), OrderDate, 102) AS OrderDate
FROM SalesLT.SalesOrderHeader;

6)##Retrieving Customer Contact Names
In this exercise, you'll write a query that returns a list of customer names. The list must consist of a single field in the format <first name> <last name> (e.g. Keith Harris) if the middle name is unknown, or <first name> <middle name> <last name> (e.g. Jane M. Gates) if a middle name is stored in the database.
##Retrieve customer contact names including middle names when they're known.

SELECT FirstName + ' ' + ISNULL(MiddleName + ' ', '') + LastName
AS CustomerName
FROM SalesLT.Customer;

7)##Retrieving Primary Contact Details
Customers may provide AdventureWorks with an email address, a phone number, or both. If an email address is available, then it should be used as the primary contact method; if not, then the phone number should be used. Here, you will write a query that returns a list of customer IDs in one column, and a second column named PrimaryContact that contains the email address if known, and otherwise the phone number.
##Write a query that returns a list of customer IDs in one column, and a second column called PrimaryContact that contains the email address if known, and otherwise the phone number.

SELECT CustomerID, COALESCE(EmailAddress, Phone) AS PrimaryContact
FROM SalesLT.Customer;

8)##Retrieving Shipping Status
You have been asked to create a query that returns a list of sales order IDs and order dates with a column named ShippingStatus that contains the text "Shipped" for orders with a known ship date, and "Awaiting Shipment" for orders with no ship date.
##Write a query to list sales order IDs and order dates with a column named ShippingStatus that contains the text 'Shipped' for orders with a known ship date, and 'Awaiting Shipment' for orders with no ship date.

SELECT SalesOrderID, OrderDate,
  CASE
    WHEN ShipDate IS NULL THEN 'Awaiting Shipment'
    ELSE 'Shipped'
  END AS ShippingStatus
FROM SalesLT.SalesOrderHeader;


1)##Retrieving Transportation Report Data
The logistics manager at AdventureWorks has asked you to generate some reports containing details of the company's customers to help reduce transportation costs. For starters, you need to produce a list of all of your customers' locations.
##Finish the Transact-SQL query that returns the Address table and retrieves all values for City and StateProvince, without duplicates.

SELECT  DISTINCT City, StateProvince
FROM SalesLT.Address;

2)##Retrieving Transportation Report Data (2)
You are being told that transportation costs are increasing and you need to identify the heaviest products.
##Finish the query to retrieve the names of the top ten percent of products by weight.

SELECT TOP 10 PERCENT Weight, ProductID, Name
FROM SalesLT.Product
ORDER BY Weight DESC;

3)##Retrieving Transportation Report Data (3)
The ten heaviest products are transported by a specialist carrier.
##Tweak the query to list the heaviest 100 products not including the ten most heavy ones.

SELECT Weight, ProductID, Name
FROM SalesLT.Product
ORDER BY Weight DESC
OFFSET 10 ROWS FETCH NEXT 100 ROWS ONLY;

4)##Retrieving Product Data
The product manager at AdventureWorks would like you to create some reports listing details of the products that you sell.
##Write a query to find the names, colors, and sizes of the products with a product model ID of 1.

SELECT Name, Color, Size
FROM SalesLT.Product
WHERE ProductModelID = 1;

5)##Retrieving Product Data (2)
The product manager would like more information on products of certain colors and sizes.
##Retrieve the product number and name of the products that have a Color of 'Black', 'Red', or 'White' and a Size of 'S' or 'M'.

SELECT ProductNumber, Name, Color, Size
FROM SalesLT.Product
WHERE Color IN ('Black', 'Red', 'White') AND Size IN ('S', 'M');

6)##Retrieving Product Data (3)
The product manager would also like information on products with a particular product number prefix.
##Retrieve the product number, name, and list price of products that have a product number beginning with 'BK-'.

SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK%';

7)Retrieving Product Data (4)
Finally, the product manager is interested in a slight variation of the last request regarding product numbers with a particular prefix.
Modify your previous query to retrieve the product number, name, and list price of products with product number beginning with 'BK-' followed by any character other than 'R', and ending with a '-' followed by any two numerals.
Remember:
to match any string of zero or more characters, use %
to match characters that are not R, use [^R]
to match a numeral, use [0-9]

SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK-[^R]%-[0-9][0-9]';

1)##Generating Invoice Reports
AdventureWorks Cycles sells directly to retailers, who must be invoiced for their orders. You have been tasked with writing a query to generate a list of invoices to be sent to customers.
##Write a query that returns the company name from the SalesLT.Customer table, the sales order ID and total due from the SalesLT.SalesOrderHeader table. Make sure to use the aliases provided, and default column names elsewhere.

SELECT c.CompanyName, oh.SalesOrderID, oh.TotalDue
FROM SalesLT.Customer AS c
JOIN SalesLT.SalesOrderHeader AS oh
ON oh.CustomerID = c.CustomerID;

2)##Generating Invoice Reports (2)
In order to send out invoices to the customers, you'll need their addresses.
##Extend your customer orders query to include the main office address for each customer, including the full street address, city, state or province, postal code, and country or region. Make sure to use the aliases provided, and default column names elsewhere.

SELECT c.CompanyName, a.AddressLine1, ISNULL(a.AddressLine2, '') AS AddressLine2, a.City, a.StateProvince, a.PostalCode, a.CountryRegion, oh.SalesOrderID, oh.TotalDue
FROM SalesLT.Customer AS c
JOIN SalesLT.SalesOrderHeader AS oh
ON oh.CustomerID = c.CustomerID
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID AND AddressType = 'Main Office'
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID;

3)##Retrieving Sales Data
The sales manager wants a list of all customer companies and their contacts (first name and last name), showing the sales order ID and total due for each order they have placed.
##Customers who have not placed any orders should be included at the bottom of the list with NULL values for the order ID and total due. Make sure to use the aliases provided, and default column names elsewhere.

SELECT c.CompanyName, c.FirstName, c.LastName, oh.SalesOrderID, oh.TotalDue
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS oh
ON c.CustomerID = oh.CustomerID
ORDER BY oh.SalesOrderID DESC;

4)##Retrieving Sales Data (2)
A sales employee has noticed that AdventureWorks does not have address information for all customers.
##Write a query that returns a list of customer IDs, company names, contact names (first name and last name), and phone numbers for customers with no address stored in the database. Make sure to use the aliases provided, and default column names elsewhere.

SELECT c.CompanyName, c.FirstName, c.LastName, c.Phone
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
WHERE ca.AddressID IS NULL;

5)##Retrieving Sales Data (3)
Some customers have never placed orders, and some products have never been ordered.
##Write a query that returns a column of customer IDs for customers who have never placed an order, and a column of product IDs for products that have never been ordered.
Each row with a customer ID should have a NULL product ID (because the customer has never ordered a product) and each row with a product ID should have a NULL customer ID (because the product has never been ordered by a customer).
Make sure to use the aliases provided, and default column names elsewhere.

SELECT c.CustomerID, p.ProductID
FROM SalesLT.Customer AS c
FULL JOIN SalesLT.SalesOrderHeader AS oh
ON c.CustomerID = oh.CustomerID
FULL JOIN SalesLT.SalesOrderDetail AS od
ON od.SalesOrderID = oh.SalesOrderID
FULL JOIN SalesLT.Product AS p
ON p.ProductID = od.ProductID
WHERE oh.SalesOrderID IS NULL
ORDER BY ProductID, CustomerID;


1)##Retrieving Customer Addresses
Customers can have two kinds of address: a main office address and a shipping address. The accounts department wants to ensure that the main office address is always used for billing, and have asked you to write a query that clearly identifies the different types of address for each customer.
##Write a query that retrieves the company name, first line of the street address, city, and a column named AddressType with the value 'Billing' for customers where the address type in the SalesLT.CustomerAddress table is 'Main Office'. Make sure to use the aliases provided, and default column names elsewhere.

SELECT c.CompanyName, a.AddressLine1, a.City, 'Billing' AS AddressType
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Main Office';

2)##Retrieving Customer Addresses (2)
The ideal solution to the previous exercise has been included in the sample code on the right. Can you adapt it slightly to generate a very similar result?
##Adapt the query to retrieve the company name, first line of the street address, city, and a column named AddressType with the value 'Shipping' for customers where the address type in the SalesLT.CustomerAddress table is 'Shipping'. Make sure to use the aliases provided, and default column names elsewhere.

SELECT c.CompanyName, a.AddressLine1, a.City, 'Shipping' AS AddressType
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Shipping';

3)##Retrieving Customer Addresses (3)
The code on the right contains the two queries from the previous exercises.
##Use UNION ALL to combine the results returned by the two queries to create a list of all customer addresses that is sorted by company name and then address type.

SELECT c.CompanyName, a.AddressLine1, a.City, 'Billing' AS AddressType
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Main Office'
UNION ALL
SELECT c.CompanyName, a.AddressLine1, a.City, 'Shipping' AS AddressType
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Shipping'
ORDER BY c.CompanyName, AddressType;

4)##Filtering Customer Addresses (1)
You have created a master list of all customer addresses, but now you have been asked to create filtered lists that show which customers have only a main office address, and which customers have both a main office and a shipping address.
##Write a query that returns the company name of each company that appears in a table of customers with a 'Main Office' address, but not in a table of customers with a 'Shipping' address.

SELECT c.CompanyName
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Main Office'
EXCEPT
SELECT c.CompanyName
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Shipping'
ORDER BY c.CompanyName;

5)##Filtering Customer Addresses (2)
This exercise builds upon your work in the previous exercise.
##Write a query that returns the company name of each company that appears in a table of customers with a 'Main Office' address, and also in a table of customers with a 'Shipping' address. Make sure to use the aliases provided, and default column names elsewhere.

SELECT c.CompanyName
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Main Office'
INTERSECT
SELECT c.CompanyName
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Shipping'
ORDER BY c.CompanyName;

1)##Retrieving Product Information
Your reports are returning the correct records, but you would like to modify how these records are displayed.
##Write a query to return the product ID of each product, together with the product name formatted as upper case and a column named ApproxWeight with the weight of each product rounded to the nearest whole unit. Make sure to use the aliases provided, and default column names elsewhere.

SELECT ProductID, UPPER(Name) AS ProductName, Round(Weight, 0) AS ApproxWeight
FROM SalesLT.Product;

2)##Retrieving Product Information (2)
It would be useful to know when AdventureWorks started selling each product.
##Extend your query to include columns named SellStartYear and SellStartMonth containing the year and month in which AdventureWorks started selling each product. The month should be displayed as the month name (e.g. 'January'). Make sure to use the aliases provided, and default column names elsewhere.

SELECT ProductID, UPPER(Name) AS ProductName, ROUND(Weight, 0) AS ApproxWeight,
       Year(SellStartDate) as SellStartYear, DATENAME(m, SellStartDate) as SellStartMonth
FROM SalesLT.Product;

3)##Retrieving Product Information (3)
It would also be useful to know the type of each product.
##Extend your query to include a column named ProductType that contains the leftmost two characters from the product number. Make sure to use the aliases provided, and default column names elsewhere.

SELECT ProductID, UPPER(Name) AS ProductName, ROUND(Weight, 0) AS ApproxWeight,
       YEAR(SellStartDate) as SellStartYear, DATENAME(m, SellStartDate) as SellStartMonth,
       LEFT(ProductNumber, 2) AS ProductType
FROM SalesLT.Product;

4)##Retrieving Product Information (4)
Categorical data can be less useful in certain cases. Here, you only want to look at numeric product size data.
##Extend your query to filter the product returned so that only products with a numeric size are included. Make sure to use the aliases provided, and default column names elsewhere.

SELECT ProductID, UPPER(Name) AS ProductName, ROUND(Weight, 0) AS ApproxWeight,
       YEAR(SellStartDate) as SellStartYear, DATENAME(m, SellStartDate) as SellStartMonth,
       LEFT(ProductNumber, 2) AS ProductType
FROM SalesLT.Product
WHERE ISNUMERIC(Size) = 1;

5)##Ranking Customers By Revenue
The sales manager would like a list of customers ranked by sales.
##Write a query that returns a list of company names with a ranking of their place in a list of highest TotalDue values from the SalesOrderHeader table. Make sure to use the aliases provided, and default column names elsewhere.

SELECT CompanyName, TotalDue AS Revenue,
       RANK() OVER (ORDER BY TotalDue DESC) AS RankByRevenue
FROM SalesLT.SalesOrderHeader AS SOH
JOIN SalesLT.Customer AS C
ON SOH.CustomerID = C.CustomerID;

6)##Aggregating Product Sales
The product manager would like aggregated information about product sales.
##Write a query to retrieve a list of the product names and the total revenue calculated as the sum of the LineTotal from the SalesLT.SalesOrderDetail table, with the results sorted in descending order of total revenue. Make sure to use the aliases provided, and default column names elsewhere.

SELECT Name, Sum(LineTotal) AS TotalRevenue
FROM SalesLT.SalesOrderDetail AS SOD
JOIN SalesLT.Product AS P ON SOD.ProductID = P.ProductID
GROUP BY P.Name
ORDER BY TotalRevenue DESC;

7)##Aggregating Product Sales (2)
The product manager would like aggregated information about product sales.
##Modify the previous query to include sales totals for products that have a list price of more than 1000. Make sure to use the aliases provided, and default column names elsewhere.

SELECT Name, SUM(LineTotal) AS TotalRevenue
FROM SalesLT.SalesOrderDetail AS SOD
JOIN SalesLT.Product AS P ON SOD.ProductID = P.ProductID
WHERE P.ListPrice > 1000
GROUP BY P.Name
ORDER BY TotalRevenue DESC;

8)##Aggregating Product Sales (3)
The product manager would like aggregated information about the products which grossed a very large amount.
##Modify the previous query to only include products with total sales greater than 20000. Make sure to use the aliases provided, and default column names elsewhere.

SELECT Name,SUM(LineTotal) AS TotalRevenue
FROM SalesLT.SalesOrderDetail AS SOD
JOIN SalesLT.Product AS P ON SOD.ProductID=P.ProductID
WHERE P.ListPrice > 1000
GROUP BY P.Name
HAVING SUM(LineTotal) > 20000
ORDER BY TotalRevenue DESC;

1)##Retrieving Product Price Information
AdventureWorks products each have a standard cost that indicates the cost of manufacturing the product, and a list price that indicates the recommended selling price for the product. This data is stored in the SalesLT.Product table.
Whenever a product is ordered, the actual unit price at which it was sold is also recorded in the SalesLT.SalesOrderDetail table.
Use subqueries to compare the cost and list prices for each product with the unit prices charged in each sale.
##Retrieve the product ID, name, and list price for each product where the list price is higher than the average unit price for all products that have been sold.

SELECT ProductID, Name, ListPrice from SalesLT.Product
WHERE ListPrice >
(SELECT AVG(UnitPrice) FROM SalesLT.SalesOrderDetail)
ORDER BY ProductID

2)##Retrieving Product Price Information (2)
AdventureWorks is interested in finding out which products are being sold at a loss.
##Retrieve the product ID, name, and list price for each product where the list price is 100 or more, and the product has been sold for (strictly) less than 100.
Remember, the ProductID in your subquery will be from the SalesLT.SalesOrderDetail table.

SELECT ProductID, Name, ListPrice FROM SalesLT.Product
WHERE ProductID IN
  (SELECT ProductID from SalesLT.SalesOrderDetail WHERE UnitPrice < 100)
AND ListPrice >= 100
ORDER BY ProductID;

3)##Retrieving Product Price Information (3)
In order to get an idea of how many products are selling above or below list price, you want to gather some aggregate product data.
##Retrieve the product ID, name, cost, and list price for each product along with the average unit price for which that product has been sold. Make sure to use the aliases provided, and default column names elsewhere.

SELECT ProductID, Name, StandardCost, ListPrice,
(SELECT AVG(UnitPrice)
 FROM SalesLT.SalesOrderDetail AS SOD
 WHERE P.ProductID = SOD.ProductID) AS AvgSellingPrice
FROM SalesLT.Product AS P
ORDER BY P.ProductID;

4)##Retrieving Product Price Information (4)
AdventureWorks is interested in finding out which products are costing more than they're being sold for, on average.
##Filter the query for the previous exercise to include only products where the cost is higher than the average selling price. Make sure to use the aliases provided, and default column names elsewhere.

SELECT ProductID, Name, StandardCost, ListPrice,
(SELECT AVG(UnitPrice)
 FROM SalesLT.SalesOrderDetail AS SOD
 WHERE P.ProductID = SOD.ProductID) AS AvgSellingPrice
FROM SalesLT.Product AS P
WHERE StandardCost >
(SELECT AVG(UnitPrice)
 FROM SalesLT.SalesOrderDetail AS SOD
 WHERE P.ProductID = SOD.ProductID)
ORDER BY P.ProductID;

5)##Retrieving Customer Information
The AdventureWorksLT database includes a table-valued user-defined function named dbo.ufnGetCustomerInformation. Use this function to retrieve details of customers based on customer ID values retrieved from tables in the database.
##Retrieve the sales order ID, customer ID, first name, last name, and total due for all sales orders from the SalesLT.SalesOrderHeader table and the dbo.ufnGetCustomerInformation function. Make sure to use the aliases provided, and default column names elsewhere.

SELECT SOH.SalesOrderID, SOH.CustomerID, CI.FirstName, CI.LastName, SOH.TotalDue
FROM SalesLT.SalesOrderHeader AS SOH
CROSS APPLY dbo.ufnGetCustomerInformation(SOH.CustomerID) AS CI
ORDER BY SOH.SalesOrderID;

6)##Retrieving Customer Information (2)
Use the table-valued user-defined function dbo.ufnGetCustomerInformation again to to retrieve details of customers based on customer ID values retrieved from tables in the database.
##Retrieve the customer ID, first name, last name, address line 1 and city for all customers from the SalesLT.Address and SalesLT.CustomerAddress tables, and the dbo.ufnGetCustomerInformation function. Make sure to use the aliases provided, and default column names elsewhere.

SELECT CA.CustomerID, CI.FirstName, CI.LastName, A.AddressLine1, A.City
FROM SalesLT.Address AS A
JOIN SalesLT.CustomerAddress AS CA
ON A.AddressID = CA.AddressID
CROSS APPLY dbo.ufnGetCustomerInformation(CA.CustomerID) AS CI
ORDER BY CA.CustomerID;

1)##Retrieving Product Information
AdventureWorks sells many products that are variants of the same product model. You must write queries that retrieve information about these products.
##Retrieve the product ID, product name, product model name, and product model summary for each product from the SalesLT.Product table and the SalesLT.vProductModelCatalogDescription view. Make sure to use the aliases provided, and default column names elsewhere.

SELECT P.ProductID, P.Name AS ProductName, PM.Name AS ProductModel, PM.Summary
FROM SalesLT.Product AS P
JOIN SalesLT.vProductModelCatalogDescription AS PM
ON P.ProductModelID = PM.ProductModelID
ORDER BY ProductID;

2)##Retrieving Product Information (2)
You are only interested in products which have a listed color in the database.
##Create a table variable and populate it with a list of distinct colors from the SalesLT.Product table. Then use the table variable to filter a query that returns the product ID, name, and color from the SalesLT.Product table so that only products with a color listed in the table variable are returned. You'll need to use NVARCHAR in your solution and make sure to use the aliases provided.

DECLARE @Colors AS TABLE (Color nvarchar(15));

INSERT INTO @Colors
SELECT DISTINCT Color FROM SalesLT.Product;

SELECT ProductID, Name, Color
FROM SalesLT.Product
WHERE Color IN (SELECT Color FROM @Colors);

3)##Retrieving Product Information (3)
The AdventureWorksLT database includes a table-valued function named dbo.ufnGetAllCategories, which returns a table of product categories (e.g. 'Road Bikes') and parent categories (for example 'Bikes').
##Write a query that uses this function to return a list of all products including their parent category and their own category. Make sure to use the aliases provided, and default column names elsewhere.

SELECT C.ParentProductCategoryName AS ParentCategory,
       C.ProductCategoryName AS Category,
       P.ProductID, P.Name AS ProductName
FROM SalesLT.Product AS P
JOIN dbo.ufnGetAllCategories() AS C
ON P.ProductCategoryID = C.ProductCategoryID
ORDER BY ParentCategory, Category, ProductName;

4)##Retrieving Customer Sales Revenue
Each AdventureWorks customer is a retail company with a named contact. You must create queries that return the total revenue for each customer, including the company and customer contact names.
##Retrieve a list of customers in the format Company (Contact Name) together with the total revenue for each customer. Use a derived table or a common table expression to retrieve the details for each sales order, and then query the derived table or CTE to aggregate and group the data. Make sure to use the aliases provided, and default column names elsewhere.

WITH CustomerSales(CompanyContact, SalesAmount)
AS
(SELECT CONCAT(c.CompanyName, CONCAT(' (' + c.FirstName + ' ', c.LastName + ')')), SOH.TotalDue
 FROM SalesLT.SalesOrderHeader AS SOH
 JOIN SalesLT.Customer AS c
 ON SOH.CustomerID = c.CustomerID)
SELECT CompanyContact, SUM(SalesAmount) AS Revenue
FROM CustomerSales
GROUP BY CompanyContact
ORDER BY CompanyContact;

1)##Retrieving Regional Sales Totals
AdventureWorks sells products to customers in multiple country/regions around the world.
An existing report uses the query provided in the editor to return total sales revenue grouped by country/region and state/province
##Modify the query so that the results include a grand total for all sales revenue and a subtotal for each country/region in addition to the state/province subtotals that are already returned. Make sure to use the aliases provided, and default column names elsewhere.

SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c
ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh
ON c.CustomerID = soh.CustomerID
-- Modify GROUP BY to use ROLLUP
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince;

2)##Retrieving Regional Sales Totals (2)
The solution to the previous exercise has been included on the right, with some additions.
##Modify your query to include a column named Level that indicates at which level in the total, country/region, and state/province hierarchy the revenue figure in the row is aggregated.
For example, the grand total row should contain the value 'Total', the row showing the subtotal for United States should contain the value 'United States Subtotal', and the row showing the subtotal for California should contain the value 'California Subtotal'.
Make sure to use the aliases provided, and default column names elsewhere.

SELECT a.CountryRegion, a.StateProvince,
IIF(GROUPING_ID(a.CountryRegion) = 1 AND GROUPING_ID(a.StateProvince) = 1, 'Total', IIF(GROUPING_ID(a.StateProvince) = 1, a.CountryRegion + ' Subtotal', a.StateProvince + ' Subtotal')) AS Level,
SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c
ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh
ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince;

3)##Retrieving Regional Sales Totals (3)
Again, the solution to the previous exercise has been provided, so you can take it from there!
##Extend your query to include a grouping for individual cities. Make sure to use the aliases provided, and default column names elsewhere.

SELECT a.CountryRegion, a.StateProvince, a.City,
CHOOSE (1 + GROUPING_ID(a.CountryRegion) + GROUPING_ID(a.StateProvince) + GROUPING_ID(a.City), a.City + ' Subtotal', a.StateProvince + ' Subtotal', a.CountryRegion + ' Subtotal', 'Total') AS Level,
SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c
ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh
ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince, a.City)
ORDER BY a.CountryRegion, a.StateProvince, a.City;

4)##Retrieving Customer Sales By Category
AdventureWorks products are grouped into categories, which in turn have parent categories (defined in the SalesLT.vGetAllCategories view).
AdventureWorks customers are retail companies, and they may place orders for products of any category. The revenue for each product in an order is recorded as the LineTotal value in the SalesLT.SalesOrderDetail table.
##Retrieve a list of customer company names together with their total revenue for each parent category in Accessories, Bikes, Clothing, and Components. Make sure to use the aliases provided, and default column names elsewhere.

SELECT CompanyName, Accessories, Bikes, Clothing, Components  --Could also use SELECT *
FROM 
(SELECT cat.ParentProductCategoryName, cust.CompanyName, sod.LineTotal
FROM SalesLT.SalesOrderDetail AS sod
JOIN SalesLT.SalesOrderHeader AS soh 
ON sod.SalesOrderID = soh.SalesOrderID
JOIN SalesLT.Customer AS cust 
ON soh.CustomerID = cust.CustomerID
JOIN SalesLT.Product AS prod 
ON sod.ProductID = prod.ProductID
JOIN SalesLT.vGetAllCategories AS cat 
ON prod.ProductcategoryID = cat.ProductCategoryID) AS Sales
PIVOT (SUM(LineTotal) FOR ParentProductCategoryName IN([Accessories],[Bikes],[Clothing],[Components])
) AS pvt;


1)##Inserting Products (1)
Each AdventureWorks product is stored in the SalesLT.Product table, and each product has a unique ProductID identifier, which is implemented as an IDENTITY column in the SalesLT.Product table.
Products are organized into categories, which are defined in the SalesLT.ProductCategory table.
The products and product category records are related by a common ProductCategoryID identifier, which is an IDENTITY column in the SalesLT.ProductCategory table.
##AdventureWorks has started selling the new product shown in the table above. Insert it into the SalesLT.Product table, using default or NULL values for unspecified columns.
Once you've inserted the product, run SELECT SCOPE_IDENTITY(); to get the last identity value that was inserted.
Add a query to view the row for the product in the SalesLT.Product table.

INSERT INTO SalesLT.Product (Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
VALUES
('LED Lights', 'LT-L123', 2.56, 12.99, 37, GETDATE());

SELECT SCOPE_IDENTITY();

SELECT * FROM SalesLT.Product
WHERE ProductID = SCOPE_IDENTITY();

2)##Inserting Products (2)
AdventureWorks is adding a product category for 'Bells and Horns' to its catalog. The parent category for the new category is 4 (Accessories).
##Write a query to insert this new product category into the SalesLT.ProductCategory table. Insert the ParentProductCategoryID, followed by the Name of the new product.
If you want, you can use a SELECT statement afterwards to see if the SalesLT.ProductCategory was properly updated.

INSERT INTO SalesLT.ProductCategory (ParentProductCategoryID, Name)
VALUES
(4, 'Bells and Horns');

3)##Inserting Products (3)
The code from the previous exercise to insert the product category is already included. This new category includes the following two new products.
Bicycle Bell
Bicyle Horn
Can you add these products?
##Insert the two new products with the appropriate ProductCategoryID value, based on the product details above.
Finish the query to join the SalesLT.Product and SalesLT.ProductCategory tables. That way, you can verify that the data has been inserted. Make sure to use the aliases provided, and default column names elsewhere.

INSERT INTO SalesLT.ProductCategory (ParentProductCategoryID, Name)
VALUES
(4, 'Bells and Horns');


INSERT INTO SalesLT.Product (Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
VALUES
('Bicycle Bell', 'BB-RING', 2.47, 4.99, IDENT_CURRENT('SalesLT.ProductCategory'), GETDATE()),
('Bicycle Horn', 'BB-PARP', 1.29, 3.75, IDENT_CURRENT('SalesLT.ProductCategory'), GETDATE());


SELECT c.Name As Category, p.Name AS Product
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory as c ON p.ProductCategoryID = c.ProductCategoryID

4)##Updating Products
You have inserted data for a product, but the pricing details are not correct. You must now update the records you have previously inserted to reflect the correct pricing.
##The sales manager at AdventureWorks has mandated a 10% price increase for all products in the Bells and Horns category. Update the rows in the SalesLT.Product table for these products to increase their price by 10%.
If you want, you can use a SELECT statement afterwards to see if the records were properly updated, but we won't check that.

UPDATE SalesLT.Product
SET ListPrice = ListPrice * 1.1
WHERE ProductCategoryID =
  (SELECT ProductCategoryID FROM SalesLT.ProductCategory WHERE Name = 'Bells and Horns');
  
5)##Updating Products (2)
The new LED lights you inserted in the previous challenge are to replace all previous light products.
##Update the SalesLT.Product table to set the DiscontinuedDate to today's date for all products in the Lights category (ProductCategoryID 37) other than the LED Lights product you inserted previously.
If you want, you can use a SELECT statement afterwards to see if the records were properly updated, but we won't check that.

UPDATE SalesLT.Product
SET DiscontinuedDate = GETDATE()
WHERE ProductCategoryID = 37 AND ProductNumber <> 'LT-L123';

6)##Deleting Products
The Bells and Horns category has not been successful and it must be deleted from the database.
##Delete the records for the Bells and Horns category and its products. You must ensure that you delete the records from the tables in the correct order to avoid a foreign-key constraint violation.
If you want, you can use a SELECT statement afterwards to see if the rows were properly deleted, but we won't check that.

DELETE FROM SalesLT.Product
WHERE ProductCategoryID =
	(SELECT ProductCategoryID FROM SalesLT.ProductCategory WHERE Name = 'Bells and Horns');

DELETE FROM SalesLT.ProductCategory
WHERE ProductCategoryID =
	(SELECT ProductCategoryID FROM SalesLT.ProductCategory WHERE Name = 'Bells and Horns');


##1)Writing a Script to Insert an Order Header
You want to create reusable scripts that make it easy to insert sales orders. You plan to create a script to insert the order header record, and a separate script to insert order detail records for a specified order header.
Both scripts will make use of variables to make them easy to reuse. Your script to insert an order header must enable users to specify values for the order date, due date, and customer ID.
You are asked to include the following sales order:
Order Date: Today's Date Due Date: 7 Days from Now  CustomerID:1
##Fill in the variable names to complete the DECLARE statements. You can infer these names from the INSERT statement further down the script.
Finish the INSERT query. Because SalesOrderID is an IDENTITY column, this ID will automatically be generated for you. You can use the hardcoded value 'CARGO TRANSPORT 5' for the ShipMethod field.
Use SCOPE_IDENTITY() to print out the ID of the new sales order header.

DECLARE @OrderDate datetime = GETDATE();
DECLARE @DueDate datetime = DATEADD(dd, 7, GETDATE());
DECLARE @CustomerID int = 1;
DECLARE @OrderID int;

SET @OrderID = NEXT VALUE FOR SalesLT.SalesOrderNumber;

INSERT INTO SalesLT.SalesOrderHeader (SalesOrderID, OrderDate, DueDate, CustomerID, ShipMethod)
VALUES
(@OrderID, @OrderDate, @DueDate, @CustomerID, 'CARGO TRANSPORT 5');

PRINT @OrderID;

2)##Extend Script to Insert an Order Detail
As a next step, you want to insert an order detail. The script for this must enable users to specify a sales order ID, a product ID, a quantity, and a unit price.
The script should check if the specified sales order ID exists in the SalesLT.SalesOrderHeader table. This can be done with the EXISTS predicate.
If it does, the code should insert the order details into the SalesLT.SalesOrderDetail table (using default values or NULL for unspecified columns).
If the sales order ID does not exist in the SalesLT.SalesOrderHeader table, the code should print the message 'The order does not exist'.
##Slightly adapted code from the previous exercise is available; it defines the OrderID with SCOPE_IDENTITY().
Complete the IF-ELSE block:
The test should check to see if there is a SalesOrderDetail with a SalesOrderID that is equal to the OrderID exists in the SalesLT.SalesOrderHeader table.
Finish the statement to insert a record in the SalesOrderDetail table when this is the case.
Print out 'The order does not exist' when this is not the case.

-- Code from previous exercise
DECLARE @OrderDate datetime = GETDATE();
DECLARE @DueDate datetime = DATEADD(dd, 7, GETDATE());
DECLARE @CustomerID int = 1;
INSERT INTO SalesLT.SalesOrderHeader (OrderDate, DueDate, CustomerID, ShipMethod)
VALUES (@OrderDate, @DueDate, @CustomerID, 'CARGO TRANSPORT 5');
DECLARE @OrderID int = SCOPE_IDENTITY();

DECLARE @ProductID int = 760;
DECLARE @Quantity int = 1;
DECLARE @UnitPrice money = 782.99;

IF EXISTS (SELECT * FROM SalesLT.OrderHeader WHERE SalesOrderID = @SalesOrderID)
BEGIN
	INSERT INTO SalesLT.SalesOrderDetail (SalesOrderID, OrderQty, ProductID, UnitPrice)
	VALUES (@OrderID, @Quantity, @ProductID, @UnitPrice)
END
ELSE
BEGIN
	PRINT 'The order does not exist'
END

3)##Updating Bike Prices
Adventure Works has determined that the market average price for a bike is $2,000, and consumer research has indicated that the maximum price any customer would be likely to pay for a bike is $5,000.
You must write some Transact-SQL logic that incrementally increases the list price for all bike products by 10% until the average list price for a bike is at least the same as the market average, or until the most expensive bike is priced above the acceptable maximum indicated by the consumer research.
The product categories in the Bikes parent category can be determined from the SalesLT.vGetAllCategories view.
Note: to assist error checking, please just modify the existing code in the editor.
##The loop should execute only if the average list price of a product in the 'Bikes' parent category is less than the market average.
Update all products that are in the 'Bikes' parent category, increasing the list price by 10%.
Determine the new average and maximum selling price for products that are in the 'Bikes' parent category.
If the new maximum price is greater than or equal to the maximum acceptable price, exit the loop; otherwise continue.

DECLARE @MarketAverage money = 2000;
DECLARE @MarketMax money = 5000;
DECLARE @AWMax money;
DECLARE @AWAverage money;

SELECT @AWAverage =  AVG(ListPrice), @AWMax = MAX(ListPrice)
FROM SalesLT.Product
WHERE ProductCategoryID IN
	(SELECT DISTINCT ProductCategoryID
	 FROM SalesLT.vGetAllCategories
	 WHERE ParentProductCategoryName = 'Bikes');

WHILE @AWAverage < @MarketAverage
BEGIN
   UPDATE SalesLT.Product
   SET ListPrice = ListPrice * 1.1
   WHERE ProductCategoryID IN
	(SELECT DISTINCT ProductCategoryID
	 FROM SalesLT.vGetAllCategories
	 WHERE ParentProductCategoryName = 'Bikes');
	  
	SELECT @AWAverage =  AVG(ListPrice), @AWMax = MAX(ListPrice)
	FROM SalesLT.Product
	WHERE ProductCategoryID IN
	(SELECT DISTINCT ProductCategoryID
	 FROM SalesLT.vGetAllCategories
	 WHERE ParentProductCategoryName = 'Bikes');

   IF @AWMax >= @MarketMax
      BREAK
   ELSE
      CONTINUE
END
PRINT 'New average bike price:' + CONVERT(varchar, @AWAverage);
PRINT 'New maximum bike price:' + CONVERT(varchar, @AWMax);


1)##Logging Errors
You are implementing a Transact-SQL script to delete orders, and you want to handle any errors that occur during the deletion process.
The following code can be used to delete order data:

DECLARE @OrderID int = <the_order_ID_to_delete>;
DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @OrderID;
DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @OrderID;
This code always succeeds, even when the specified order does not exist. Your task is to modify the existing code.

##Modify the code to check for the existence of the specified order ID before attempting to delete it. If the order does not exist, your code should throw an error. Otherwise, it should go ahead and delete the order data.

DECLARE @OrderID int = 0


DECLARE @error varchar(25) = 'Order #' + cast(@OrderID as varchar) + ' does not exist';

IF NOT EXISTS (SELECT * FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @OrderID)
BEGIN

	THROW 50001, @error, 0;
END
ELSE
BEGIN
	DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @OrderID;
	DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @OrderID;
END CATCH

2)##Logging Errors (2)
The solution to the previous exercise is shown in the editor. However, your code now throws an error if the specified order does not exist. Refine your code to catch this (or any other) error and print the error message to the user interface using the PRINT command. You can use BEGIN TRY, END TRY, BEGIN CATCH and END CATCH for this.
##Add a TRY...CATCH to the code
Include the IF-ELSE block in the TRY part.
In the CATCH part, print the error with ERROR_MESSAGE();

DECLARE @OrderID int = 0
DECLARE @error varchar(25) = 'Order #' + cast(@OrderID as varchar) + ' does not exist';

BEGIN TRY
    IF NOT EXISTS (SELECT * FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @OrderID)
    BEGIN
    	THROW 50001, @error, 0
    END
    ELSE
    BEGIN
    	DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @OrderID;
      DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @OrderID;
    END
END TRY

BEGIN CATCH

	PRINT ERROR_MESSAGE();
END CATCH

3)##Ensuring Data Consistency
You have implemented error handling logic in some Transact-SQL code that deletes order details and order headers. However, you are concerned that a failure partway through the process will result in data inconsistency in the form of undeleted order headers for which the order details have been deleted.
Your task is to enhance the code you created in the previous challenge so that the two DELETE statements are treated as a single transactional unit of work.
##Add BEGIN TRANSACTION and COMMIT TRANSACTION to treat the two DELETE statements as a single transactional unit of work. In the error handler, modify the code so that if a transaction is in process, it is rolled back. If no transaction is in process the error handler should continue to simply print the error message.

DECLARE @OrderID int = 0
DECLARE @error varchar(25) = 'Order #' + cast(@OrderID as varchar) + ' does not exist';

BEGIN TRY
	IF NOT EXISTS (SELECT * FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @OrderID)
	BEGIN
		THROW 50001, @error, 0
	END
	ELSE
	BEGIN
    
	  BEGIN TRANSACTION
		DELETE FROM SalesLT.SalesOrderDetail
		WHERE SalesOrderID = @OrderID;
		DELETE FROM SalesLT.SalesOrderHeader
		WHERE SalesOrderID = @OrderID;
	  COMMIT TRANSACTION
	END
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
	BEGIN
		
		ROLLBACK TRANSACTION;
	END
	ELSE
	BEGIN
		-
		PRINT ERROR_MESSAGE();
	END
END CATCH