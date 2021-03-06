USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[proxysettlement_wait_GetListTagByabid]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[proxysettlement_wait_GetListTagByabid]
 @page int
,@size int
,@abid int
,@city int
 AS 

declare @pcount int


SELECT  @pcount=count(1) from dbo.agentbase ab
inner join dbo.kinbaseinfo k on ab.ID=k.abid
where ab.deletetag=1 and ab.ID=@abid

IF(@page>1)
	BEGIN
	
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		if(@pcount<@ignore)
		begin
			set @page=@pcount/@size
			if(@pcount%@size<>0)
			begin
				set @page=@page+1
			end
			SET @prep=@size*@page
			SET @ignore=@prep-@size
		end
		
		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
SELECT k.kid from dbo.agentbase ab
inner join dbo.kinbaseinfo k on ab.ID=k.abid
where ab.deletetag=1 and ab.ID=@abid

			SET ROWCOUNT @size
			SELECT 
				 @pcount,k.kid,k.kname,dbo.[agentbase_waitmoney](k.kid%20) waitcount,k.remark
	FROM 
				@tmptable AS tmptable		
			INNER JOIN kinbaseinfo k
			ON  tmptable.tmptableid=k.kid
			inner join agentbase ab on ab.ID=k.abid
			WHERE
				row>@ignore 
end
else
begin
SET ROWCOUNT @size


SELECT  @pcount,k.kid,k.kname,dbo.[agentbase_waitmoney](k.kid%20) waitcount,k.remark from dbo.agentbase ab
inner join dbo.kinbaseinfo k on ab.ID=k.abid
where ab.deletetag=1 and ab.ID=@abid


end



GO
