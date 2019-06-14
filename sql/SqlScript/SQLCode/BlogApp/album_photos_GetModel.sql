USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_photos_GetModel]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：得到相片实体对象的详细信息 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-06 14:50:00
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[album_photos_GetModel]
@photoid int
 AS 
	--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	--BEGIN TRANSACTION
    
	Update album_photos SET viewcount=viewcount+1 WHERE photoid=@photoid

	SELECT 
	photoid,categoriesid,title,filename,filepath,filesize,viewcount,commentcount,uploaddatetime,iscover,net
	 FROM album_photos
	 WHERE photoid=@photoid 

--	
--	IF @@ERROR <> 0 
--	BEGIN 
--		--ROLLBACK TRANSACTION	   
--	END
--	ELSE
--	BEGIN
--		--COMMIT TRANSACTION	  
--	END









GO
