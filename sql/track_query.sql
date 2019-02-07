USE rb105;

SELECT T.TrackId, T.Name, T.Composer, T.Milliseconds, T.Bytes, T.UnitPrice,
A.Title AS AlbumTitle, M.Name AS MediaTypeName, G.Name AS GenreName
FROM Track T
LEFT JOIN (Genre G, MediaType M, Album A)
ON T.AlbumId = A.AlbumId
AND T.MediaTypeId = M.MediaTypeId
AND T.GenreId = G.GenreId;