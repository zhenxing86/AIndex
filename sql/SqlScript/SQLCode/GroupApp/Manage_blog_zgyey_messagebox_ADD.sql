USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_blog_zgyey_messagebox_ADD]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：增加门户消息 
--项目名称：Manage
--说明：
--时间：2010-5-14 15:57:26
------------------------------------
CREATE PROCEDURE [dbo].[Manage_blog_zgyey_messagebox_ADD]
@sendtype int,
@msgtitle nvarchar(30),
@msgcontent ntext

 AS 
	DECLARE @messageboxid int
	INSERT INTO [blog_zgyey_messagebox](
	[sendtype],[msgtitle],[msgcontent],[sendtime]
	)VALUES(
	@sendtype,@msgtitle,@msgcontent,getdate()
	)
	SET @messageboxid = @@IDENTITY

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (@messageboxid)
END

GO
