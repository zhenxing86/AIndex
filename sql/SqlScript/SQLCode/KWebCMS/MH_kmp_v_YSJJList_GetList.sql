USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_kmp_v_YSJJList_GetList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-26
-- Description:	获取园所简介列表
-- =============================================
CREATE PROCEDURE [dbo].[MH_kmp_v_YSJJList_GetList]
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
			id int
		)
		SET ROWCOUNT @prep
		INSERT @tmptable (id) 
		SELECT ArticleID FROM kmp..v_YSJJList ORDER BY ArticleID DESC

		SELECT ArticleID,Title,CreateDate,'SiteID'=Kid,'CategoryID'=ArticleCategoryID,[Name],kurl,ptshotname
		FROM kmp..v_YSJJList JOIN @tmptable ON ArticleID=id WHERE row>@ignore ORDER BY row ASC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT ArticleID,Title,CreateDate,'SiteID'=Kid,'CategoryID'=ArticleCategoryID,[Name],kurl,ptshotname
		FROM kmp..v_YSJJList
	END
	ELSE
	BEGIN
		SELECT ArticleID,Title,CreateDate,'SiteID'=Kid,'CategoryID'=ArticleCategoryID,[Name],kurl,ptshotname
		FROM kmp..v_YSJJList
	END
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_kmp_v_YSJJList_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
