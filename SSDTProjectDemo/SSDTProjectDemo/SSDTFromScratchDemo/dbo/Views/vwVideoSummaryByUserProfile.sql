CREATE VIEW [dbo].[vwVideoSummaryByUserProfile]
AS
SELECT up.ID,
       IsNull(tc.TotalClips, 0) AS TotalClips,
       IsNull(tvc.TotalVstratedClips, 0) AS TotalVstratedClips,
       IsNull(nc.NewClips, 0) AS NewClips,
       IsNull(nvc.NewVstratedClips, 0) AS NewVstratedClips,
       IsNull(pcv.PublicClips, 0) AS PublicClips,
       IsNull(psv.PublicVstratedClips, 0) AS PublicVstratedClips
FROM   UserProfiles AS up
       LEFT OUTER JOIN
       vwTotalClipsByUserProfile AS tc
       ON up.ID = tc.UserProfileID
       LEFT OUTER JOIN
       vwTotalVstratedClipsByUserProfile AS tvc
       ON up.id = tvc.UserProfileID
       LEFT OUTER JOIN
       vwNewClipsByUserProfile AS nc
       ON up.ID = nc.UserProfileID
       LEFT OUTER JOIN
       vwNewVstratedClipsByUserProfile AS nvc
       ON up.ID = nvc.UserProfileID
       LEFT OUTER JOIN
       vwTotalPublicClipsByUserProfile AS pcv
       ON up.ID = pcv.UserProfileID
       LEFT OUTER JOIN
       vwTotalPublicVstratedClipsByUserProfile AS psv
       ON up.ID = psv.UserProfileID
WHERE  up.ID <> '00000000-0000-0000-0000-000000000000';