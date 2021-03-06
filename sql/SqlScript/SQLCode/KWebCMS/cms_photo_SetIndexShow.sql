USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_photo_SetIndexShow]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-20
-- Description:	图片首页显示
-- Memo:
*/
CREATE PROCEDURE [dbo].[cms_photo_SetIndexShow]
	@photoid int,
	@indexshow int
AS
BEGIN
	SET NOCOUNT ON
	
	UPDATE cms_photo 
		SET indexshow = @indexshow 
		WHERE photoid = @photoid
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
