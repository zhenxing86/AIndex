USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_backgroundmusic_Update]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：设置默认班级背景音乐
--项目名称：CodematicDemo
--说明：
--时间：2009-1-15 16:21:36
------------------------------------
CREATE PROCEDURE [dbo].[class_backgroundmusic_Update]
@id int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION	

	DECLARE @classid int
	SELECT @classid=classid FROM class_backgroundmusic 
	 WHERE id=@id
	
	UPDATE class_backgroundmusic SET 
	isdefault=0 
	WHERE classid=@classid

	UPDATE class_backgroundmusic SET 
	isdefault = 1
	WHERE id=@id

	IF @@ERROR <> 0 
	BEGIN 		
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN		
		COMMIT TRANSACTION
	   RETURN (1)
	END













GO
