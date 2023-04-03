
/*Query 1 - query used for first insight */
SELECT c.Country, COUNT(c.CustomerId)
FROM Customer c
JOIN Invoice i
ON c.CustomerId=i.CustomerId
JOIN InvoiceLine il
ON il.InvoiceId=i.InvoiceId
JOIN Track t
ON t.TrackId= il.TrackId
JOIN Genre g
ON g.GenreId=t.GenreId
GROUP BY c.Country
ORDER BY COUNT(c.CustomerId) DESC;


/*Query 2 - query used for second insight */
SELECT st.ArtistId, st.Name, COUNT(t.Name)
FROM Artist st
JOIN Album a
ON st.ArtistId=a.ArtistId
JOIN Track t
ON a.AlbumId=t.AlbumId
JOIN Genre g
ON g.GenreId=t.GenreId
WHERE g.name='Rock'
GROUP BY 1
ORDER BY COUNT(t.Name) DESC
LIMIT 10;


/*Query 3 - query used for third insight */
SELECT st.ArtistId, st.Name, SUM(il.Quantity)*il.UnitPrice as amount
FROM Artist st
JOIN Album a
ON st.ArtistId=a.ArtistId
JOIN Track t
ON a.AlbumId=t.AlbumId
JOIN InvoiceLine il
ON il.TrackId=t.TrackId
JOIN Invoice i
ON i.InvoiceId=il.InvoiceId
JOIN Customer c
ON c.CustomerId=i.CustomerId
GROUP BY 2
ORDER BY SUM(il.Quantity)*il.UnitPrice DESC
LIMIT 20;


/*Query 4 - query used for forth insight */
SELECT  st.Name,c.FirstName, c.LastName,c.CustomerId, il.unitprice*SUM(il.quantity) as amount
FROM Artist st
JOIN Album a
ON st.ArtistId=a.ArtistId
JOIN Track t
ON a.AlbumId=t.AlbumId
JOIN InvoiceLine il
ON il.TrackId=t.TrackId
JOIN Invoice i
ON i.InvoiceId=il.InvoiceId
JOIN Customer c
ON c.CustomerId=i.CustomerId
GROUP BY 1,2
HAVING st.Name='Iron Maiden'
ORDER BY il.unitprice*SUM(il.quantity) DESC
LIMIT 20;

