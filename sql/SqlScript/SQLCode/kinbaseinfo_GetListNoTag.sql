USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinbaseinfo_GetListNoTag]    Script Date: 05/27/2014 10:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-05-20
-- Description:	
-- Memo: 	select * from users where bid=5 and account='ly'
EXEC [kinbaseinfo_GetListNoTag] 95,100,-1,'','','19900101','20150101','','','','','',69,'',''

EXEC [kinbaseinfo_GetListNoTag] 1,100,15053,'','','19900101','20150101','','','','','',61,'',''
			
*/
ALTER PROCEDURE [dbo].[kinbaseinfo_GetListNoTag]
	@page int,
	@size int,
	@kid int,
	@kname varchar(100),
	@qq varchar(100),
	@regdatetime1 DateTime,
	@regdatetime2 DateTime,
	@privince varchar(100),
	@city varchar(100),
	@area varchar(100),
	@status varchar(100),
	@linkstate varchar(100),
	@cuid int,
	@netaddress varchar(100),
	@developer varchar(100)
AS
BEGIN 
	SET NOCOUNT ON
	
SET @kname = CommonFun.dbo.FilterSQLInjection(@kname)
SET @qq = CommonFun.dbo.FilterSQLInjection(@qq)
SET @privince = CommonFun.dbo.FilterSQLInjection(@privince)
SET @city = CommonFun.dbo.FilterSQLInjection(@city)
SET @area = CommonFun.dbo.FilterSQLInjection(@area)
SET @status = CommonFun.dbo.FilterSQLInjection(@status)
SET @linkstate = CommonFun.dbo.FilterSQLInjection(@linkstate)
SET @netaddress = CommonFun.dbo.FilterSQLInjection(@netaddress)
SET @developer = CommonFun.dbo.FilterSQLInjection(@developer)	
	
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
						u.bid = @bid and jxsid=@jxsid --and u.deletetag=1
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
						and u.deletetag=1
						
				insert into #ulist(puid)		
				SELECT DISTINCT u.ID FROM users u 
					where 
						u.bid=@bid --and u.deletetag=1
						and not exists (select 1 from #ulist where puid = u.ID)
						
					delete #ulist where puid=0
			END	
			--代理商管理员
			if(@bid > 0 and @usertype = 0)
			BEGIN
				insert into #ulist(puid)
				SELECT DISTINCT u.ID FROM users u
					where 
						u.bid = @bid
						and not exists (select 1 from #ulist where puid = u.ID)
				delete #ulist where puid=0
			END
				
		END
	END
		
delete #ulist where puid=0
					
	declare @pcount int, @Condition varchar(2000), 
					@filter varchar(1000), @tempMain nvarchar(4000)
					
	SET @Condition = 
	'	WHERE	kb.regdatetime >= '''+ CONVERT(varchar(10),@regdatetime1,120) +'''
			AND kb.regdatetime < '''+ CONVERT(varchar(10),DATEADD(DD,1,@regdatetime2),120) +''''
	if ISNULL(@kid,-1) <> -1 SET @Condition = @Condition + CHAR(13) + CHAR(10) + '			AND kb.kid = '+convert(varchar,@kid)
	if ISNULL(@kname,'') <> '' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '			AND kb.kname like ''%'+@kname+'%'''
	if ISNULL(@privince,'') <> '' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '			AND kb.privince = '''+@privince+''''
	if ISNULL(@city,'') <> '' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '			AND kb.city = '''+@city+''''
	if ISNULL(@area,'') <> '' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '			 AND kb.area = '''+@area+''''
	if ISNULL(@status,'') <> '' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '			AND kb.status = '''+@status+''''
		 ELSE if @bid=0 and @duty='客服部' set @Condition = @Condition 
		 ELSE SET @Condition = @Condition + CHAR(13) + CHAR(10) + '			AND kb.status <> ''待删除'''
	if ISNULL(@linkstate,'') <> '' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '			AND kb.linkstate = '''+@linkstate+''''
	if ISNULL(@qq,'') <> '' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '			AND kb.qq = '''+@qq+''''
	if ISNULL(@developer,'') <> '' and ISNULL(@developer,'') <> '-2' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '			AND kb.developer = '''+@developer+''''
	if ISNULL(@netaddress,'') <> '' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '			AND kb.netaddress = ''http://'+ replace(@netaddress,'http://','')+''''

	

	

--查询家长学校
	if (@developer='-2' or @dutyname = '家长学校客服')
	begin
		SET @Condition = @Condition + CHAR(13) + CHAR(10) + ' AND kb.remark like ''%创典%'''
	end
	
	
	if(@bid=0 and @duty='客服部')
		SET @filter = ''
	else 
		SET @filter = ' AND (EXISTS(SELECT * FROM #ulist u WHERE (u.puid = kb.developer )) or kb.uid='+convert(varchar,@cuid)+' ) '

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
		' SELECT TOP('+convert(varchar,@size)+') '+CAST(@pcount AS VARCHAR(20)) + ' as pcount, ID, kid, kname, 
							regdatetime, ontime, expiretime, privince, city, area, linkstate, 
							ctype, cflush, clevel, parentpay, infofrom, ca.name developer, status, 
							invoicetitle, netaddress, address, remark, deletetag, abid 
				FROM kinbaseinfo kb 
					OUTER APPLY(select top(1) u.name FROM users u WHERE u.ID = kb.developer)ca 
		' +  @Condition+@filter +'  
				order by kb.kid desc'			
  END
  ELSE
  BEGIN  
  --主查询返回结果集
  SET @tempMain =    
  'SELECT '+CAST(@pcount AS VARCHAR(20)) + ' as pcount, ID, kid, kname, 
					regdatetime, ontime, expiretime, privince, city, area, linkstate, 
					ctype, cflush, clevel, parentpay, infofrom, developer, status, 
					invoicetitle, netaddress, address, remark, deletetag, abid 
		FROM 
				(
					SELECT	ID, kid, kname, 
									regdatetime, ontime, expiretime, privince, city, area, linkstate, 
									ctype, cflush, clevel, parentpay, infofrom, ca.name developer, status, 
									invoicetitle, netaddress, address, remark, deletetag, abid, 
									ROW_NUMBER() OVER(order by kb.kid desc) AS rows    
						FROM kinbaseinfo kb 
							OUTER APPLY(select top(1) u.name FROM users u WHERE u.ID = kb.developer)ca 
	'  + @Condition+ @filter
			+ CHAR(13) + CHAR(10) + '				) AS main_temp 
		WHERE rows BETWEEN ' + CAST(@beginRow AS VARCHAR) +' AND '+CAST(@endRow AS VARCHAR)
  END
  PRINT @tempMain
  
  EXECUTE (@tempMain)
  
drop table #ulist
END

GO

EXEC [kinbaseinfo_GetListNoTag] 1,1000,-1,'','','19900101','20150101','','','','','',143,'',''