USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_hotposts_GetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-29
-- Description:	取热门推荐列表
-- Memo:		
*/
CREATE PROCEDURE [dbo].[blog_hotposts_GetList]
	@hottype int
 AS
BEGIN  
	SET NOCOUNT ON
	SELECT	top 10	hotpostid, maintitle, subtitle, 
					mainurl, suburl, orderno, posttype, createdate
		FROM blog_hotposts 
		where hottype = @hottype 
			 or hottype = 3
		ORDER BY istop desc, createdate desc
END

GO
