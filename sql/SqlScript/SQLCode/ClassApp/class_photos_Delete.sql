USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_photos_Delete]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-25
-- Description:	删除相片
-- Memo:
*/
CREATE PROCEDURE [dbo].[class_photos_Delete]
	@photoid int,
	@userid int
AS 
BEGIN
	SET NOCOUNT ON
	DECLARE @orderno int

	--更新相册照片数量
	UPDATE class_album SET photocount=photocount-1 
		FROM class_album ca 
			inner join class_photos cp 
				on ca.albumid = cp.albumid
		WHERE cp.photoid = @photoid

	delete class_photos WHERE photoid = @photoid
END


GO
