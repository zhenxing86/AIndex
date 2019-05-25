USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portalphoto_Delete]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-25
-- Description:	Delete
-- =============================================
CREATE PROCEDURE [dbo].[portalphoto_Delete]
@photoid int
AS
BEGIN
	DELETE portalphoto WHERE photoid=@photoid
	
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
