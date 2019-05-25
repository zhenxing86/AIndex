USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_blog_posts_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-22
-- Description:	获取精彩文章数量
--
-- =============================================
CREATE PROCEDURE [dbo].[kweb_blog_posts_GetCount]
@siteid int
AS
BEGIN
	DECLARE @count int 
	SELECT @count=count(1)
	FROM
    [blog_posts_list]
	where siteid=@siteid
	
	RETURN @count
END








GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_blog_posts_GetCount', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
