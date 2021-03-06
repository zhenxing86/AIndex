USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[proxysettlement_waitlog_GetListTagBykid]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[proxysettlement_waitlog_GetListTagBykid]
 @page int
,@size int
,@kid int
 AS 




declare @pcount int

select @pcount=count(1) from dbo.proxysettlement p
inner join dbo.kinbaseinfo k on p.kid=k.kid
inner join users u on u.ID=p.uid
where (p.kid=@kid or @kid=-1)

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
			--tabid bigint,
			tmptableid bigint
		)

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
select p.ID from dbo.proxysettlement p
inner join dbo.kinbaseinfo k on p.kid=k.kid
inner join users u on u.ID=p.uid
where (p.kid=@kid or @kid=-1)

			SET ROWCOUNT @size
			SELECT 
				@pcount,intime,waitmoney,settlementmoney,[name]
	FROM 
				@tmptable AS tmptable		
			INNER JOIN proxysettlement p
			ON  tmptable.tmptableid=p.ID 
			inner join dbo.kinbaseinfo k on p.kid=k.kid
			inner join users u on u.ID=p.uid
			WHERE
				row>@ignore 
end
else
begin
SET ROWCOUNT @size

select @pcount,intime,waitmoney,settlementmoney,[name] from dbo.proxysettlement p
inner join dbo.kinbaseinfo k on p.kid=k.kid
inner join users u on u.ID=p.uid
where (p.kid=@kid or @kid=-1)


end





GO
