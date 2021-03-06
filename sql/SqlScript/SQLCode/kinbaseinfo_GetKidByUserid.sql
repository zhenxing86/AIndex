USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinbaseinfo_GetKidByUserid]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      
-- Create date: 2013-05-20
-- Description:	
-- Memo: 	
EXEC [kinbaseinfo_GetKidByUserid] 288556

EXEC [kinbaseinfo_GetKidByUserid] 1
			
*/
CREATE PROCEDURE [dbo].[kinbaseinfo_GetKidByUserid]
	@userid int
AS
BEGIN 
	SET NOCOUNT ON
	
	
	declare @usertype int, @bid int, @duty varchar(20), @jxsid int,@dutyname varchar(100)

	select	@usertype = usertype, 
					@bid = bid, @duty = duty, @jxsid = jxsid ,@dutyname=r.name
		from users u
			inner join [role] r 
				on u.roleid = r.ID
		where u.ID = @userid

	create table #ulist(puid int)
	
	
	if(@jxsid <> '' and @jxsid > 0)--经销商
	begin
		insert into #ulist(puid) values (@userid)
		insert into #ulist(puid)
			select ID 
				from users 
				where seruid = @userid
		insert into #ulist(puid)
			select cuid 
				from users_belong 
				where puid = @userid 
					and deletetag = 1
					
		if(@bid > 0 and @duty = '客服部')
			BEGIN
				insert into #ulist(puid)
				SELECT DISTINCT u.ID FROM users u
					where 
						u.bid = @bid and jxsid=@jxsid
						and not exists (select 1 from #ulist where puid = u.ID)
			END	
			--代理商管理员
			if(@bid > 0 and @usertype = 0)
			BEGIN
				insert into #ulist(puid)
				SELECT DISTINCT u.ID FROM users u
					where 
						u.bid = @bid and jxsid=@jxsid
						and not exists (select 1 from #ulist where puid = u.ID)
			
			END
	
	END
	else
	BEGIN
		if (@bid > 0 or @duty <> '客服部')
		BEGIN
		
			insert into #ulist(puid) values (@userid)
			insert into #ulist(puid)
				select ID 
					from users 
					where seruid = @userid
			insert into #ulist(puid)
				select cuid 
					from users_belong 
					where puid = @userid 
						and deletetag = 1	
						
			if(@bid > 0 and @duty = '客服部')
			BEGIN
			
				insert into #ulist(puid)		
				SELECT DISTINCT u.ID FROM agentjxs bj 
					inner join users u 
						on bj.ID = u.jxsid 
					where 
						(bj.bid = @bid or u.bid=@bid)
						and not exists (select 1 from #ulist where puid = u.ID)
						
						
				insert into #ulist(puid)		
				SELECT DISTINCT u.ID FROM users u 
					where 
						u.bid=@bid
						and not exists (select 1 from #ulist where puid = u.ID)
						
			END	
			--代理商管理员
			if(@bid > 0 and @usertype = 0)
			BEGIN
				insert into #ulist(puid)
				SELECT DISTINCT u.ID FROM users u
					where 
						u.bid = @bid
						and not exists (select 1 from #ulist where puid = u.ID)
			
			END
				
		END
	END
		

					
	declare @pcount int, @Condition varchar(2000), 
					@filter varchar(1000), @tempMain nvarchar(4000)
					
	SET @Condition = '	WHERE	1=1 '
	if @bid=0 and @duty='客服部' set @Condition = @Condition 
	ELSE SET @Condition = @Condition + CHAR(13) + CHAR(10) + '			AND kb.status <> ''待删除'''
	
	
	
	if(@bid=0 and @duty='客服部')
		SET @filter = ''
	else 
		SET @filter = ' AND (EXISTS(SELECT * FROM #ulist u WHERE (u.puid = kb.developer )) or kb.uid='+convert(varchar,@userid)+' ) '

	SET @tempMain = 
	' SELECT kid FROM kinbaseinfo kb  
	' + @Condition +  @filter
	
    PRINT @tempMain
     
	exec sp_executesql @tempMain

END


GO
