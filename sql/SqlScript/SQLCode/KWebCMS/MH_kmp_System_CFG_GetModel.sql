USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_kmp_System_CFG_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-31
-- Description:	kmp..System_CFG
-- =============================================
CREATE PROCEDURE [dbo].[MH_kmp_System_CFG_GetModel]
@userid int,
@ParaName nvarchar(20)
AS
BEGIN
	SELECT Para_Name,Para_Value,Para_Desc,'SiteID'=KID 
	FROM kmp..System_CFG WHERE KID=(SELECT siteid FROM site_user WHERE userid=@userid)
END




GO
