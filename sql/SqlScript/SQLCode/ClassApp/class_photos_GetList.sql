USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_photos_GetList]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：得到最新的班级相片 
--项目名称：ClassHomePage
--说明：
--时间：2009-02-05 14:04:55
------------------------------------
CREATE PROCEDURE [dbo].[class_photos_GetList] 
	@classid int
 AS 
BEGIN
	SET NOCOUNT ON
	SELECT	top(10) cp.photoid, cp.albumid, cp.title, cp.filename, 
					cp.filepath,orderno, cp.uploaddatetime, cp.net
		FROM class_photos cp 
			INNER JOIN class_album ca 
				on cp.albumid = ca.albumid 
				and ca.status = 1 and ca.classid=@classid
		WHERE cp.cid = @classid 
			and cp.status = 1
		ORDER BY cp.photoid desc
END

GO
