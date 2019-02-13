USE rb105;

SELECT Al.*, 
T.TrackId, T.Name AS TrackName
FROM 
(
SELECT Al.AlbumId, Al.Title, A.Name as ArtistName
FROM Album Al
LEFT JOIN Artist A
ON Al.ArtistId = A.ArtistId
) Al
LEFT JOIN Track T
ON Al.AlbumId = T.AlbumId;