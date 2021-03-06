USE ClassApp
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter view v_album
 WITH SCHEMABINDING
as
SELECT     albumid, title, description, photocount, classid, kid, userid, author, createdatetime, coverphoto AS defaultcoverphoto, coverphoto, 
                      dbo.IsNewAlbum(albumid, 0) AS newalbum, 0 AS isblogalbum, coverphotodatetime AS defaultphotodatetime, coverphotodatetime
FROM         dbo.class_album AS t1
WHERE     (status = 1)

GO
