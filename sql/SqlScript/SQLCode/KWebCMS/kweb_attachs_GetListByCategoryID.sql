USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_attachs_GetListByCategoryID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-16
-- Description:	分页获取附件
-- =============================================
CREATE PROCEDURE [dbo].[kweb_attachs_GetListByCategoryID]
@categoryid int,
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
		SELECT contentattachsid FROM cms_contentattachs 
		WHERE categoryid = @categoryid and deletetag = 1
		ORDER BY contentattachsid DESC

		SET ROWCOUNT @size
		SELECT contentattachsid,categoryid,contentid,title,filepath,filename,filesize,viewcount,createdatetime,attachurl,
		'categoryTitle'=(SELECT title FROM cms_category WHERE categoryid=c.categoryid)
		FROM cms_contentattachs c join @tmptable on c.contentattachsid=tmptableid 
		WHERE row > @ignore and c.deletetag = 1 ORDER BY contentattachsid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT contentattachsid,categoryid,contentid,title,filepath,filename,filesize,viewcount,createdatetime,attachurl,
		'categoryTitle'=(SELECT title FROM cms_category WHERE categoryid=c.categoryid)
		FROM cms_contentattachs c
		WHERE categoryid = @categoryid and c.deletetag = 1
		ORDER BY contentattachsid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT contentattachsid,categoryid,contentid,title,filepath,filename,filesize,viewcount,createdatetime,attachurl,
		'categoryTitle'=(SELECT title FROM cms_category WHERE categoryid=c.categoryid)
		FROM cms_contentattachs c
		WHERE categoryid = @categoryid and c.deletetag = 1
		ORDER BY contentattachsid DESC
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_attachs_GetListByCategoryID', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_attachs_GetListByCategoryID', @level2type=N'PARAMETER',@level2name=N'@page'
GO
