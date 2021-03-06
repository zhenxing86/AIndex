USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_photos_UpdateIsCover]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：把相片设为封面
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 11:50:29
------------------------------------
CREATE  PROCEDURE [dbo].[class_photos_UpdateIsCover]
@photoid int

 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION	

	declare @net int
	DECLARE @albumid int
	SELECT @albumid=albumid,@net=net FROM class_photos 
	 WHERE photoid=@photoid
	
	UPDATE class_photos SET 
	[iscover]=0 
	WHERE albumid=@albumid

	UPDATE class_photos SET 
	[iscover] = 1
	WHERE photoid=@photoid

	DECLARE @filepath NVARCHAR(500)
	DECLARE @filename NVARCHAR(200)
	DECLARE @uploaddatetime DATETIME
	SELECT @filepath=filepath,@filename=filename,@uploaddatetime=uploaddatetime FROM 

class_photos WHERE photoid=@photoid
	UPDATE class_album SET 
coverphoto=@filepath+@filename,coverphotodatetime=@uploaddatetime ,net=@net WHERE albumid=@albumid 

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







GO
