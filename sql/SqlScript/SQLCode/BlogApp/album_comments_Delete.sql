USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_comments_Delete]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：删除相片评论
--项目名称：zgyeyblog
--说明：
--时间：2008-09-29 07:54:31
--作者：along
-- exec album_comments_Delete 84
------------------------------------
CREATE PROCEDURE [dbo].[album_comments_Delete]
@photocommentid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	
	
	--更新照片评论数量
	--declare @photocommentid int
	--set @photocommentid=85
	DECLARE @photoid int
	SELECT @photoid=photoid FROM album_comments WHERE photocommentid=@photocommentid 
	--print @photoid
	UPDATE album_photos SET [commentcount]=[commentcount]-1
	 WHERE photoid=@photoid

	DELETE album_comments WHERE photocommentid=@photocommentid 	

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
