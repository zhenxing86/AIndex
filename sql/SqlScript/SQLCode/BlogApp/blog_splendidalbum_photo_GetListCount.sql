USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_splendidalbum_photo_GetListCount]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-08
-- Description:	取精彩相册数
-- Memo:
DECLARE @count INT
EXEC  @count=blog_splendidalbum_photo_GetListCount
SELECT @count
*/  
CREATE PROCEDURE [dbo].[blog_splendidalbum_photo_GetListCount]
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @count INT
	SELECT @count = COUNT(1) 	
		FROM blog_splendidphotos bs 
			INNER JOIN album_photos ap ON bs.photoid = ap.photoid
			INNER JOIN album_categories ac ON ap.categoriesid = ac.categoriesid 
			INNER JOIN BasicData.dbo.user_bloguser ub ON ac.userid = ub.bloguserid
			inner join BasicData.dbo.[user] u on ub.userid = u.userid
		WHERE ap.deletetag = 1 
			and ac.deletetag = 1 
			and u.deletetag = 1	
	RETURN @count
END

GO
