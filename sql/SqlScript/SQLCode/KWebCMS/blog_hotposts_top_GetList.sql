USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_hotposts_top_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：取热门推荐 
--项目名称：ZGYEYBLOG
--说明：
--时间：2009-4-27 16:37:29
------------------------------------
CREATE PROCEDURE [dbo].[blog_hotposts_top_GetList]
@hottype int
 AS 
		SELECT top 9
		t1.hotpostid,t1.maintitle,t1.subtitle,t1.mainurl,t1.suburl,t1.orderno,t1.posttype,t1.createdate,t2.content
		 FROM blogapp..blog_hotposts t1 INNER JOIN blogapp..blog_posts t2 ON t1.postid=t2.postid  WHERE hottype=@hottype
		ORDER BY t1.istop desc, t1.createdate desc






GO
