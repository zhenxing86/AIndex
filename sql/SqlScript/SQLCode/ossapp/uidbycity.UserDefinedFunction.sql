USE [ossapp]
GO
/****** Object:  UserDefinedFunction [dbo].[uidbycity]    Script Date: 05/14/2013 14:55:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[uidbycity]
(
	@city int
)
RETURNS int
AS
BEGIN
	
	DECLARE @cityid int
	set @cityid=0
	
	SELECT @cityid=us.ID from agentarea aa 
	inner join users us on us.bid=aa.gid and us.deletetag=1 and usertype=0
inner join agentbase bb on aa.gid=bb.id
	where aa.city=@city and aa.deletetag=1  and bb.isone=1


	RETURN @cityid

END
GO
