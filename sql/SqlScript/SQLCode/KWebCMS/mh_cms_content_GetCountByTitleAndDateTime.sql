USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_cms_content_GetCountByTitleAndDateTime]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		along
-- Create date: 2009-12-26
-- Description:	获取分页读取门户分类文章数据数量
-- =============================================
CREATE PROCEDURE [dbo].[mh_cms_content_GetCountByTitleAndDateTime]
@startdatetime Datetime,
@enddatetime Datetime,
@categoryid int,
@title nvarchar(50)
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM cms_content WHERE categoryid=@categoryid and deletetag = 1
		AND (createdatetime BETWEEN @startdatetime AND @enddatetime)
		AND [contentid] NOT IN (SELECT contentid FROM mh_subcontent_relation)
		AND	(title LIKE '%'+@title+'%')
	RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_cms_content_GetCountByTitleAndDateTime', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
