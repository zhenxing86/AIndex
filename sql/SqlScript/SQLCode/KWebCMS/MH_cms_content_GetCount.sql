USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_cms_content_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-26
-- Description:	GetCount
-- =============================================
CREATE PROCEDURE [dbo].[MH_cms_content_GetCount]
@categorycode nvarchar(10),
@siteid int
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(contentid) FROM cms_content
	WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode=@categorycode AND siteid=@siteid) AND status=1 and deletetag = 1
	RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_cms_content_GetCount', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_cms_content_GetCount', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
