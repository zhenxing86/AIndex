USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_photos_GetFlashShow]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-25
-- Description:	得到首页动态显示的班级相片
-- Memo:
exec [class_photos_GetFlashShow] 201	
*/
CREATE PROCEDURE [dbo].[class_photos_GetFlashShow]
	@classid int
AS
BEGIN 
	SET NOCOUNT ON
	SELECT	top(5) cp.photoid, cp.albumid, cp.title, cp.filename, 
					cp.filepath, cp.uploaddatetime, cp.net
		FROM class_photos cp 
			inner join class_album ca 
				on cp.albumid = ca.albumid
		WHERE cp.cid = @classid 
			and cp.isfalshshow = 1
			and cp.[status]=1
			and ca.[status]=1
		ORDER BY cp.photoid desc
END

GO
