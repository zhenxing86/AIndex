USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_subcategory_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		along
-- Create date: 2009-12-25
-- Description:	修改子分类
-- =============================================
create PROCEDURE [dbo].[cms_subcategory_Update]
@subcategoryid int,
@subtitle nvarchar(30),
@categoryid int
AS
BEGIN
	UPDATE cms_subcategory SET subtitle=@subtitle,categoryid=@categoryid WHERE subcategoryid=@subcategoryid
	IF @@ERROR <> 0
	BEGIN
		RETURN -1
	END
	ELSE
	BEGIN
		RETURN 1
	END
END







GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_subcategory_Update', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
