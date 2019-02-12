USE rb105;

SELECT EmployeeId, CONCAT(FirstName, " ", LastName) AS Name, Title, BirthDate, HireDate,
CONCAT(Address, " ", City, " ", COALESCE(State, ''), " ", Country, " ", COALESCE(PostalCode, '')) AS Address,
Phone, Fax, Email FROM Employee;