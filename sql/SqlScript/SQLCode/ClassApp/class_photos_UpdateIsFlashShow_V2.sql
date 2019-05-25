USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_photos_UpdateIsFlashShow_V2]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-25
-- Description:	修改相片首页动态显示选项
--[class_photos_UpdateIsFlashShow_V2] 7391293,0,0
-- Memo:
*/
CREATE PROCEDURE  [dbo].[class_photos_UpdateIsFlashShow_V2]
	@photoid int,
	@classid int,
	@isflashshow int
AS
BEGIN
	SET NOCOUNT ON
	UPDATE class_photos 
		SET isfalshshow = CASE WHEN @isflashshow = 0 THEN 1 ELSE 0 END
		WHERE photoid = @photoid 

END

GO
