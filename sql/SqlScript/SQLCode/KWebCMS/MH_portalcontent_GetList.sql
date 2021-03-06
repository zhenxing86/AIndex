USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_portalcontent_GetList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-07
-- Description:	GetList
-- =============================================
CREATE PROCEDURE [dbo].[MH_portalcontent_GetList]
@categorycode nvarchar(20),
@page int,
@size int
AS
BEGIN
	EXEC portalcontent_GetList @categorycode,@page,@size
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_portalcontent_GetList', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_portalcontent_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
