USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_startuser_Update]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[blog_startuser_Update]
	@id int,
	@isstart int
AS
BEGIN
	UPDATE blog_baseconfig SET 
	isstart = @isstart
	WHERE userid=@id 

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
