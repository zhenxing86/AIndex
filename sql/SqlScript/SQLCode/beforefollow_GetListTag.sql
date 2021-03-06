USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[beforefollow_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--GetListTag
------------------------------------
CREATE PROCEDURE [dbo].[beforefollow_GetListTag] --1,10,1,'','','','3','','',''
 @page int
,@size int
,@uid int
,@kname varchar(100)
,@name varchar(100)
,@mobile varchar(100)
,@developer varchar(100)
,@privince varchar(100)
,@city varchar(100)
,@area varchar(100)
 AS 

BEGIN 
SET NOCOUNT ON
	
SET @kname = CommonFun.dbo.FilterSQLInjection(@kname)
SET @name = CommonFun.dbo.FilterSQLInjection(@name)
SET @privince = CommonFun.dbo.FilterSQLInjection(@privince)
SET @city = CommonFun.dbo.FilterSQLInjection(@city)
SET @area = CommonFun.dbo.FilterSQLInjection(@area)
SET @mobile = CommonFun.dbo.FilterSQLInjection(@mobile)
SET @developer = CommonFun.dbo.FilterSQLInjection(@developer)
	
	declare @usertype int, @bid int, @duty varchar(20), @jxsid int

	select	@usertype = usertype, 
					@bid = bid, @duty = duty, @jxsid = jxsid 
		from users u
			inner join [role] r 
				on u.roleid = r.ID
		where u.ID = @uid

	create table #ulist(puid int)
	
	
	if(@jxsid <> '' and @jxsid > 0)--经销商
	begin
		insert into #ulist(puid) values (@uid)
		insert into #ulist(puid)
			select ID 
				from users 
				where seruid = @uid
		insert into #ulist(puid)
			select cuid 
				from users_belong 
				where puid = @uid 
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
		
			insert into #ulist(puid) values (@uid)
			insert into #ulist(puid)
				select ID 
					from users 
					where seruid = @uid
			insert into #ulist(puid)
				select cuid 
					from users_belong 
					where puid = @uid 
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
		
					
	declare @pcount int, @Condition varchar(2000), @filter varchar(1000), @tempMain nvarchar(4000)
					
	SET @Condition = ' where kb.deletetag=1 '
	if ISNULL(@kname,'') <> '' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '		AND kb.kname like ''%'+@kname+'%'''
	if ISNULL(@privince,'') <> '' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '		AND kb.provice = '''+@privince+''''
	if ISNULL(@city,'') <> '' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '			AND kb.city = '''+@city+''''
	if ISNULL(@area,'') <> '' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '			AND kb.area = '''+@area+''''
	if ISNULL(@mobile,'') <> '' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '		AND kb.[tel] like  ''%'+@mobile+'%'''
	if ISNULL(@developer,'') <> '' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '	AND kb.[uid] = '''+@developer+''''
	if ISNULL(@name,'') <> '' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '			AND kb.[linkname] like ''%'+@name+'%'''
	

	
	if(@bid=0 and @duty='客服部')
		SET @filter = ''
	else 
		SET @filter = ' AND (EXISTS(SELECT * FROM #ulist u WHERE (u.puid = kb.[uid] )) or kb.uid='+convert(varchar,@uid)+' ) '

	SET @tempMain = 
	' SELECT @pcount = count(1) FROM [beforefollow] kb  
	' + @Condition +  @filter

	exec sp_executesql 
		@tempMain,N'@pcount int output',
		@pcount output

  DECLARE @beginRow INT
  DECLARE @endRow INT
  SET @beginRow = (@page - 1) * @Size    + 1
  SET @endRow = @page * @Size

  IF @page = 1 
  BEGIN
		SET @tempMain = 
		' SELECT TOP('+convert(varchar,@size)+') '+CAST(@pcount AS VARCHAR(20)) + ' as pcount,[ID]    ,[kid]    ,[kname]    ,[nature]    ,[classcount]     
						,[provice]    ,[city]    ,[area]    ,[linebus]    ,[address]    ,[linkname]    
						,[title]    ,[tel]    ,[qq]    ,[email]    ,[netaddress]    ,[remark]    
						,[uid]    ,[bid]    ,[mobile]    ,[ismaterkin]    ,[parentbfid]  ,[childnum],[childnumre],[intime],[deletetag],[name]   
						,dbo.[getAreabyId]([provice])   
						,dbo.[getAreabyId]([city])   
						,dbo.[getAreabyId]([area])   
						,maxtime  
				FROM beforefollow kb 
					OUTER APPLY(select top(1) u.name FROM users u WHERE u.ID = kb.[uid])ca 
					OUTER APPLY(select max(intime) maxtime from dbo.beforefollowremark where bf_Id=kb.[ID] ) bf 
		' +  @Condition+@filter +'  
				order by kb.ID desc'			
  END
  ELSE
  BEGIN  
  --主查询返回结果集
  SET @tempMain =    
  'SELECT '+CAST(@pcount AS VARCHAR(20)) + ' as pcount,[ID]    ,[kid]    ,[kname]    ,[nature]    ,[classcount]     
						,[provice]    ,[city]    ,[area]    ,[linebus]    ,[address]    ,[linkname]    
						,[title]    ,[tel]    ,[qq]    ,[email]    ,[netaddress]    ,[remark]    
						,[uid]    ,[bid]    ,[mobile]    ,[ismaterkin]    ,[parentbfid]  ,[childnum],[childnumre],[intime],[deletetag],[name]   
						,dbo.[getAreabyId]([provice])   
						,dbo.[getAreabyId]([city])   
						,dbo.[getAreabyId]([area])   
						,maxtime  
		FROM 
				(
					SELECT	kb.[ID]    ,[kid]    ,[kname]    ,[nature]    ,[classcount]     
						,[provice]    ,[city]    ,[area]    ,[linebus]    ,[address]    ,[linkname]    
						,[title]    ,[tel]    ,kb.[qq]    ,[email]    ,[netaddress]    ,kb.[remark]    
						,[uid]    ,kb.[bid]    ,[mobile]    ,[ismaterkin]    ,[parentbfid]  ,[childnum]    ,[childnumre],[intime]    ,kb.[deletetag],ca.[name]   
						,bf.maxtime, 
									ROW_NUMBER() OVER(order by kb.[ID] desc) AS rows    
						FROM [beforefollow] kb 
							OUTER APPLY(select top(1) u.name FROM users u WHERE u.ID = kb.[uid]) ca 
							OUTER APPLY(select max(intime) maxtime from dbo.beforefollowremark where bf_Id=kb.[ID] ) bf  
	'  + @Condition+ @filter
			+ CHAR(13) + CHAR(10) + '				) AS main_temp 
		WHERE rows BETWEEN ' + CAST(@beginRow AS VARCHAR) +' AND '+CAST(@endRow AS VARCHAR)
  END
  PRINT @tempMain
  EXECUTE (@tempMain)

END

GO
