USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[log_exists]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：判断是否有此日志
--项目名称：
--说明：
--时间：2011-7-1 15:29:16
------------------------------------
CREATE PROCEDURE [dbo].[log_exists]
@actiontypeid int,
@actionobjectid int,
@logtype int
 AS 
 	DECLARE @count int
	IF(@logtype=1)
	BEGIN
		select @count=count(1) from blog_log where actiontypeid=@actiontypeid and actionobjectid=@actionobjectid
	END
	ELSE IF(@logtype=2)
	BEGIN
		select @count=count(1) from class_log where actiontypeid=@actiontypeid and actionobjectid=@actionobjectid
	END
	
	IF(@count>0)
	BEGIN
		RETURN (1)
	END
	ELSE
	BEGIN
		RETURN (-1)
	END

GO
