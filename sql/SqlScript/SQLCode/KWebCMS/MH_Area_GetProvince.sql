USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_Area_GetProvince]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-03-30
-- Description:	Area_GetPrivince
-- =============================================
create PROCEDURE [dbo].[MH_Area_GetProvince]
AS
BEGIN
	SELECT ID,Title,Superior,[Level],Code FROM BasicData..Area WHERE Superior=0
END







GO
