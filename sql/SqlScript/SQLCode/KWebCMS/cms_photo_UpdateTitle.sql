USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_photo_UpdateTitle]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-06
-- Description:	修改标题
-- =============================================
CREATE PROCEDURE [dbo].[cms_photo_UpdateTitle]
@photoid int,
@title nvarchar(200)
AS
BEGIN
	UPDATE cms_photo SET title=@title WHERE photoid=@photoid
	
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
