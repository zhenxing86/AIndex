USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_doccomment_Delete]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：删除文档评论
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-06 22:57:51
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[thelp_doccomment_Delete]
@doccommentid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	--更新文档评论数
	
	DELETE thelp_doccomment
	 WHERE doccommentid=@doccommentid 

	
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
