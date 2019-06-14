USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messageboardreply_GetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：取留言列表 
--项目名称：zgyeyblog
--说明：
--时间：2009-01-04 16:47:24
------------------------------------
CREATE PROCEDURE [dbo].[blog_messageboardreply_GetList]
@parentid int
 AS 
	SELECT 
	messageboardid,userid,fromuserid,author,content,msgstatus,msgdatetime,parentid
	 FROM blog_messageboard
	WHERE  parentid=@parentid
	ORDER BY msgdatetime desc






GO
