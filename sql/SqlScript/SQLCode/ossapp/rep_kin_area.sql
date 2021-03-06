USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kin_area]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[rep_kin_area]
 @page int
,@size int
,@kintype int
,@uid int
,@abid int
,@privince varchar(100)
,@city varchar(100)
,@area varchar(100)
,@kname varchar(100)
as



declare @pcount int


if(@kintype=0)--幼儿园列表
begin

select @pcount=count(1)
 from dbo.kinbaseinfo k
where k.deletetag=1
and (abid=@abid or @abid=0)
and (privince = @privince or @privince='-1' or  @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and kname like '%'+@kname+'%'
end
else if(@kintype=1)--幼儿园列表
begin

select @pcount=count(1)
 from  dbo.beforefollow b 
inner join users u on u.ID=b.uid 
where b.deletetag=1
and (u.bid=@abid or @abid=0)
and (provice = @privince or @privince='-1' or @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and kname like '%'+@kname+'%'
end




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

if(@kintype=0)--幼儿园列表
begin
INSERT INTO @tmptable(tmptableid)
select k.ID
 from dbo.kinbaseinfo k
where k.deletetag=1
and (abid=@abid or @abid=0)
and (privince = @privince or @privince='-1' or  @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and kname like '%'+@kname+'%'

end
else if(@kintype=1)--幼儿园列表
begin
INSERT INTO @tmptable(tmptableid)
select b.ID
 from  dbo.beforefollow b 
inner join users u on u.ID=b.uid 
where b.deletetag=1
and (u.bid=@abid or @abid=0)
and (provice = @privince or @privince='-1' or @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and kname like '%'+@kname+'%'

end





			SET ROWCOUNT @size
			

if(@kintype=0)--幼儿园列表
begin

select @pcount,0,kid,kname
,dbo.[getAreabyId]([privince]) 
,dbo.[getAreabyId]([city]) 
,dbo.[getAreabyId]([area]) 
,k.regdatetime
 from 
@tmptable AS tmptable		
 inner join dbo.kinbaseinfo k
ON  tmptable.tmptableid=k.ID 
where  row>@ignore 

end
else if(@kintype=1)--幼儿园列表
begin

select @pcount,1,b.ID,kname
,dbo.[getAreabyId]([provice]) 
,dbo.[getAreabyId]([city]) 
,dbo.[getAreabyId]([area]) 
,b.intime
 from 
@tmptable AS tmptable		
 inner join dbo.beforefollow b
ON  tmptable.tmptableid=b.ID 
inner join users u on u.ID=b.uid 
where row>@ignore 


end




end
else
begin
SET ROWCOUNT @size

if(@kintype=0)--幼儿园列表
begin

select @pcount,0,kid,kname
,dbo.[getAreabyId]([privince]) 
,dbo.[getAreabyId]([city]) 
,dbo.[getAreabyId]([area]) 
,k.regdatetime
 from dbo.kinbaseinfo k
where k.deletetag=1
and (abid=@abid or @abid=0)
and (privince = @privince or @privince='-1' or  @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and kname like '%'+@kname+'%'

end
else if(@kintype=1)--幼儿园列表
begin

select @pcount,1,b.ID,kname
,dbo.[getAreabyId]([provice]) 
,dbo.[getAreabyId]([city]) 
,dbo.[getAreabyId]([area]) 
,b.intime
 from  dbo.beforefollow b 
inner join users u on u.ID=b.uid 
where b.deletetag=1
and (u.bid=@abid or @abid=0)
and (provice = @privince or @privince='-1' or @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and kname like '%'+@kname+'%'
end

end



GO
