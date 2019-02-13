USE rb105;

SELECT 
NEW_T.TrackId, NEW_T.Name, NEW_T.Composer, NEW_T.Milliseconds, NEW_T.Bytes,
NEW_T.AlbumTitle, NEW_T.Genre, NEW_T.ArtistName, NEW_T.UnitPrice,
P.PlaylistId, P.PlaylistName
FROM
(
	SELECT TrackId, Name, Composer, Milliseconds, Bytes, 
	T.AlbumTitle, Genre, UnitPrice, ArtistName 
	FROM
	(
	-- TRACK INFO
	SELECT T.TrackId, T.Name, T.Composer, T.Milliseconds, T.Bytes, 
	Al.AlbumId, Al.Title AS AlbumTitle, G.Name AS Genre, IL.UnitPrice
	FROM Track T
	LEFT JOIN (Album Al, Genre G, InvoiceLine IL)
	ON T.AlbumId = Al.AlbumId
	AND T.GenreId = G.GenreId
	AND T.TrackId = IL.TrackId
	) T
	LEFT JOIN
	(
	-- ARTIST INFO
	SELECT A.ArtistId, A.Name AS ArtistName, 
	Al.AlbumId, Al.Title AS AlbumTitle
	FROM Album Al
	LEFT JOIN Artist A
	ON Al.ArtistId = A.ArtistId
	ORDER BY A.ArtistId
	) A
	ON T.AlbumId = A.AlbumId
) NEW_T
LEFT JOIN
(
-- PLAYLIST INFO
SELECT PT.PlaylistId, P.Name AS PlaylistName, PT.TrackId
FROM PlaylistTrack PT
LEFT JOIN (Playlist P, Track T)
ON PT.PlaylistId = P.PlaylistId
AND PT.TrackId = T.TrackId
ORDER BY P.PlaylistId
) P
ON P.TrackId = NEW_T.TrackId;