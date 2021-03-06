USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[role_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--GetListTag select * from [role]
------------------------------------
CREATE PROCEDURE [dbo].[role_GetListTag]
 @page int
,@size int
,@agbid int
,@uid int
 AS 



create table #rlist(prid int)
 
	declare @jsxid int
	declare @usertype int
	declare @bid int
 
	select @jsxid=jxsid,@usertype=usertype,@bid=bid from users where ID=@uid

	declare @pcount int
	set @pcount=0
	
	if(@usertype=0)
	begin
		if(@jsxid <> '' )--经销商用户
		begin

			insert into #rlist(prid)
			SELECT ID FROM [role] 
				where 
					deletetag=1 and agbid=2

		end
		else
		begin
			if(@bid >0 )--代理商用户
			begin
			insert into #rlist(prid)
			SELECT ID FROM [role] 
				where 
					deletetag=1 and agbid=1
			end
			else--中幼用户
			begin
				insert into #rlist(prid)
				SELECT ID FROM [role] 
				where 
					deletetag=1 and agbid=0
			end
		end
	end


select @pcount=COUNT(1) from #rlist


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
			SELECT  ID  FROM [role] 
			inner join #rlist on ID=prid
			where deletetag=1  
			


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,[ID]    ,[agbid]    ,[name]    ,[duty]    ,[describe]    ,[deletetag]  			FROM 
				@tmptable AS tmptable		
			INNER JOIN [role] g
			ON  tmptable.tmptableid=g.ID 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,[ID]    ,[agbid]    ,[name]    ,[duty]    ,[describe]    ,[deletetag]  	 
	FROM [role]  
	inner join #rlist on ID=prid
where deletetag=1   


end

drop table #rlist

GO
