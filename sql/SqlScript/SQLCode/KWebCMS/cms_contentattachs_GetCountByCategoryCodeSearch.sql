USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachs_GetCountByCategoryCodeSearch]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-06
-- Description:	GetCount
-- =============================================
CREATE PROCEDURE [dbo].[cms_contentattachs_GetCountByCategoryCodeSearch]
@categorycode nvarchar(20),
@sitename nvarchar(50),
@siteid int,
@regStartTime datetime,
@regEndTime datetime,
@searchtype int
AS
BEGIN	
	DECLARE @count int
	SELECT @count=count(*) FROM cms_contentattachs t1,cms_category t2,site t3 
	WHERE t1.categoryid=t2.categoryid AND t2.categorycode=@categorycode AND t2.siteid=t3.siteid and t1.deletetag = 1
	AND 
	(
		(t3.[name] LIKE '%'+@sitename+'%' AND @searchtype=1) 
			OR 
		(t3.siteid=@siteid AND @searchtype=2) 
			OR 
		((t1.createdatetime BETWEEN @regStartTime AND @regEndTime) AND @searchtype=3)
	)
	AND contentattachsid NOT IN (SELECT attachid FROM portalattach)
	RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_contentattachs_GetCountByCategoryCodeSearch', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_contentattachs_GetCountByCategoryCodeSearch', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
