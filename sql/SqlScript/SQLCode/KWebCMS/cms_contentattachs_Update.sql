USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachs_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-12
-- Description:	文章内容更新   更新title,filepath,filename,filesize 四项
-- =============================================
CREATE PROCEDURE [dbo].[cms_contentattachs_Update]
@contentattachsid int,
@title nvarchar(100),
@filepath nvarchar(400),
@filename nvarchar(200),
@filesize int,
@attachurl nvarchar(200)
AS 
BEGIN
	BEGIN TRANSACTION
	IF NOT EXISTS(SELECT * FROM cms_contentattachs WHERE contentattachsid=@contentattachsid AND [filename]=@filename and deletetag = 1)
	BEGIN--修改了上传文件,在此修改时间
		UPDATE cms_contentattachs SET createdatetime=GETDATE() WHERE contentattachsid=@contentattachsid
	END

	UPDATE cms_contentattachs 
	SET [title] = @title,[filepath] = @filepath,[filename] = @filename,[filesize] = @filesize,[attachurl] = @attachurl
	WHERE [contentattachsid] = @contentattachsid

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
