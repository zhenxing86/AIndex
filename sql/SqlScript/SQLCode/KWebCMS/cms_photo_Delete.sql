USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_photo_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-20
-- Description:	删除图片
-- Memo:
*/
CREATE PROCEDURE [dbo].[cms_photo_Delete]
	@photoid int
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @albumid int,@siteid int,@filesize int
	SELECT @albumid=albumid FROM cms_photo WHERE photoid=@photoid
	Update cms_photo Set Deletetag = 0 WHERE [photoid] = @photoid--删除图片
	UPDATE cms_album SET photocount=photocount-1 WHERE albumid=@albumid--更新图片集中图片数量
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
