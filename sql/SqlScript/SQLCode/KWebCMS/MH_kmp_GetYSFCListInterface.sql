USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_kmp_GetYSFCListInterface]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-01
-- Description:	GetYSFCListInterface
-- =============================================
CREATE PROCEDURE [dbo].[MH_kmp_GetYSFCListInterface]
@categorycode nvarchar(20)
AS
BEGIN
	EXEC kmp..GetYSFCInterface @categorycode
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_kmp_GetYSFCListInterface', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
