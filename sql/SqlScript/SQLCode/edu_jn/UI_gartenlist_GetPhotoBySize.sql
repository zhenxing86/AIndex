USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[UI_gartenlist_GetPhotoBySize]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UI_gartenlist_GetPhotoBySize]
@size int
 AS 
	 select top 10 t3.albumid,t3.title,t3.filepath,t3.[filename]
 from [gartenlist] t1 
inner join KWebCMS..cms_album t2 on t2.siteid = t1.kid and t2.deletetag = 1
inner join KWebCMS..cms_photo t3 on t2.albumid=t3.albumid and t3.deletetag = 1 order by t3.createdatetime

GO
