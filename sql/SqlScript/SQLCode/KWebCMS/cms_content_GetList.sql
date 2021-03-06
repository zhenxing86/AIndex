USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cms_content_GetList]
@categoryid int
AS 
BEGIN
	SELECT [contentid],[categoryid],[content],[title],[titlecolor],[author],[createdatetime],[searchkey],[searchdescription],[browsertitle],[viewcount],[commentcount],[orderno],[commentstatus],ispageing
	FROM cms_content
	WHERE categoryid=@categoryid and deletetag = 1
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_content_GetList', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
