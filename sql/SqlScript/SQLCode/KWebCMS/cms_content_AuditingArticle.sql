USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_AuditingArticle]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-10
-- Description:	审核文章
-- =============================================
CREATE PROCEDURE [dbo].[cms_content_AuditingArticle]
@contentid int,
@status bit
AS
BEGIN
	UPDATE cms_content SET status=@status WHERE contentid=@contentid

	IF @@ERROR <> 0
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN 1
	END
END



GO
