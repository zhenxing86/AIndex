USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_user_Delete]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-13
-- Description:	删除管理员
-- =============================================
CREATE PROCEDURE [dbo].[site_user_Delete]
@userid int
AS
BEGIN
	BEGIN TRANSACTION

	DELETE site_user WHERE [userid] = @userid

	EXEC site_usermenu_DeleteByUserID @userid

	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN (1)
	END
END



GO
