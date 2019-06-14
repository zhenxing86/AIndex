USE [ossapp]
GO
/****** Object:  UserDefinedFunction [dbo].[getAreabyId]    Script Date: 05/14/2013 14:55:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getAreabyId]
(
	@area int
)
RETURNS varchar(100)
AS
BEGIN
	
	DECLARE @aname varchar(100)
	
	
	select @aname=Title from BasicData..area where ID=@area


	RETURN @aname

END
GO
