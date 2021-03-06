USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[proxysettlement_GetListTagBypaytimes]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetListTag
------------------------------------
CREATE PROCEDURE [dbo].[proxysettlement_GetListTagBypaytimes]
 @page int
,@size int
,@abid int
,@city int
,@paytimes int
 AS 

declare @pcount int


select @pcount=count(1) from [proxysettlement] p
inner join users u on u.ID=p.uid
inner join dbo.kinbaseinfo k on p.kid=k.kid
where p.abid=@abid and paytimes=@paytimes

--SELECT  @pcount=count(1) from [proxysettlement] p
--inner join users u on u.ID=p.uid
--inner join dbo.kinbaseinfo k on p.abid=k.abid
--where p.deletetag=1 and p.abid=@abid and (k.city=@city or @city=-1) and paytimes=@paytimes

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
--select p.ID
--from [proxysettlement] p
--inner join users u on u.ID=p.uid
--inner join BasicData..kindergarten k on p.kid=k.kid
--where p.deletetag=1 and abid=@abid and (k.city=@city or @city=-1)
-- and paytimes=@paytimes
select p.ID
from [proxysettlement] p
inner join users u on u.ID=p.uid
inner join dbo.kinbaseinfo k on p.kid=k.kid
where p.abid=@abid and paytimes=@paytimes

			SET ROWCOUNT @size
			SELECT 
				@pcount,intime,waitmoney,settlementmoney,paytype,settlementname
,[name],p.abid,paytimes,@city,p.remark,kname
	FROM 
				@tmptable AS tmptable		
			INNER JOIN [proxysettlement] p
			ON  tmptable.tmptableid=p.ID 
			inner join users u on u.ID=p.uid
			inner join dbo.kinbaseinfo k on p.kid=k.kid

			WHERE
				row>@ignore 
			
end
else
begin
SET ROWCOUNT @size

select @pcount,intime,waitmoney,settlementmoney,paytype,settlementname
,[name],p.abid,paytimes,@city,p.remark,kname  from [proxysettlement] p
inner join users u on u.ID=p.uid
inner join dbo.kinbaseinfo k on p.kid=k.kid
where p.abid=@abid and p.paytimes=@paytimes


--select @pcount,intime,waitmoney,settlementmoney,paytype,settlementname
--,[name],abid,paytimes,@city,remark,kname 
--from [proxysettlement] p
--inner join users u on u.ID=p.uid
--inner join BasicData..kindergarten k on p.kid=k.kid
--where p.deletetag=1 and abid=@abid and (k.city=@city or @city=-1)
-- and paytimes=@paytimes


end


GO
