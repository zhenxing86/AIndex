USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_autoaddphotocount]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：自动更新相片,日记察看数
--项目名称：zgyeyblog
--说明：
--时间：2008-10-13 06:55:19
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[album_autoaddphotocount]
 AS 

	update album_photos set viewcount=viewcount+1 where viewcount<3

	--select * From blog_posts where viewcounts<20	and title <> '我的博客开通啦'

	update blog_posts set viewcounts=viewcounts+1 where viewcounts<4	and title <> '我的博客开通啦'



GO
