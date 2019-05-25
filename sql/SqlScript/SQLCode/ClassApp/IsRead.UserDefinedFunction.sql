USE [ClassApp]
GO
/****** Object:  UserDefinedFunction [dbo].[IsRead]    Script Date: 06/15/2013 15:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION [dbo].[IsRead]
	(
	@userid int,
	@objectid int,
	@objecttype int
	)
RETURNS INT
AS
	BEGIN
		DECLARE @isread int		
		DECLARE @count int
		SELECT @count=count(1) FROM  applogs..class_readlogs WHERE userid=@userid AND objectid=@objectid AND objecttype=@objecttype
		IF(@count>0)
		BEGIN	
			SELECT @isread =1	 
		END
		ELSE
		BEGIN
		    SELECT @isread=0
		END		
		RETURN @isread
	END
GO
