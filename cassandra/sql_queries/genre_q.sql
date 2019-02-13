USE rb105;

SELECT G.GenreId, G.Name, 
T.TrackId, T.Name AS TrackName
FROM Genre G
LEFT JOIN Track T
ON T.MediaTypeId = G.GenreId;