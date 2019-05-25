USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_splendidposts_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[blog_splendidposts_GetList]
@usertype int
 AS 
	SELECT top 1 t1.postid,t1.author,t1.userid,t1.title,t1.content 
	FROM blogapp..blog_posts t1 INNER JOIN blogapp..blog_splendidposts t2 ON t1.postid=t2.postid
	WHERE t2.usertype=@usertype

GO
