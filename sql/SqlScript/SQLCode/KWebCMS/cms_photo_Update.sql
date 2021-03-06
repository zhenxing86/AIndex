USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_photo_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-12
-- Description:	图片更新   更新title,filepath,filename,filesize,indexshow,flashshow 六项
-- =============================================
CREATE PROCEDURE [dbo].[cms_photo_Update]
@photoid int,
@title nvarchar(100),
@filename nvarchar(400),
@filepath nvarchar(400),
@filesize int,
@indexshow bit,
@flashshow bit
AS 
BEGIN
	UPDATE cms_photo 
	SET [title] = @title,[filename] = @filename,[filepath] = @filepath,[filesize] = @filesize,[indexshow] = @indexshow,[flashshow] = @flashshow
	WHERE [photoid] = @photoid

	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END
END





GO
