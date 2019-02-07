USE rb105;

SELECT Al.AlbumId, Al.Title,
Ar.Name AS ArtistName
FROM Album Al
LEFT JOIN Artist Ar
ON Al.ArtistId = Ar.ArtistId;