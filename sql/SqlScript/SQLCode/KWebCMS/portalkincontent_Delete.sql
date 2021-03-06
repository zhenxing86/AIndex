USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portalkincontent_Delete]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-25
-- Description:	Delete
-- =============================================
CREATE PROCEDURE [dbo].[portalkincontent_Delete]
@contentid int
AS
BEGIN
	BEGIN TRANSACTION
	
	Update portalkincontent Set Deletetag = 0 WHERE contentid=@contentid

	Update cms_content Set Deletetag = 0 WHERE contentid=@contentid
	
	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 1
	END
END

GO
