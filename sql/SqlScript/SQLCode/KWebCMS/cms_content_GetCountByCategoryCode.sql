USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_GetCountByCategoryCode]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-03
-- Description:	GetCount
-- =============================================
CREATE PROCEDURE [dbo].[cms_content_GetCountByCategoryCode]
@categorycode nvarchar(20)
AS
BEGIN	
	DECLARE @count int
	SELECT @count=count(*) FROM cms_content t1,cms_category t2 
	WHERE t1.categoryid=t2.categoryid AND t2.categorycode=@categorycode and deletetag = 1
	RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_content_GetCountByCategoryCode', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
