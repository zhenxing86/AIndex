USE [gyszq]
GO
/****** Object:  UserDefinedFunction [dbo].[HasReply]    Script Date: 08/28/2013 14:42:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[HasReply]
	(
	@id int,
	@replytype int
	)
RETURNS  int
AS
	BEGIN
		DECLARE @count int
		IF(@replytype=1)
		BEGIN
			SELECT @count=count(1) FROM companycomment WHERE parentid=@id
		END
		ELSE
		BEGIN
			SELECT @count=count(1) FROM productcomment WHERE parentid=@id
		END
		RETURN @count
	END
GO
