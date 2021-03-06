USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_splendidalbum_GetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-06
-- Description: 取精彩相册	
-- Memo:
*/
CREATE PROCEDURE [dbo].[blog_splendidalbum_GetList]
AS
	SELECT	t2.categoriesid,t2.title,t2.userid,t5.nickname,t2.photocount,
					t2.coverphoto as coverphoto,t2.coverphotodatetime as coverphotoupdatetime
    FROM blog_splendidalbum t1 
			INNER JOIN album_categories t2 ON t1.categoriesid = t2.categoriesid
			INNER JOIN BasicData.dbo.user_bloguser t3 ON t2.userid = t3.bloguserid
			inner join BasicData.dbo.[user] t5 on t3.userid = t5.userid
	WHERE t2.deletetag = 1 
		and t5.deletetag = 1	
	ORDER BY t1.actiontime DESC

GO
