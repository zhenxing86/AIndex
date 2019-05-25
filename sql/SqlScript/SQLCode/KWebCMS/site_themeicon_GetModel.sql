USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_themeicon_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-14
-- Description:	GetModel
-- =============================================
CREATE PROCEDURE [dbo].[site_themeicon_GetModel]
@iconid int
AS
BEGIN
	SELECT iconid,themeid,title,thumbpath,createdatetime 
	FROM site_themeicon 
	WHERE iconid=@iconid
END




GO
