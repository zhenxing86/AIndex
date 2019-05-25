USE [ClassApp]
GO
/****** Object:  UserDefinedFunction [dbo].[IsNewAlbum]    Script Date: 06/15/2013 15:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[IsNewAlbum]
	(
	@albumid int,
	@isblogalbum int
	)

RETURNS INT
WITH SCHEMABINDING
AS
BEGIN
		DECLARE @isnewphoto int	
		DECLARE @newcount int
--		IF(@isblogalbum!=1)
--		BEGIN
			SELECT  @newcount=count(1)  FROM dbo.class_photos WHERE albumid=@albumid and datediff(D,uploaddatetime,getdate())<4
--		END
--		ELSE
--		BEGIN
--			SELECT  @newcount=count(1)  FROM BlogApp.dbo.album_photos WHERE categoriesid=@albumid and datediff(D,uploaddatetime,getdate())<4
--		END
		IF(@newcount>0)
		BEGIN	
			SELECT @isnewphoto=1	 
		END
		ELSE
		BEGIN
		    SELECT @isnewphoto=0
		END		
		RETURN @isnewphoto
	END
GO
