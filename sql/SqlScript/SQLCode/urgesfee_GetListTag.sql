USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[urgesfee_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--select * from users order by ID
------------------------------------
CREATE PROCEDURE [dbo].[urgesfee_GetListTag]
 @page int
,@size int
,@cuid int
,@xtype int
 AS 


BEGIN 
	SET NOCOUNT ON
		
	declare @usertype int, @bid int, @duty varchar(20), @jxsid int,@dutyname varchar(100)


	select	@usertype = usertype, 
					@bid = bid, @duty = duty, @jxsid = jxsid ,@dutyname=r.name
		from users u
			inner join [role] r 
				on u.roleid = r.ID
		where u.ID = @cuid

	create table #ulist(puid int)
	
	
	if(@jxsid <> '' and @jxsid > 0)--经销商
	begin
		insert into #ulist(puid) values (@cuid)
		insert into #ulist(puid)
			select ID 
				from users 
				where seruid = @cuid
		insert into #ulist(puid)
			select cuid 
				from users_belong 
				where puid = @cuid 
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
		
			insert into #ulist(puid) values (@cuid)
			insert into #ulist(puid)
				select ID 
					from users 
					where seruid = @cuid
			insert into #ulist(puid)
				select cuid 
					from users_belong 
					where puid = @cuid 
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
				SELECT DISTINCT u.ID FROM users  u
					where 
						u.bid = @bid
						and not exists (select 1 from #ulist where puid = u.ID)
			
			END
				
		END
	END

					
	declare @pcount int, @Condition varchar(2000), 
					@filter varchar(1000), @tempMain nvarchar(4000)
					
	SET @Condition = 
	'	WHERE  deletetag = 1 '
	if (@xtype=0) 
	begin
		SET @Condition = @Condition + CHAR(13) + CHAR(10) + ' AND [expiretime] < getdate() and status=''欠费'' '
	end
	ELSE if (@xtype=1)  
	begin	 
		SET @Condition = @Condition + CHAR(13) + CHAR(10) + ' and datediff(dd,getdate(),[expiretime])>=-7 and datediff(dd,getdate(),[expiretime])<=3  and status=''试用期'' '
	end
	ELSE if (@xtype=2)  
	begin	 
		SET @Condition = @Condition + CHAR(13) + CHAR(10) + ' and datediff(dd,getdate(),[expiretime])>=-7 and datediff(dd,getdate(),[expiretime])<=15  and status=''正常缴费'' '
	end
	else
	begin
	
	SET @Condition = @Condition + CHAR(13) + CHAR(10) + ' and 0>1 '
	end
	
	if(@bid=0 and @duty='客服部')
		SET @filter = ''
	else 
		SET @filter = ' AND (EXISTS(SELECT * FROM #ulist u WHERE (u.puid = kb.developer )) or kb.uid='+convert(varchar,@cuid)+' ) '



	

	if (@dutyname = '家长学校客服')
	begin
		SET @filter = @filter + CHAR(13) + CHAR(10) + ' AND kb.remark like ''%创典%'''
	end


	SET @tempMain = 
	' SELECT @pcount = count(1) FROM kinbaseinfo kb  
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
		' SELECT TOP('+convert(varchar,@size)+') '+CAST(@pcount AS VARCHAR(20)) + ' as pcount, 
				ID    ,kid    ,[expiretime]    ,0 ,[kname],''''    ,deletetag,infofrom  ,'''+convert(varchar,@bid)+'''
				FROM kinbaseinfo kb 
		' +  @Condition+@filter +'  
				order by kb.[expiretime] desc'			
  END
  ELSE
  BEGIN  
  --主查询返回结果集
  SET @tempMain =    
  'SELECT '+CAST(@pcount AS VARCHAR(20)) + ' as pcount, ID    ,kid    
  ,[expiretime] ,0 ,[kname],'''' ,deletetag,infofrom  ,'''+convert(varchar,@bid)+'''
		FROM 
				(
					SELECT	ID,kid ,[expiretime],[kname],deletetag,infofrom, 
									ROW_NUMBER() OVER(order by kb.[expiretime] desc) AS rows    
						FROM kinbaseinfo kb 
							
	'  + @Condition+ @filter
			+ CHAR(13) + CHAR(10) + '				) AS main_temp 
		WHERE rows BETWEEN ' + CAST(@beginRow AS VARCHAR) +' AND '+CAST(@endRow AS VARCHAR)
  END
  PRINT @tempMain
  EXECUTE (@tempMain)

END



GO
