USE rb105;

SELECT PT.PlaylistId, P.Name AS PlaylistName, PT.TrackId, T.Name AS TrackName
FROM PlaylistTrack PT
LEFT JOIN (Playlist P, Track T)
ON PT.PlaylistId = P.PlaylistId
AND PT.TrackId = T.TrackId
ORDER BY P.PlaylistId;