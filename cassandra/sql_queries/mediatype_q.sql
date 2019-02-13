USE rb105;

SELECT MT.MediaTypeId, MT.Name, 
T.TrackId, T.Name AS TrackName
FROM MediaType MT
LEFT JOIN Track T
ON T.MediaTypeId = MT.MediaTypeId;