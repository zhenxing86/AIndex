USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_cms_content_content_GetCountByTitleAndDateTime]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		along
-- Create date: 2009-12-26
-- Description:	获取分页读取门户分类文章数据数量
--exec [mh_cms_content_content_GetCountByTitleAndDateTime] '2008-01-01', '2009-12-28',63292,''
-- =============================================
CREATE PROCEDURE [dbo].[mh_cms_content_content_GetCountByTitleAndDateTime]
@startdatetime Datetime,
@enddatetime Datetime,
@categoryid int,
@title nvarchar(50)
AS
BEGIN
	DECLARE @count int

	DECLARE @categorycode nvarchar(20)
	SELECT @categorycode=categorycode from cms_category where categoryid=@categoryid and siteid=18

	SELECT @count=count(1) FROM mh_content_content_relation t1,cms_content t2
		WHERE t1.categorycode=@categorycode AND t1.s_contentid=t2.contentid
		AND (t2.createdatetime BETWEEN @startdatetime AND @enddatetime)
		AND t1.s_contentid NOT IN (SELECT contentid FROM mh_subcontent_relation)
		AND	(t2.title LIKE '%'+@title+'%') and t2.deletetag = 1
	RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_cms_content_content_GetCountByTitleAndDateTime', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
