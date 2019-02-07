USE rb105;

SELECT IL.InvoiceLineId, IL.UnitPrice, IL.Quantity,
I.InvoiceId, T.Name AS TrackName
FROM InvoiceLine IL
LEFT JOIN (Invoice I, Track T)
ON IL.InvoiceId = I.InvoiceId
AND IL.TrackId = T.TrackId;