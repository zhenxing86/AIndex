USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_kmp_GetArticleViewByArticleID]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-01
-- Description:	GetArticleViewByArticleID
-- =============================================
CREATE PROCEDURE [dbo].[MH_kmp_GetArticleViewByArticleID]
@ArticleID int
AS
BEGIN
	SELECT TOP 1 * FROM kmp..V_ArticleList2 WHERE ArticleID=@ArticleID AND IsVisible=1
END



GO
