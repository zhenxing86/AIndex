USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[blog_log_Update]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：更新博客应用日志记录
--项目名称：
--说明：
--时间：2011-7-1 15:29:16
------------------------------------
CREATE PROCEDURE [dbo].[blog_log_Update]
@actionuserid int,
@actionusername nvarchar(20),
@actiontypeid int,
@actionobjectid int,
@actiondesc nvarchar(200),
@touserid int,
@tousername nvarchar(20)

 AS 
	UPDATE [blog_log] SET [actionuserid]=@actionuserid,[actionusername]=@actionusername,[actiondesc]=@actiondesc,[actiondatetime]=getdate(),[touserid]=@touserid,[tousername]=@tousername
	WHERE actiontypeid=@actiontypeid and actionobjectid=@actionobjectid

IF(@@error<>0)
begin
	return (-1)
end
else
begin
	return (1)
end

GO
