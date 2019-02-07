USE rb105;

SELECT C.CustomerId, CONCAT(C.FirstName, " ", C.LastName) AS CustomerName, C.Company, 
CONCAT(C.Address, " ", C.City, " ", COALESCE(C.State, ''), " ", C.Country, " ", COALESCE(C.PostalCode, '')) AS Address, 
C.Phone, C.Fax, C.Email,
CONCAT(E.FirstName, " ", E.LastName) AS SupportRepName
FROM Customer C
LEFT JOIN Employee E
ON C.SupportRepId = E.EmployeeId;