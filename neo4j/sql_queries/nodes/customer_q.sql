USE rb105;

SELECT CustomerId, CONCAT(FirstName, " ", LastName) AS Name, Company, 
CONCAT(Address, " ", City, " ", COALESCE(State, ''), " ", Country, " ", COALESCE(PostalCode, '')) AS Address,
Phone, Fax, Email
FROM Customer;
