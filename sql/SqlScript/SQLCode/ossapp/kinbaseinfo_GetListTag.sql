USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinbaseinfo_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetListTag
------------------------------------
CREATE PROCEDURE [dbo].[kinbaseinfo_GetListTag]
 @page int
,@size int
,@kid int
,@kname varchar(100)
,@qq varchar(100)
,@regdatetime1 DateTime
,@regdatetime2 DateTime
,@privince varchar(100)
,@city varchar(100)
,@area varchar(100)
,@status varchar(100)
,@linkstate varchar(100)
,@cuid int
,@netaddress varchar(100)
 AS 


set @regdatetime2=dateadd(dd,1,@regdatetime2)
set @regdatetime2=dateadd(ss,-1,@regdatetime2)

declare @usertype int,@roleid int,@bid int,@duty varchar(20)
select @usertype=usertype,@roleid=roleid,@bid=bid,@duty=duty from users u
inner join [role] r on u.roleid=r.ID
 where u.ID=@cuid


create table #ulist
(puid int)


insert into #ulist(puid) values (@cuid)

insert into #ulist(puid)
select ID from users where seruid=@cuid

insert into #ulist(puid)
select cuid from users_belong where puid=@cuid  and deletetag=1


declare @pcount int


if(@bid=0 and @duty='客服部')
begin

SELECT @pcount=count(1) FROM [kinbaseinfo] where deletetag=1
and (kid like ''+convert(varchar,@kid)+'' or @kid=-1)
and kname like '%'+@kname+'%' 
and regdatetime between @regdatetime1 and @regdatetime2 
and (privince = @privince or @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and (status = @status or @status='')
and (linkstate = @linkstate or @linkstate='')
and (qq=@qq or @qq='')
and (netaddress=@netaddress or @netaddress='')


end
--总部非客服部（市场部）：可以看到自己开发的客户
else if(@bid=0 and @duty<>'客服部')
begin

SELECT @pcount=count(1) FROM [kinbaseinfo] 
inner join #ulist on puid=developer 
where deletetag=1
and (kid like ''+convert(varchar,@kid)+'' or @kid=-1)
and kname like '%'+@kname+'%' 
and regdatetime between @regdatetime1 and @regdatetime2 
and (privince = @privince or @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and (status = @status or @status='')
and (linkstate = @linkstate or @linkstate='')
and (qq=@qq or @qq='')
and (netaddress=@netaddress or @netaddress='')
--and developer = @cuid


end
--代理商客服部：可以看到所有代理商的客户
else if(@bid>0 and @duty='客服部')
begin
SELECT @pcount=count(1) FROM [kinbaseinfo] where deletetag=1
and (kid like ''+convert(varchar,@kid)+'' or @kid=-1)
and kname like '%'+@kname+'%' 
and regdatetime between @regdatetime1 and @regdatetime2 
and (privince = @privince or @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and (status = @status or @status='')
and (linkstate = @linkstate or @linkstate='')
and (qq=@qq or @qq='')
and (netaddress=@netaddress or @netaddress='')
and abid=@bid and infofrom='代理'


end
--代理商经理：可以看到所有代理商的客户
else if(@bid>0 and @usertype=0)
begin

SELECT @pcount=count(1) FROM [kinbaseinfo] where deletetag=1
and (kid like ''+convert(varchar,@kid)+'' or @kid=-1)
and kname like '%'+@kname+'%' 
and regdatetime between @regdatetime1 and @regdatetime2 
and (privince = @privince or @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and (status = @status or @status='')
and (linkstate = @linkstate or @linkstate='')
and (qq=@qq or @qq='')
and (netaddress=@netaddress or @netaddress='')
and abid=@bid and infofrom='代理'



end
--其他属于代理商市场部：可以看到所有代理商的自己发展人的客户
else 
begin

SELECT @pcount=count(1) FROM [kinbaseinfo] 
inner join #ulist on puid=developer 
where deletetag=1
and (kid like ''+convert(varchar,@kid)+'' or @kid=-1)
and kname like '%'+@kname+'%' 
and regdatetime between @regdatetime1 and @regdatetime2 
and (privince = @privince or @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and (status = @status or @status='')
and (linkstate = @linkstate or @linkstate='')
and (qq=@qq or @qq='')
and (netaddress=@netaddress or @netaddress='')
--and developer = @cuid
and abid=@bid and infofrom='代理'


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

if(@bid=0 and @duty='客服部')
begin

INSERT INTO @tmptable(tmptableid)
SELECT  kid  FROM [kinbaseinfo] where deletetag=1 
and (kid like ''+convert(varchar,@kid)+'' or @kid=-1)
and kname like '%'+@kname+'%' 
and regdatetime between @regdatetime1 and @regdatetime2 
and (privince = @privince or @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and (status = @status or @status='')
and (linkstate = @linkstate or @linkstate='')
and (qq=@qq or @qq='')
and (netaddress=@netaddress or @netaddress='')
order by kid desc


end
--总部非客服部（市场部）：可以看到自己开发的客户
else if(@bid=0 and @duty<>'客服部')
begin

INSERT INTO @tmptable(tmptableid)
SELECT  kid  FROM [kinbaseinfo] 
inner join #ulist on puid=developer 
where deletetag=1 
and (kid like ''+convert(varchar,@kid)+'' or @kid=-1)
and kname like '%'+@kname+'%' 
and regdatetime between @regdatetime1 and @regdatetime2 
and (privince = @privince or @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and (status = @status or @status='')
and (linkstate = @linkstate or @linkstate='')
and (qq=@qq or @qq='')
and (netaddress=@netaddress or @netaddress='')
--and developer = @cuid
order by kid desc

end
--代理商客服部：可以看到所有代理商的客户
else if(@bid>0 and @duty='客服部')
begin

INSERT INTO @tmptable(tmptableid)
SELECT  kid  FROM [kinbaseinfo] where deletetag=1 
and (kid like ''+convert(varchar,@kid)+'' or @kid=-1)
and kname like '%'+@kname+'%' 
and regdatetime between @regdatetime1 and @regdatetime2 
and (privince = @privince or @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and (status = @status or @status='')
and (linkstate = @linkstate or @linkstate='')
and (qq=@qq or @qq='')
and (netaddress=@netaddress or @netaddress='')
and abid=@bid and infofrom='代理'
order by kid desc

end
--代理商经理：可以看到所有代理商的客户
else if(@bid>0 and @usertype=0)
begin

INSERT INTO @tmptable(tmptableid)
SELECT  kid  FROM [kinbaseinfo] where deletetag=1 
and (kid like ''+convert(varchar,@kid)+'' or @kid=-1)
and kname like '%'+@kname+'%' 
and regdatetime between @regdatetime1 and @regdatetime2 
and (privince = @privince or @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and (status = @status or @status='')
and (linkstate = @linkstate or @linkstate='')
and (qq=@qq or @qq='')
and (netaddress=@netaddress or @netaddress='')
and abid=@bid and infofrom='代理'
order by kid desc


end
--其他属于代理商市场部：可以看到所有代理商的自己发展人的客户
else 
begin

INSERT INTO @tmptable(tmptableid)
SELECT  kid  FROM [kinbaseinfo] 
inner join #ulist on puid=developer 
where deletetag=1 
and (kid like ''+convert(varchar,@kid)+'' or @kid=-1)
and kname like '%'+@kname+'%' 
and regdatetime between @regdatetime1 and @regdatetime2 
and (privince = @privince or @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and (status = @status or @status='')
and (linkstate = @linkstate or @linkstate='')
and (qq=@qq or @qq='')
and (netaddress=@netaddress or @netaddress='')
--and developer = @cuid 
and abid=@bid and infofrom='代理'
order by kid desc

end






			SET ROWCOUNT @size
			SELECT 
				@pcount      ,[ID]    ,[kid]    ,[kname]    ,[regdatetime]    ,[ontime]    ,[expiretime]    ,[privince]    ,[city]    ,[area]    ,[linkstate]    ,[ctype]    ,[cflush]    ,[clevel]    ,[parentpay]    ,[infofrom]    ,(select top 1 u.[name] from users  u where u.ID=developer) [developer]    ,[status]    ,[invoicetitle]    ,[netaddress]    ,[address]    ,[remark]    ,[deletetag],abid  			FROM 
				@tmptable AS tmptable		
			INNER JOIN [kinbaseinfo] g
			ON  tmptable.tmptableid=g.kid 	
			WHERE
				row>@ignore 
order by [kid] desc
end
else
begin
SET ROWCOUNT @size







if(@bid=0 and @duty='客服部')
begin

SELECT 
	@pcount      ,[ID]    ,[kid]    ,[kname]    ,[regdatetime]    ,[ontime]    ,[expiretime]    ,[privince]    ,[city]    ,[area]    ,[linkstate]    ,[ctype]    ,[cflush]    ,[clevel]    ,[parentpay]    ,[infofrom]    ,(select top 1 u.[name] from users  u where u.ID=developer) [developer]    ,[status]    ,[invoicetitle]    ,[netaddress]    ,[address]    ,[remark]    ,[deletetag],abid
	FROM [kinbaseinfo]  where deletetag=1 
and (kid like ''+convert(varchar,@kid)+'' or @kid=-1)
and kname like '%'+@kname+'%' 
and regdatetime between @regdatetime1 and @regdatetime2 
and (privince = @privince or @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and (status = @status or @status='')
and (linkstate = @linkstate or @linkstate='')
and (qq=@qq or @qq='')
and (netaddress=@netaddress or @netaddress='')
order by kid desc


end
--总部非客服部（市场部）：可以看到自己开发的客户
else if(@bid=0 and @duty<>'客服部')
begin

SELECT 
	@pcount      ,[ID]    ,[kid]    ,[kname]    ,[regdatetime]    ,[ontime]    ,[expiretime]    ,[privince]    ,[city]    ,[area]    ,[linkstate]    ,[ctype]    ,[cflush]    ,[clevel]    ,[parentpay]    ,[infofrom]    ,(select top 1 u.[name] from users  u where u.ID=developer) [developer]    ,[status]    ,[invoicetitle]    ,[netaddress]    ,[address]    ,[remark]    ,[deletetag],abid
	FROM [kinbaseinfo]  
inner join #ulist on puid=developer where deletetag=1 
and (kid like ''+convert(varchar,@kid)+'' or @kid=-1)
and kname like '%'+@kname+'%' 
and regdatetime between @regdatetime1 and @regdatetime2 
and (privince = @privince or @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and (status = @status or @status='')
and (linkstate = @linkstate or @linkstate='')
and (qq=@qq or @qq='')
and (netaddress=@netaddress or @netaddress='')
--and developer = @cuid
order by kid desc

end
--代理商客服部：可以看到所有代理商的客户
else if(@bid>0 and @duty='客服部')
begin
SELECT 
	@pcount      ,[ID]    ,[kid]    ,[kname]    ,[regdatetime]    ,[ontime]    ,[expiretime]    ,[privince]    ,[city]    ,[area]    ,[linkstate]    ,[ctype]    ,[cflush]    ,[clevel]    ,[parentpay]    ,[infofrom]    ,(select top 1 u.[name] from users  u where u.ID=developer) [developer]    ,[status]    ,[invoicetitle]    ,[netaddress]    ,[address]    ,[remark]    ,[deletetag],abid
	FROM [kinbaseinfo]  where deletetag=1 
and (kid like ''+convert(varchar,@kid)+'' or @kid=-1)
and kname like '%'+@kname+'%' 
and regdatetime between @regdatetime1 and @regdatetime2 
and (privince = @privince or @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and (status = @status or @status='')
and (linkstate = @linkstate or @linkstate='')
and (qq=@qq or @qq='')
and (netaddress=@netaddress or @netaddress='')
and abid=@bid and infofrom='代理'
order by kid desc

end
--代理商经理：可以看到所有代理商的客户
else if(@bid>0 and @usertype=0)
begin

SELECT 
	@pcount      ,[ID]    ,[kid]    ,[kname]    ,[regdatetime]    ,[ontime]    ,[expiretime]    ,[privince]    ,[city]    ,[area]    ,[linkstate]    ,[ctype]    ,[cflush]    ,[clevel]    ,[parentpay]    ,[infofrom]    ,(select top 1 u.[name] from users  u where u.ID=developer) [developer]    ,[status]    ,[invoicetitle]    ,[netaddress]    ,[address]    ,[remark]    ,[deletetag],abid
	FROM [kinbaseinfo]  where deletetag=1 
and (kid like ''+convert(varchar,@kid)+'' or @kid=-1)
and kname like '%'+@kname+'%' 
and regdatetime between @regdatetime1 and @regdatetime2 
and (privince = @privince or @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and (status = @status or @status='')
and (linkstate = @linkstate or @linkstate='')
and (qq=@qq or @qq='')
and (netaddress=@netaddress or @netaddress='')
and abid=@bid and infofrom='代理'
order by kid desc


end
--其他属于代理商市场部：可以看到所有代理商的自己发展人的客户
else 
begin

SELECT 
	@pcount      ,[ID]    ,[kid]    ,[kname]    ,[regdatetime]    ,[ontime]    ,[expiretime]    ,[privince]    ,[city]    ,[area]    ,[linkstate]    ,[ctype]    ,[cflush]    ,[clevel]    ,[parentpay]    ,[infofrom]    ,(select top 1 u.[name] from users  u where u.ID=developer) [developer]    ,[status]    ,[invoicetitle]    ,[netaddress]    ,[address]    ,[remark]    ,[deletetag],abid
	FROM [kinbaseinfo]  
inner join #ulist on puid=developer 
where deletetag=1 
and (kid like ''+convert(varchar,@kid)+'' or @kid=-1)
and kname like '%'+@kname+'%' 
and regdatetime between @regdatetime1 and @regdatetime2 
and (privince = @privince or @privince='')
and (city = @city or @city='')
and (area = @area or @area='')
and (status = @status or @status='')
and (linkstate = @linkstate or @linkstate='')
and (qq=@qq or @qq='') 
and (netaddress=@netaddress or @netaddress='')
--and developer = @cuid 
and abid=@bid and infofrom='代理'
order by kid desc

end


end

drop table #ulist



GO
