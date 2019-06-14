USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portalcontent_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-03
-- Description:	Delete
-- =============================================
CREATE PROCEDURE [dbo].[portalcontent_GetCount]
@categorycode nvarchar(20)
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM portalcontent WHERE categorycode=@categorycode
	RETURN @count
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'portalcontent_GetCount', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
