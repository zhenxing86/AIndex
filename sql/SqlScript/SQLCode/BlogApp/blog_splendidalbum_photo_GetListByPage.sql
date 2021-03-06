USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_splendidalbum_photo_GetListByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-08
-- Description:	取精彩相册
-- Memo:
blog_splendidalbum_photo_GetListByPage 1,10
*/  
CREATE PROCEDURE [dbo].[blog_splendidalbum_photo_GetListByPage] 
	@page int,  
	@size int  
AS    
BEGIN
	SET NOCOUNT ON
  DECLARE @beginRow INT
  DECLARE @endRow INT
  DECLARE @pcount INT

	IF @page > 1	
	BEGIN	
		SET @beginRow = (@page - 1) * @size    + 1
		SET @endRow = @page * @size	
				
		SELECT  photoid, categoriesid, title, filename, filepath, uploaddatetime, userid, nickname  
		FROM 
		(
			SELECT	ROW_NUMBER() OVER(order by bs.actiontime DESC) AS rows,
							ap.photoid, ap.categoriesid, ap.title, ap.filename, 
							ap.filepath, ap.uploaddatetime, ac.userid, u.nickname  
				FROM blog_splendidphotos bs 
					INNER JOIN album_photos ap ON bs.photoid = ap.photoid  
					INNER JOIN album_categories ac ON ap.categoriesid = ac.categoriesid   
					INNER JOIN BasicData.dbo.user_bloguser ub ON ac.userid = ub.bloguserid  
					inner join BasicData.dbo.[user] u on ub.userid = u.userid  
				WHERE ap.deletetag = 1 
					and ac.deletetag = 1 
					and u.deletetag = 1   
		) AS main_temp 
		WHERE rows BETWEEN @beginRow AND @endRow
	END  
	ELSE 
	BEGIN
		SET ROWCOUNT @size  
		SELECT	ap.photoid, ap.categoriesid, ap.title, ap.filename, 
						ap.filepath, ap.uploaddatetime, ac.userid, u.nickname  
			FROM blog_splendidphotos bs 
				INNER JOIN album_photos ap ON bs.photoid = ap.photoid  
				INNER JOIN album_categories ac ON ap.categoriesid = ac.categoriesid   
				INNER JOIN BasicData.dbo.user_bloguser ub ON ac.userid = ub.bloguserid  
				inner join BasicData.dbo.[user] u on ub.userid = u.userid  
			WHERE ap.deletetag = 1 
				and ac.deletetag = 1 
				and u.deletetag = 1    
		ORDER BY bs.actiontime DESC 
	END   

END

GO
