USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_site_GetModelByUserID]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-31
-- Description:	GetSiteModelByUserID
-- =============================================
CREATE PROCEDURE [dbo].[MH_site_GetModelByUserID]
@userid int
AS
BEGIN
	DECLARE @siteid int
	SELECT @siteid=siteid FROM site_user WHERE userid=@userid
	EXEC MH_site_GetModel @siteid
END



GO
