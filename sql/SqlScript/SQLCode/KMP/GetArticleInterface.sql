USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetArticleInterface]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,园所新闻列表>
-- =============================================
CREATE PROCEDURE [dbo].[GetArticleInterface] 

AS
BEGIN
	SET NOCOUNT ON;
SELECT top 100     dbo.Articles.Title as 标题,dbo.Articles.CreateDate as 发表时间,  dbo.T_Kindergarten.Name as 幼儿园, 
                      'http://www.zgyey.com/v'+rtrim(convert(char(200),dbo.Articles.ArticleID))+'.html' AS 地址
FROM         dbo.Articles LEFT OUTER JOIN
                      dbo.ArticleCategory ON dbo.Articles.ArticleCategoryID = dbo.ArticleCategory.ArticleCategoryID RIGHT OUTER JOIN
                      dbo.T_Kindergarten ON dbo.ArticleCategory.Kid = dbo.T_Kindergarten.ID
WHERE     ((dbo.Articles.PortalShow = 1) AND (dbo.ArticleCategory.TypeCode = 'xw') and (dbo.T_Kindergarten.privince = 245)) OR
                      ((dbo.Articles.PortalShow = 1) AND (dbo.ArticleCategory.TypeCode = 'gg') and (dbo.T_Kindergarten.privince = 245) )
order by dbo.Articles.createdate desc

END



GO
