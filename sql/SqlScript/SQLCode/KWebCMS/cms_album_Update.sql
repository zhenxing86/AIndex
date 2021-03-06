USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_album_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-12
-- Description:	更新图片集
-- =============================================
CREATE PROCEDURE [dbo].[cms_album_Update]
@albumid int,
@title nvarchar(100),
@searchkey nvarchar(100),
@searchdescription nvarchar(200)
AS 
BEGIN
	UPDATE cms_album 
	SET [title] = @title,[searchkey] = @searchkey,[searchdescription] = @searchdescription	
	WHERE [albumid] = @albumid

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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'相册ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_album_Update', @level2type=N'PARAMETER',@level2name=N'@albumid'
GO
