USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachs_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-03
-- Description:	获取特定categoryid的记录数
-- =============================================
CREATE PROCEDURE [dbo].[cms_contentattachs_GetCount]
@categoryid int,@siteid int
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM cms_content WHERE categoryid=@categoryid and siteid=@siteid and orderno<>-1 and deletetag = 1
	RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_contentattachs_GetCount', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_contentattachs_GetCount', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
