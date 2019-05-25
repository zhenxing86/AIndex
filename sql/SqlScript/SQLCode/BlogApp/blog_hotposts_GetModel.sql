USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_hotposts_GetModel]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：得到热门推荐实体对象的详细信息 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-03 16:37:29
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[blog_hotposts_GetModel]
@hotpostid int
 AS 
	SELECT 
	hotpostid,maintitle,subtitle,mainurl,suburl,orderno,posttype,createdate
	 FROM blog_hotposts
	 WHERE hotpostid=@hotpostid 






GO
