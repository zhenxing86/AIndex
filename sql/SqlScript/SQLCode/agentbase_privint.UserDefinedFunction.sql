USE [ossapp]
GO
/****** Object:  UserDefinedFunction [dbo].[agentbase_privint]    Script Date: 05/14/2013 14:55:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[agentbase_privint]
(
	@abid int
)
RETURNS varchar(500)
AS
BEGIN
	
	DECLARE @str varchar(500)
	set @str=''
	

		DECLARE @tmptable TABLE
		(
			tname varchar(100)
		)

	insert into @tmptable
	SELECT distinct Title from agentarea ab
	inner join BasicData..Area a on a.ID=province
	where gid=@abid and ab.deletetag=1

	SELECT  @str=@str+','+tname from @tmptable

	if(len(@str)>0)
	begin
	set @str=subString(@str,2,100)
	end

	RETURN @str

END
GO
