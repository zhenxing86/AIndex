USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_copyright_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-21
-- Description:	GetModel
-- =============================================
CREATE PROCEDURE [dbo].[site_copyright_GetModel]
@siteid int
AS
BEGIN
	SELECT copyrightid,siteid,contents FROM site_copyright WHERE siteid=@siteid
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_copyright_GetModel', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
