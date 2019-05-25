USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_photos_UpdateTitle]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：修改相片标题
--项目名称：zgyeyblog
--说明：
--时间：2008-09-28 23:17:42
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[album_photos_UpdateTitle]
@photoid int,
@title nvarchar(100)
 AS 
	UPDATE album_photos SET 
	[title] = @title
	WHERE photoid=@photoid 
	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END






GO
