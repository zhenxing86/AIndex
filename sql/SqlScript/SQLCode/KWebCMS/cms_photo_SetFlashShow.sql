USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_photo_SetFlashShow]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-20
-- Description:	图片Flast显示
-- =============================================
CREATE PROCEDURE [dbo].[cms_photo_SetFlashShow]
@photoid int,
@flashshow int
AS
BEGIN
	UPDATE cms_photo SET flashshow=@flashshow WHERE photoid=@photoid

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
