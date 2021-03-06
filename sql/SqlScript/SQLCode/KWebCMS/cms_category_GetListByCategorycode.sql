USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_category_GetListByCategorycode]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-03
-- Description:	根据categorycode搜索分类
-- =============================================
CREATE PROCEDURE [dbo].[cms_category_GetListByCategorycode]
@categorycode nvarchar(20),
@siteid int,
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
		INSERT INTO @tmptable(tmptableid) SELECT [categoryid] FROM cms_category 
		WHERE categorycode=@categorycode AND (siteid=@siteid or siteid=0)
		ORDER BY createdatetime DESC

		SET ROWCOUNT @size
		SELECT categoryid,title,description,parentid,categorytype,orderno,categorycode,siteid,createdatetime,iconid,islist 
		FROM @tmptable,cms_category t2
		WHERE t2.categoryid=tmptableid AND row > @ignore 
		ORDER BY createdatetime DESC
	END
	ELSE 
	BEGIN
		SET ROWCOUNT @size
		SELECT categoryid,title,description,parentid,categorytype,orderno,categorycode,siteid,createdatetime,iconid,islist 
		FROM cms_category
		WHERE categorycode=@categorycode AND (siteid=@siteid or siteid=0)
		ORDER BY createdatetime DESC
	END
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_category_GetListByCategorycode', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_category_GetListByCategorycode', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_category_GetListByCategorycode', @level2type=N'PARAMETER',@level2name=N'@page'
GO
