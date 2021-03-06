USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_BlogAlbumPhotosGetListCount]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：按日期获取日志评论列表数
--项目名称：zgyeyblog
--说明：
--时间：2009-5-7 10:01:19
------------------------------------
CREATE PROCEDURE [dbo].[Manage_BlogAlbumPhotosGetListCount]
@begintime datetime,
@endtime datetime
 AS 	
	DECLARE @Temp int
	SELECT @Temp=count(1) FROM album_photos t1 INNER JOIN album_categories t2 ON t1.categoriesid=t2.categoriesid 
	INNER JOIN basicdata.dbo.user_bloguser t3 ON t2.userid=t3.bloguserid
			inner join basicdata.dbo.[user] t4 on t3.userid=t4.userid
		WHERE  t4.deletetag=1 and t1.uploaddatetime BETWEEN @begintime AND @endtime
	RETURN @Temp



GO
