USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_hotposts_Update]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：修改热门推荐
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-03 16:37:29
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[blog_hotposts_Update]
@hotpostid int,
@maintitle nvarchar(100),
@subtitle nvarchar(100),
@mainurl nvarchar(200),
@suburl nvarchar(200),
@posttype int
 AS 
	UPDATE blog_hotposts SET 
	[maintitle] = @maintitle,[subtitle] = @subtitle,[mainurl] = @mainurl,
	[suburl] = @suburl,[posttype] = @posttype,[createdate] = getdate()
	WHERE hotpostid=@hotpostid 






GO
