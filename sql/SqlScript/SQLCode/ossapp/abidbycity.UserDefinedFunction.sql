USE [ossapp]
GO
/****** Object:  UserDefinedFunction [dbo].[abidbycity]    Script Date: 05/14/2013 14:55:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[abidbycity]
(
	@city int
)
RETURNS int
AS
BEGIN
	
	DECLARE @abid int
	set @abid=0
	
	SELECT @abid=us.bid from agentarea aa 
	inner join users us on us.bid=aa.gid and us.deletetag=1 and usertype=0
inner join agentbase bb on aa.gid=bb.id
	where aa.city=@city and aa.deletetag=1 and bb.isone=1


	RETURN @abid

END
GO
