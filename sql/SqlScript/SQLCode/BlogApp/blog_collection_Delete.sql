USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_collection_Delete]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[blog_collection_Delete]
@collectionid int
 AS 
	DELETE blog_collection
	 WHERE collectionid=@collectionid 

	IF @@ERROR <>0
	BEGIN
		RETURN (-1)
	END
	ELSE
	BEGIN 
		RETURN (1)
	END	






GO
