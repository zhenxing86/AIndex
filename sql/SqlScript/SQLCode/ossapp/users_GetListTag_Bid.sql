USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[users_GetListTag_Bid]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--select * from [role]
------------------------------------
CREATE PROCEDURE [dbo].[users_GetListTag_Bid]
 @page int
,@size int
,@bid int 
,@infofrom varchar(100)
 AS 


if(@infofrom='家长学校')
set @infofrom='客服人员'


declare @pcount int

SELECT @pcount=count(1) FROM [users] g 
inner join [role] r on r.ID=g.roleid where g.deletetag=1 and bid=@bid and (r.[name] = @infofrom or @infofrom='')

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
			SELECT  g.ID  FROM [users] g 
	inner join [role] r on r.ID=g.roleid where g.deletetag=1
  and bid=@bid and (r.[name] =@infofrom or @infofrom='')
 order by ID asc,bid asc


			SET ROWCOUNT @size
			SELECT 
		@pcount      ,g.[ID]    ,[account]    ,[password]    
,[usertype]    ,[roleid]    ,[bid]    ,g.[name]    
,[mobile]    ,g.[qq]    ,g.[remark]    ,[regdatetime]    
,g.[deletetag],r.[name],a.[name] aname  
,g.seruid,(select top 1 s.[name] from [users] s where s.ID=g.seruid),r.duty
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
,g.seruid,(select top 1 s.[name] from [users] s where s.ID=g.seruid),r.duty
FROM [users] g 
inner join [role] r on r.ID=g.roleid
left join agentbase a on a.ID=g.bid
where g.deletetag=1
 and bid=@bid and (r.[name] =@infofrom or @infofrom='')
 order by ID asc,bid asc
end


GO
