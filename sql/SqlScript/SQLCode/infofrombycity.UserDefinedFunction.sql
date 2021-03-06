USE [ossapp]
GO
/****** Object:  UserDefinedFunction [dbo].[infofrombycity]    Script Date: 05/14/2013 14:55:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[infofrombycity]
(
	@city int
)
RETURNS nvarchar(20)
AS
BEGIN
	
	DECLARE @infofrom nvarchar(20)
	set @infofrom='客服人员'
	
if(exists(SELECT us.ID from agentarea aa 
	inner join users us on us.bid=aa.gid and us.deletetag=1 and usertype=0
inner join agentbase bb on aa.gid=bb.id
	where aa.city=@city and aa.deletetag=1  and bb.isone=1))
begin
set @infofrom='代理'
end

	RETURN @infofrom

END
GO
