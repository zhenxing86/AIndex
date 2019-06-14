USE [MsgApp]
GO
/****** Object:  UserDefinedFunction [dbo].[UserNickName]    Script Date: 05/14/2013 14:54:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter FUNCTION [dbo].[UserNickName]
	(
	@userid int
	)
RETURNS  varchar(40)
AS
BEGIN
		DECLARE @name varchar(50)
		IF(@userid<>-1)
		BEGIN	
			SELECT @name =nickname FROM BasicData.dbo.[user] where userid = @userid		 
		END
		ELSE
		BEGIN
		    SELECT @name='中国幼儿园门户'
		END		
		RETURN @name
	END
GO
