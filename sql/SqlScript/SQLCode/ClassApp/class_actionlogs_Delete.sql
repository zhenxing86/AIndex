USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_actionlogs_Delete]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：删除日志记录
--项目名称：ZGYEYBLOG
--说明：
--时间：2009-3-26 13:12:52
------------------------------------
CREATE PROCEDURE [dbo].[class_actionlogs_Delete]
@objectid int,
@actionmodul int
 AS 
--	 DELETE Blog..class_actionlogs
--	 WHERE actionmodul=@actionmodul and objectid = @objectid
	
	IF @@ERROR <> 0 
	BEGIN		
	   RETURN(-1)
	END
	ELSE
	BEGIN		
	   RETURN 1
	END














GO
