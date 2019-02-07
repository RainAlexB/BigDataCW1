USE rb105;

SELECT I.InvoiceId, I.InvoiceDate, 
CONCAT(I.BillingAddress, " ", I.BillingCity, " ", COALESCE(I.BillingState, ''), " ", I.BillingCountry, " ", COALESCE(I.BillingPostalCode, '')) AS BillingAddress, 
I.Total, 
CONCAT(C.FirstName, " ", C.LastName) AS CustomerName
FROM Invoice I
LEFT JOIN Customer C
ON I.CustomerId = C.CustomerId;