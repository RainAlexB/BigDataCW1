USE rb105;

SELECT PT.PlaylistId, PT.TrackId,
P.Name AS PlaylistName, T.Name AS TrackName
FROM PlaylistTrack PT
LEFT JOIN (Playlist P, Track T)
ON PT.PlaylistId = P.PlaylistId
AND PT.TrackId = T.TrackId;