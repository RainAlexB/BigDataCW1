USE rb105;

SELECT EmployeeId, ReportsTo FROM Employee WHERE ReportsTo IS NOT NULL;