USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachs_GetListByCategoryCode]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-06
-- Description:	根据categorycode搜索附件
-- =============================================
CREATE PROCEDURE [dbo].[cms_contentattachs_GetListByCategoryCode]
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
		INSERT INTO @tmptable(tmptableid) SELECT [contentattachsid] FROM cms_contentattachs 
		WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode=@categorycode) and deletetag = 1
		ORDER BY contentattachsid DESC

		SET ROWCOUNT @size
		SELECT [contentattachsid],c.[categoryid],c.[title],c.[createdatetime],'categoryTitle'=t2.title,sitedns,t3.siteid,name 
		FROM cms_contentattachs c,@tmptable,cms_category t2,site t3
		WHERE c.categoryid=t2.categoryid AND t2.siteid=t3.siteid AND c.[contentattachsid]=tmptableid AND row > @ignore and c.deletetag = 1
		ORDER BY contentattachsid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT [contentattachsid],t1.[categoryid],t1.[title],t1.[createdatetime],'categoryTitle'=t2.title,sitedns,t3.siteid,name
		FROM cms_contentattachs t1,cms_category t2,site t3 
		WHERE t1.categoryid=t2.categoryid AND t2.siteid=t3.siteid AND categorycode=@categorycode and t1.deletetag = 1
		ORDER BY contentattachsid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT [contentattachsid],t1.[categoryid],t1.[title],t1.[createdatetime],'categoryTitle'=t2.title,sitedns,t3.siteid,name
		FROM cms_contentattachs t1,cms_category t2,site t3 
		WHERE t1.categoryid=t2.categoryid AND t2.siteid=t3.siteid AND categorycode=@categorycode and t1.deletetag = 1
		ORDER BY contentattachsid DESC
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_contentattachs_GetListByCategoryCode', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_contentattachs_GetListByCategoryCode', @level2type=N'PARAMETER',@level2name=N'@page'
GO
