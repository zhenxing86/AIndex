USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_cms_content_GetCountBySearchDateTime]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-23
-- Description:	根据时间获取文章数量
-- =============================================
CREATE PROCEDURE [dbo].[mh_cms_content_GetCountBySearchDateTime]
@startdatetime Datetime,
@enddatetime Datetime,
@title nvarchar(20),
@content nvarchar(20)
AS
BEGIN	
	DECLARE @count int
	SELECT @count=count(*) FROM cms_content
	WHERE (createdatetime BETWEEN @startdatetime AND @enddatetime) and deletetag = 1
	AND categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode='XW' OR categorycode='GG')	
	AND title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
	AND contentid not in (SELECT s_contentid FROM mh_content_content_relation)
	--AND ([content] LIKE '%'+@content+'%')
	AND (title LIKE '%'+@title+'%')
	RETURN @count
END

GO
