USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_kmp_GetArticleInterface]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-01
-- Description:	GetArticleInterface
-- =============================================
CREATE PROCEDURE [dbo].[MH_kmp_GetArticleInterface]
AS
BEGIN
	EXEC kmp..GetArticleInterface
END



GO
