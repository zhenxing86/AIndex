USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[blog_zgyey_messagebox_Delete]    Script Date: 08/28/2013 14:42:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除门户发送短信息 
--项目名称：ZGYEYBLOG
--说明：
--时间：2010-05-15 11:07:33
------------------------------------
CREATE PROCEDURE [dbo].[blog_zgyey_messagebox_Delete]
@messageboxid int,
@userid int
 AS 
	INSERT INTO blog_zgyey_messageboxdelete(messageboxid,userid,deletetime)values(@messageboxid,@userid,getdate())

	IF @@ERROR <> 0 
	BEGIN 
		RETURN(-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END
GO
