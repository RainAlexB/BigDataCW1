USE rb105;

SELECT E1.EmployeeId, CONCAT(E1.FirstName, " ", E1.LastName) AS EmployeeName, E1.Title, E1.BirthDate, E1.HireDate, 
CONCAT(E1.Address, " ", E1.City, " ", E1.State, " ", E1.Country, " ", E1.PostalCode) AS Address, E1.Phone, E1.Fax, E1.Email,
CONCAT(E2.FirstName, " ", E2.LastName) AS ReportsToName
FROM Employee E1
LEFT JOIN Employee E2
ON E1.ReportsTo = E2.EmployeeId;