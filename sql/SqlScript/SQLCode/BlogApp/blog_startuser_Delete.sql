USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_startuser_Delete]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：取消明星博客首页显示日志
--项目名称：zgyeyblog
--说明：
--时间：2009-4-28 16:55:19
------------------------------------
CREATE PROCEDURE [dbo].[blog_startuser_Delete]
@userid int,
@postid int
 AS 
	DELETE  blog_startuser  WHERE postid=@postid and userid=@userid

	
	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END





GO
