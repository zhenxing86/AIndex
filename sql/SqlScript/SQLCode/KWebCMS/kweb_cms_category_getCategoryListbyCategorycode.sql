USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_cms_category_getCategoryListbyCategorycode]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[kweb_cms_category_getCategoryListbyCategorycode]
@categorycode nvarchar(10),
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
			--定义临时表
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) 
		SELECT categoryid FROM cms_category WHERE categorycode=@categorycode AND siteid=@siteid
		ORDER BY createdatetime DESC

		SET ROWCOUNT @size
		SELECT  title,categorycode,categoryid
		FROM cms_category c join @tmptable on c.categoryid=tmptableid 
		WHERE row > @ignore ORDER BY categoryid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT title,categorycode, categoryid
		
		FROM cms_category WHERE categorycode=@categorycode AND siteid=@siteid  
        order by createdatetime desc
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT title,categorycode, categoryid
		FROM cms_category WHERE categorycode=@categorycode AND siteid=@siteid 
	END
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_cms_category_getCategoryListbyCategorycode', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_cms_category_getCategoryListbyCategorycode', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_cms_category_getCategoryListbyCategorycode', @level2type=N'PARAMETER',@level2name=N'@page'
GO
