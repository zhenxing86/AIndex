USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portalartilce_Delete]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-24
-- Description:	Delete
-- =============================================
CREATE PROCEDURE [dbo].[portalartilce_Delete]
@contentid int
AS
BEGIN
	DELETE portalarticle WHERE contentid=@contentid

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
