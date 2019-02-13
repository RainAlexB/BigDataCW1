USE rb105;

SELECT E.*,
C.CustomerId, C.LastName AS CustomerLastName
FROM
(
SELECT E1.EmployeeId, E1.FirstName, E1.LastName, E1.Title, E1.BirthDate, E1.HireDate, 
E1.Address AS Street, E1.City, E1.State, E1.Country, E1.PostalCode, E1.Phone, E1.Fax, E1.Email,
E1.EmployeeId AS ReportsToId, E2.LastName AS ReportsToLastName
FROM Employee E1
LEFT JOIN Employee E2
ON E1.ReportsTo = E2.EmployeeId
) E
LEFT JOIN Customer C
ON E.EmployeeId = C.SupportRepId;