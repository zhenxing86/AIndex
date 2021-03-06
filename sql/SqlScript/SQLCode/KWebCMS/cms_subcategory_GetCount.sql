USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_subcategory_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		along
-- Create date: 2009-12-25
-- Description:	获取指定子分类数
-- =============================================
create PROCEDURE [dbo].[cms_subcategory_GetCount]
@categoryid int
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM cms_subcategory WHERE categoryid=@categoryid
	RETURN @count
END





GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_subcategory_GetCount', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
