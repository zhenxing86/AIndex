USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_photocomments_Delete]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：删除相片评论 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 15:01:54
------------------------------------
create PROCEDURE [dbo].[class_photocomments_Delete]
@photocommentid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE @photoid int
	SELECT @photoid=photoid FROM class_photocomments WHERE photocommentid=@photocommentid 
	
	UPDATE class_photos SET [commentcount]=[commentcount]-1
	 WHERE photoid=@photoid

	UPDATE class_photocomments SET status=-1 WHERE photocommentid=@photocommentid
 
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
