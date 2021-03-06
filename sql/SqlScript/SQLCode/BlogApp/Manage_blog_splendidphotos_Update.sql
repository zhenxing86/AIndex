USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_blog_splendidphotos_Update]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：精彩照片添加
--项目名称：zgyeyblog
--说明：
--时间：2009-5-9 16:55:19
------------------------------------
CREATE PROCEDURE [dbo].[Manage_blog_splendidphotos_Update]
@photoid int,
@categoriesid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	IF(dbo.IsSplendidPhoto(@photoid,@categoriesid)=0)
	BEGIN
--		DECLARE @count int	
--		SELECT @count=count(1) FROM blog_splendidphotos 
--		IF(@count>8)
--		BEGIN
--			DELETE blog_splendidphotos WHERE actiontime=(SELECT MIN(actiontime) FROM blog_splendidphotos)
--		END
		INSERT INTO blog_splendidphotos(photoid,categoriesid,actiontime) values(@photoid,@categoriesid,getdate())
	END
	ELSE
	BEGIN
		DELETE blog_splendidphotos WHERE photoid=@photoid and categoriesid=@categoriesid
	END

	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN (-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN (1)
	END



GO
