USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_kmp_GetPhotoViewByID]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-01
-- Description:	GetPhotoViewByID
-- =============================================
CREATE PROCEDURE [dbo].[MH_kmp_GetPhotoViewByID]
@PhotoID int
AS
BEGIN
	SELECT TOP 1 * FROM kmp..v_YSFC2 WHERE PhotoID=@PhotoID
END



GO
