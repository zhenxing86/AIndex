USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_splendidphotos_GetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：取精彩相片
--项目名称：zgyeyblog
--说明：
--时间：2009-5-11 09:56:46
------------------------------------
CREATE PROCEDURE [dbo].[blog_splendidphotos_GetList]
AS


	SELECT top(9) photoid,categoriesid,filename,filepath,uploaddatetime,userid
from 	blog_splendidphotos_List
--FROM blog_splendidphotos t1 left JOIN album_photos t2 ON t1.photoid=t2.photoid
--	 left JOIN album_categories t4 ON t2.categoriesid=t4.categoriesid 
--	 left JOIN BasicData.dbo.user_bloguser t3 ON t4.userid=t3.bloguserid
--	 left join BasicData.dbo.[user] t5 on t3.userid=t5.userid
--	 WHERE t2.deletetag=1 and t4.deletetag=1 and t5.deletetag=1	
	ORDER BY uploaddatetime DESC






GO
