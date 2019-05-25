USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_user_baseconfig_UpdateDescription]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[blog_user_baseconfig_UpdateDescription]
@userid int,
@description nvarchar(200)

 AS 

	UPDATE blog_baseconfig SET 
	[description] = @description
	WHERE userid=@userid 

	IF @@ERROR <> 0 
	BEGIN 	
	   RETURN(-1)
	END
	ELSE
	BEGIN	
	   RETURN (1)
	END




GO
