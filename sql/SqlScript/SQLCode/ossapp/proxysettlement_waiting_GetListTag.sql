USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[proxysettlement_waiting_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetListTag
------------------------------------
CREATE PROCEDURE [dbo].[proxysettlement_waiting_GetListTag]
 @page int
,@size int
 AS 

declare @pcount int

select @pcount=count(1)
from agentbase b where deletetag=1
--inner join agentarea a on b.ID=a.gid

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
select b.ID from agentbase b where deletetag=1
--select a.ID from agentbase b
--inner join agentarea a on b.ID=a.gid

			SET ROWCOUNT @size

select @pcount,ab.ID,ab.[name]
,dbo.[agentbase_privint](ab.id)
,dbo.[agentbase_city](ab.id)
,dbo.[agentbase_waitmoney](ab.id)
,dbo.[agentbase_kins](ab.id)
,-1,-1 
from 	@tmptable AS tmptable	
inner join agentbase ab on tmptable.tmptableid=ab.ID 
 where row>@ignore  


--			SELECT 
--				@pcount,
--b.ID
--,b.[name]
--,(select top 1 Title from BasicData..Area where ID=province) 
--,(select top 1 Title from BasicData..Area where ID=city) 
--,10000*b.ID+1000*a.ID
--,(select count(1) from BasicData..kindergarten k where k.privince=a.province and k.city=a.city)
--,province,city
--			FROM 
--				@tmptable AS tmptable	
--			inner join agentarea a on tmptable.tmptableid=a.ID 
--	
--			INNER JOIN agentbase b
--			ON  b.ID=a.gid	
--			
--			WHERE
--				row>@ignore 

end
else
begin
SET ROWCOUNT @size

--select @pcount,
--b.ID
--,b.[name]
--,(select top 1 Title from BasicData..Area where ID=province) 
--,(select top 1 Title from BasicData..Area where ID=city) 
--,10000*b.ID+1000*a.ID
--,(select count(1) from BasicData..kindergarten k where k.privince=a.province and k.city=a.city)
--,province,city
--from agentbase b
--inner join agentarea a on b.ID=a.gid

select @pcount,ab.ID,ab.[name]
,dbo.[agentbase_privint](ab.id)
,dbo.[agentbase_city](ab.id)
,dbo.[agentbase_waitmoney](ab.id)
,dbo.[agentbase_kins](ab.id)
,-1,-1 
from agentbase ab where ab.deletetag=1



end




GO
