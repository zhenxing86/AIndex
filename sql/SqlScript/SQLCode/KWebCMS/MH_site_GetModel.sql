USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_site_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-26
-- Description:	GetModel
-- =============================================
CREATE PROCEDURE [dbo].[MH_site_GetModel]
@siteid int
AS
BEGIN
	SELECT [siteid],[name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone],[accesscount] 
	FROM site WHERE siteid=@siteid
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_site_GetModel', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
