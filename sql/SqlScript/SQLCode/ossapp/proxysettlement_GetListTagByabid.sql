USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[proxysettlement_GetListTagByabid]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetListTag
------------------------------------
CREATE PROCEDURE [dbo].[proxysettlement_GetListTagByabid]
 @page int
,@size int
,@abid int
,@city int
 AS 

declare @pcount int



select @pcount=count(1) from proxysettlement_sum 
where deletetag=1 and abid=@abid


--SELECT  @pcount=count(distinct paytimes) from [proxysettlement] p
--inner join users u on u.ID=p.uid
--inner join BasicData..kindergarten k on p.kid=k.kid
--where p.deletetag=1 and abid=@abid and (k.city=@city or @city=-1)

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
select ID from proxysettlement_sum 
where deletetag=1 and abid=@abid
--select max(abid),paytimes 
--from [proxysettlement] p
--inner join users u on u.ID=p.uid
--inner join BasicData..kindergarten k on p.kid=k.kid
--where p.deletetag=1 and abid=@abid and (k.city=@city or @city=-1)
--group by paytimes

			SET ROWCOUNT @size
			SELECT 
				@pcount,intime,waitmoney,paymoney,paytype,payname,[name]
,abid,paytimes,-1,p.remark
	FROM 
				@tmptable AS tmptable		
			INNER JOIN proxysettlement_sum p
			ON  tmptable.tmptableid=p.ID 
			inner join users u on u.ID=p.uid
			WHERE
				row>@ignore 
end
else
begin
SET ROWCOUNT @size

select @pcount,intime,waitmoney,paymoney,paytype,payname,[name]
,abid,paytimes,-1,p.remark
from proxysettlement_sum p
inner join users u on u.ID=p.uid
where p.deletetag=1 and abid=@abid

--select @pcount,max(intime),sum(waitmoney),sum(settlementmoney),max(paytype),max(settlementname)
--,max([name]),max(abid),paytimes,@city,max(remark) 
--from [proxysettlement] p
--inner join users u on u.ID=p.uid
--inner join BasicData..kindergarten k on p.kid=k.kid
--where p.deletetag=1 and abid=@abid and (k.city=@city or @city=-1)
--group by paytimes


end


GO
