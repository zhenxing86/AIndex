USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_photo_SetCover]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lx
-- ALTER date: 2009-03-013
-- Description:	设置相册封面
-- =============================================
CREATE PROCEDURE [dbo].[cms_photo_SetCover]
@photoid int
AS
BEGIN 
   
    --begin transaction 
	DECLARE @filepath nvarchar(200)
	DECLARE @filename nvarchar(400)
	DECLARE @cover nvarchar(200)
	DECLARE @createdatetime datetime
	DECLARE @albumid int
	declare @net int
	
	SELECT @net=net, @albumid=albumid,@filepath=filepath,@filename=[filename],@createdatetime=createdatetime 
	FROM cms_photo WHERE photoid=@photoid and deletetag = 1

	SET @cover=@filepath+'/'+@filename

--	IF(LEN(@cover)>200)
--	BEGIN
--		RETURN -1
--	END
--	ELSE
--	BEGIN
		UPDATE cms_album SET net=@net,cover=@cover,createdatetime=@createdatetime WHERE albumid=@albumid
          
        update cms_photo set iscover=0 where iscover=1  and albumid=@albumid
        update cms_photo set iscover=1 where photoid=@photoid

       

		IF @@ERROR <> 0
		BEGIN
           -- rollback transaction
			RETURN 0
		END
		ELSE
		BEGIN
           -- commit transaction 
			RETURN 1
		END
	--END
END

GO
