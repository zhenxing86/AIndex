USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_album_GetListByCategoryID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-20
-- Description:	获取图片集列表
-- =============================================
CREATE PROCEDURE [dbo].[cms_album_GetListByCategoryID]
@categoryid int
AS
BEGIN
	SELECT * FROM cms_album WHERE categoryid=@categoryid and deletetag = 1
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_album_GetListByCategoryID', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
