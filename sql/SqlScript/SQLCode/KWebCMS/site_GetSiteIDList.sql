USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_GetSiteIDList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-13
-- Description:	获取SiteID列表
-- =============================================
CREATE PROCEDURE [dbo].[site_GetSiteIDList]
AS
BEGIN
	select siteid,[name] from site
END



GO
