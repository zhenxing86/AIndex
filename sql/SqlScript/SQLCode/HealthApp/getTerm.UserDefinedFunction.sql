USE [HealthApp]
GO
/****** Object:  UserDefinedFunction [dbo].[getTerm]    Script Date: 05/14/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getTerm]
( 
   @time datetime
)
RETURNS int
AS
BEGIN
	
	DECLARE @result int
	set @result = 1
    if(Month(@time) between 2 and 8)
    set @result =0
	
	
	RETURN @result

END
GO
