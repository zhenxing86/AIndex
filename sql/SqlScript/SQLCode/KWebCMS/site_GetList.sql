USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_GetList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-13
-- Description:	获取站点列表
-- =============================================
CREATE PROCEDURE [dbo].[site_GetList]
AS
BEGIN	
	SELECT [siteid],[name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone] FROM site
END




GO
