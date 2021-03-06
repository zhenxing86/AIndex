USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_article_GetModel]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：得到班级文章的详细信息 
--项目名称：ClassHomePage
--说明：
--时间：2009-5-13 14:43:20
------------------------------------
CREATE PROCEDURE [dbo].[class_article_GetModel]
@articleid int,
@userid int

 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	UPDATE [class_article] SET viewcount=viewcount+1 WHERE articleid =@articleid

	SELECT 
		articleid,diycategoryid,title,userid,author,classid,kid,content,publishdisplay,createdatetime,viewcount,commentcount
	 FROM class_article
	 WHERE articleid =@articleid



	
	--DECLARE @readcount INT
	--SELECT @readcount=count(1) FROM class_readlogs 
	--WHERE userid=@userid AND objectid=@articleid AND objecttype=4
	--IF(@readcount=0 and @userid<>0)
	--BEGIN
	--	EXEC class_readlogs_ADD @userid,@articleid,4
	--END

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
