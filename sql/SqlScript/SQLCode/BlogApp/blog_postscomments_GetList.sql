USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_postscomments_GetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：取日记评论列表
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-02 13:56:50
------------------------------------
CREATE PROCEDURE [dbo].[blog_postscomments_GetList]
@postid int
 AS 
	SELECT 
	commentsid,postsid,fromuserid,author,commentdatetime,content,parentid
	 FROM blog_postscomments
	WHERE postsid=@postid
	ORDER BY commentdatetime desc






GO
