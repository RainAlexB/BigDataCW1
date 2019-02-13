USE rb105;

SELECT I.InvoiceId, I.InvoiceDate, I.Street, I.City, I.Country, I.PostalCode, I.Total,
I.CustomerId, I.CustomerLastName, I.TrackId, T.Name AS TrackName, I.UnitPrice, I.Quantity
FROM
(
SELECT I.InvoiceId, I.InvoiceDate, I.BillingAddress AS Street, I.BillingCity AS City, I.BillingCountry AS Country, I.BillingPostalCode AS PostalCode, I.Total,
C.CustomerId, C.LastName AS CustomerLastName, IL.TrackId, IL.UnitPrice, IL.Quantity
FROM Invoice I
LEFT JOIN (Customer C, InvoiceLine IL)
ON I.CustomerId = C.CustomerId
AND I.InvoiceId = IL.InvoiceId
) I
LEFT JOIN Track T
ON I.TrackId = T.TrackId;