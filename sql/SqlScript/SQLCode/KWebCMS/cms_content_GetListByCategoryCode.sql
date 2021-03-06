USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_GetListByCategoryCode]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-03
-- Description:	根据categorycode搜索文章
-- =============================================
CREATE PROCEDURE [dbo].[cms_content_GetListByCategoryCode]
@categorycode nvarchar(20),
@page int,
@size int
AS
BEGIN	
	IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) SELECT [contentid] FROM cms_content 
		WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode=@categorycode) and deletetag = 1
		ORDER BY contentid DESC

		SET ROWCOUNT @size
		SELECT c.[contentid],c.[categoryid],c.[content],c.[title],c.[titlecolor],c.[author],c.[createdatetime],sitedns,t3.siteid,name 
		FROM cms_content c,@tmptable,cms_category t2,site t3
		WHERE c.categoryid=t2.categoryid AND t2.siteid=t3.siteid AND c.[contentid]=tmptableid AND row > @ignore and c.deletetag = 1
		ORDER BY contentid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT [contentid],t1.[categoryid],[content],t1.[title],[titlecolor],[author],t1.[createdatetime],sitedns,t3.siteid,name
		FROM cms_content t1,cms_category t2,site t3 
		WHERE t1.categoryid=t2.categoryid AND t2.siteid=t3.siteid AND categorycode=@categorycode and t1.deletetag = 1
		ORDER BY contentid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT [contentid],t1.[categoryid],[content],t1.[title],[titlecolor],[author],t1.[createdatetime],sitedns,t3.siteid,name
		FROM cms_content t1,cms_category t2,site t3 
		WHERE t1.categoryid=t2.categoryid AND t2.siteid=t3.siteid AND categorycode=@categorycode and t1.deletetag = 1
		ORDER BY contentid DESC
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_content_GetListByCategoryCode', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_content_GetListByCategoryCode', @level2type=N'PARAMETER',@level2name=N'@page'
GO
