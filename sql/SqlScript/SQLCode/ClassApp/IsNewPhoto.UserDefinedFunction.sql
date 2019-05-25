USE [ClassApp]
GO
/****** Object:  UserDefinedFunction [dbo].[IsNewPhoto]    Script Date: 06/15/2013 15:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[IsNewPhoto]
	(
	@createdatetime datetime
	)
RETURNS INT
AS
	BEGIN
		DECLARE @isnewphoto int		
		IF(datediff(D,@createdatetime,getdate())<4)
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
