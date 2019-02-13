USE rb105;

SELECT C.*, I.InvoiceId
FROM
(
SELECT C.CustomerId, C.FirstName, C.LastName, C.Company, 
C.Address AS Street, C.City, C.State, C.Country, C.PostalCode, C.Phone, C.Fax, C.Email,
C.SupportRepId, E.LastName AS SupportRepLastName
FROM Customer C
LEFT JOIN Employee E
ON C.SupportRepId = E.EmployeeId
) C
LEFT JOIN Invoice I
ON C.CustomerId = I.CustomerId;