USE rb105;

SELECT A.ArtistId, A.Name, 
Al.AlbumId, Al.Title AS AlbumTitle
FROM Album Al
LEFT JOIN Artist A
ON Al.ArtistId = A.ArtistId
ORDER BY A.ArtistId;