USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_cms_subcategory_content_GetCountByTitleAndDateTime]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		along
-- Create date: 2009-12-26
-- Description:	获取分页读取门户分类文章数据数量
--exec [mh_cms_subcategory_content_GetCountByTitleAndDateTime] '2008-10-01','2009-10-30',63283,11,''
-- =============================================
CREATE PROCEDURE [dbo].[mh_cms_subcategory_content_GetCountByTitleAndDateTime]
@startdatetime Datetime,
@enddatetime Datetime,
@categoryid int,
@subcategoryid int,
@title nvarchar(50)
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM cms_content t1,mh_subcontent_relation t2
	 WHERE t1.categoryid=@categoryid
		AND (t1.createdatetime BETWEEN @startdatetime AND @enddatetime)		
		AND t2.subcategoryid = @subcategoryid
		and t1.contentid = t2.contentid
		AND	(t1.title LIKE '%'+@title+'%') and t1.deletetag = 1
	RETURN @count
END

GO
