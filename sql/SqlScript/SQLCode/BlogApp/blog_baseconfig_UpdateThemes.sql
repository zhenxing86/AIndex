USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_baseconfig_UpdateThemes]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途： 更换模板 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-5 16:28:40
------------------------------------
CREATE PROCEDURE [dbo].[blog_baseconfig_UpdateThemes]
@userid int,
@themeid int

 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	UPDATE blog_baseconfig SET
	themes=@themeid 
	WHERE userid=@userid
	
	UPDATE blog_theme SET
	usecount=usecount+1
	WHERE themeid=@themeid

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
