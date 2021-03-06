USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[users_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--select * from [users]
--[users_GetListTag] 1,100,5,17
------------------------------------
CREATE PROCEDURE [dbo].[users_GetListTag]
 @page int
,@size int
,@bid int 
,@uid int
 AS 
 
 	create table #ulist(puid int)
 
	declare @jsxid int
	declare @usertype int
 
	select @jsxid=jxsid,@usertype=usertype from users where ID=@uid

	declare @pcount int
	set @pcount=0
	
	if(@usertype=0)
	begin
		if(@jsxid <> '' )--经销商用户
		begin

			insert into #ulist(puid)
			SELECT ID FROM [users] 
				where 
					deletetag=1 and bid=@bid and jxsid=@jsxid and usertype=1

		end
		else
		begin
			if(@bid >0 )--代理商用户
			begin
				insert into #ulist(puid)
				SELECT ID FROM [users] 
					where 
						deletetag=1 and bid=@bid 
						and 
						(
							usertype=1
							or 
							(usertype=0 and jxsid>0)
						)
			end
			else--中幼用户
			begin
				insert into #ulist(puid)
				SELECT ID FROM [users] 
					where 
						deletetag=1 and usertype=0 
			end
		end
	end


select @pcount=COUNT(1) from #ulist



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
			SELECT  ID  FROM #ulist u
				left join [users] g on g.ID=u.puid
				where deletetag=1
					order by bid asc,ID asc


			SET ROWCOUNT @size
			SELECT 
			@pcount      ,g.[ID]    ,[account]    ,[password]    
			,[usertype]    ,[roleid]    ,[bid]    ,g.[name]    
			,[mobile]    ,g.[qq]    ,g.[remark]    ,[regdatetime]    
			,g.[deletetag],r.[name],a.[name] aname  
			,g.seruid,(select top 1 s.[name] from [users] s where s.ID=g.seruid)
			,(select count(1) from users_belong ub where ub.puid=g.ID)
			,(select top 1 name from dbo.agentjxs j where j.ID=g.jxsid)
			  from
				@tmptable AS tmptable		
			INNER JOIN [users] g
			ON  tmptable.tmptableid=g.ID 
inner join [role] r on r.ID=g.roleid	
left join agentbase a on a.ID=g.bid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,g.[ID]    ,[account]    ,[password]    
,[usertype]    ,[roleid]    ,[bid]    ,g.[name]    
,[mobile]    ,g.[qq]    ,g.[remark]    ,[regdatetime]    
,g.[deletetag],r.[name],a.[name] aname  
,g.seruid,(select top 1 s.[name] from [users] s where s.ID=g.seruid)
,(select count(1) from users_belong ub where ub.puid=g.ID)
,(select top 1 name from dbo.agentjxs j where j.ID=g.jxsid)
FROM #ulist u 
left join [users] g on g.ID=u.puid
inner join [role] r on r.ID=g.roleid
left join agentbase a on a.ID=g.bid
where g.deletetag=1
order by bid asc,ID asc
end



drop table #ulist

GO
