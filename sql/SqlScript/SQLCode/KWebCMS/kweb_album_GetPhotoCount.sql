USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_album_GetPhotoCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-03
-- Description:	获取图片数量
-- =============================================
CREATE PROCEDURE [dbo].[kweb_album_GetPhotoCount]
@albumid int
AS
BEGIN	
	DECLARE @count int
	SELECT @count=photocount FROM cms_album WHERE albumid=@albumid and deletetag = 1
	IF @count IS NULL
	BEGIN
		SET @count=0
	END
	RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'相册ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_album_GetPhotoCount', @level2type=N'PARAMETER',@level2name=N'@albumid'
GO
