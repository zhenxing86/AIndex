USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_category_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-04
-- Description:	获取指定 CategoryCode和SiteID 的记录数量
-- =============================================
CREATE PROCEDURE [dbo].[kweb_category_GetCount]
@categorycode nvarchar(10),
@siteid int
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM cms_category WHERE categorycode=@categorycode AND (siteid=@siteid or siteid=0)
	RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_category_GetCount', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_category_GetCount', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
