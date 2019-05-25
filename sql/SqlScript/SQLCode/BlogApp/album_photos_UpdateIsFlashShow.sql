USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_photos_UpdateIsFlashShow]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：修改相片首页动态显示选项
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-14 15:18:00
------------------------------------
CREATE PROCEDURE [dbo].[album_photos_UpdateIsFlashShow]
@photoid int,
@isflashshow int
 AS 
	UPDATE album_photos SET 
	[isflashshow] = @isflashshow
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
