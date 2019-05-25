USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_photos_UpdateIsFlashShow]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：修改相片首页动态显示选项
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 11:50:29
------------------------------------
CREATE PROCEDURE  [dbo].[class_photos_UpdateIsFlashShow]
@photoid int
 AS 
	DECLARE @isflashshow int
	SELECT @isflashshow=isfalshshow FROM class_photos 
	WHERE photoid=@photoid	

	IF(@isflashshow=0)
	BEGIN
		UPDATE class_photos SET 
		isfalshshow = 1
		WHERE photoid=@photoid 
	END
	ELSE
	BEGIN
		UPDATE class_photos SET 
		isfalshshow = 0
		WHERE photoid=@photoid 
	END

	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN(-1)
	END
	ELSE
	BEGIN		
	   RETURN (1)
	END










GO
