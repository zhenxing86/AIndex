USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachs_GetListByCategoryID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cms_contentattachs_GetListByCategoryID]
@categoryid int
AS 
BEGIN
	SELECT [contentattachsid],[categoryid],[contentid],[title],[filepath],[filename],[filesize],[viewcount],[createdatetime]
	FROM cms_contentattachs
	WHERE categoryid=@categoryid and deletetag = 1 
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_contentattachs_GetListByCategoryID', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
