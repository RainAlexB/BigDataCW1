USE rb105;

SELECT InvoiceId, InvoiceDate, 
CONCAT(BillingAddress, " ", BillingCity, " ", COALESCE(BillingState, ''), " ", BillingCountry, COALESCE(BillingPostalCode, '')) 
AS BillingAddress, Total 
FROM Invoice;