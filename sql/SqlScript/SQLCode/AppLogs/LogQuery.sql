USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[LogQuery]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:	
LogQuery 	@DbName  = 'basicdata',
	@TbName  = 'user', 
	@Item = 'account', 
	@value = 'yz', 
	@kid = 12511,
	@bgntime = '2013-01-13',
	@endtime = '2013-10-22'
*/
CREATE PROC [dbo].[LogQuery]	 
	@DbName varchar(50),
	@TbName varchar(50), 
	@Item varchar(50), 
	@value varchar(50), 
	@kid int ,
	@bgntime datetime,
	@endtime datetime,
	@DoType int = -1--（0新增，2删除，1修改，-1不限）
AS
BEGIN
	SET NOCOUNT ON
	declare @KeyColCnt int,
					@KeyCol varchar(50),
					@KeyCol2 varchar(50),
					@KeyCol3 varchar(50),
					@KidInfo varchar(500),
					@DbTbName varchar(50),
					@TbID VARCHAR(10), @ColType varchar(50),
					@DelLog VARCHAR(8000), 
					@SQL NVARCHAR(MAX)
	select	@TbID = tl.TbID,
					@KeyCol = tl.KeyCol,
					@KeyCol2 = tl.KeyCol2,
					@KeyCol3 = tl.KeyCol3,
					@KidInfo = tl.KidInfo,
					@ColType = ISNULL(tc.ColType, 'int')
		from AppLogs..TbList tl 
			LEFT join AppLogs..TbCol tc 
				on tl.TbID = tc.TbID 
				and tc.ColName = @Item
			WHERE tl.DbName = @DbName 
				and tl.TbName = @TbName 
	SET @DbTbName = '['+@DbName+']..'+'['+@TbName+']'
	if ISNULL(@KidInfo,'') = '' 
		set @KidInfo = 'inner join (select 1 kid)ki on 1 = 1 and dt.kid = @kid' 	
	CREATE TABLE #DelColList(ColName varchar(50), ColNoName varchar(50))
	SET @SQL = '
	INSERT INTO #DelColList(ColName, ColNoName)
		select name, ''Col''+CAST(column_id AS VARCHAR(10)) 
			from '+@DbName+'.sys.columns	
			where object_id= object_id('''+@DbTbName+''')
	'
	EXEC(@SQL)
	select @DelLog = 
	'
	;WITH CET AS
	(
		select '+STUFF(Commonfun.dbo.sp_GetSumStr(','+ColNoName+' AS '+ColName),1,1,'')+'
			from AppLogs..DelLog	
			WHERE DbName = '''+@DbName+'''
				and TbName = '''+@TbName+''' 
	)' from #DelColList
	 			
	create table #T(keycol sql_variant,keycol2 sql_variant,keycol3 sql_variant)
	CREATE UNIQUE INDEX idx_unique on #T(keycol,keycol2,keycol3)with(ignore_dup_key = on)
	create table #Tkid(keycol sql_variant,keycol2 sql_variant,keycol3 sql_variant)
	CREATE UNIQUE INDEX idx_unique on #Tkid(keycol,keycol2,keycol3)with(ignore_dup_key = on)

	
	begin
		begin
				SET @SQL = '
				insert into #Tkid(keycol,keycol2,keycol3) 
					select dt.['+@KeyCol+'],'
				+case when @KeyCol2 is NULL then 'NULL'ELSE'dt.[' END 
				+ISNULL(@KeyCol2,'')
				+case when @KeyCol2 is NULL then ''ELSE']' END 
				+', '
				+case when @KeyCol3 is NULL then 'NULL'ELSE'dt.[' END 
				+ISNULL(@KeyCol3,'')
				+case when @KeyCol3 is NULL then ''ELSE']' END 
				+'
						from ['+@DbName+']..['+@TbName+'] dt
					'+@KidInfo+'
				'+@DelLog+'	
				insert into #Tkid(keycol,keycol2,keycol3) 
					select dt.['+@KeyCol+'],'
				+case when @KeyCol2 is NULL then 'NULL'ELSE'dt.[' END 
				+ISNULL(@KeyCol2,'')
				+case when @KeyCol2 is NULL then ''ELSE']' END 
				+', '
				+case when @KeyCol3 is NULL then 'NULL'ELSE'dt.[' END 
				+ISNULL(@KeyCol3,'')
				+case when @KeyCol3 is NULL then ''ELSE']' END 
				+'
						from CET dt
					'+@KidInfo+'
					
				insert into #Tkid(keycol,keycol2,keycol3)  
				select DISTINCT KeyCol, KeyCol2, KeyCol3
					from AppLogs..EditLog
					where DbName = '''+@DbName+'''
						and TbName = '''+@TbName+'''
						and ColName = ''kid'' 
						and CAST(OldValue AS int) = @kid
			'	
				
			SET @SQL = @SQL + '
				insert into #T(keycol,keycol2,keycol3) 
					select dt.['+@KeyCol+'],'
				+case when @KeyCol2 is NULL then 'NULL'ELSE'dt.[' END 
				+ISNULL(@KeyCol2,'')
				+case when @KeyCol2 is NULL then ''ELSE']' END 
				+', '
				+case when @KeyCol3 is NULL then 'NULL'ELSE'dt.[' END 
				+ISNULL(@KeyCol3,'')
				+case when @KeyCol3 is NULL then ''ELSE']' END 
				+'
						from ['+@DbName+']..['+@TbName+'] dt
					'+@KidInfo+'	
						where dt.['+@Item+'] = CAST('''+@value+''' AS '+@ColType+')	
			'	
		  +@DelLog+'	
				insert into #T(keycol,keycol2,keycol3) 
					select dt.['+@KeyCol+'],'
				+case when @KeyCol2 is NULL then 'NULL'ELSE'dt.[' END 
				+ISNULL(@KeyCol2,'')
				+case when @KeyCol2 is NULL then ''ELSE']' END 
				+', '
				+case when @KeyCol3 is NULL then 'NULL'ELSE'dt.[' END 
				+ISNULL(@KeyCol3,'')
				+case when @KeyCol3 is NULL then ''ELSE']' END 
				+'
						from CET dt
					'+@KidInfo+'	
						where dt.['+@Item+'] = CAST('''+@value+''' AS '+@ColType+')	
			'	
			SET @SQL = @SQL + '
				insert into #T(keycol,keycol2,keycol3)  
				select DISTINCT KeyCol, KeyCol2, KeyCol3
					from AppLogs..EditLog
					where DbName = '''+@DbName+'''
						and TbName = '''+@TbName+'''
						and ColName = '''+@Item+''' 
						and 
							(
								CAST(OldValue AS '+@ColType+') = CAST('''+@value+''' AS '+@ColType+')
							or	CAST(NewValue AS '+@ColType+') = CAST('''+@value+''' AS '+@ColType+') 
							)	
			'	
		END
		IF @Item IN(@KeyCol,@KeyCol2,@KeyCol3)
		BEGIN
			SET @SQL = @SQL + '
				insert into #T(keycol,keycol2,keycol3)  
				select DISTINCT KeyCol, KeyCol2, KeyCol3
					from AppLogs..EditLog
					where DbName = '''+@DbName+'''
						and TbName = '''+@TbName+'''
						and CAST(cast('''+@value+''' as  '+@ColType+') AS sql_variant) IN(KeyCol,KeyCol2,KeyCol3)
					
			'	
		END
	end
	print @SQL 
	EXEC	SP_EXECUTESQL @SQL,N'@kid INT',
				@kid = @kid

	SELECT * 
	INTO #TB
	FROM #T
	INTERSECT
	SELECT * FROM #TKID

	begin
			SET @SQL = '
			select	e.KeyCol,e.KeyCol2,e.KeyCol3,
							CASE e.DoType WHEN 0 THEN ''新增'' WHEN 1 THEN ''修改'' WHEN 2 THEN ''删除'' END DoType, 
							ISNULL(tc.descript,e.ColName)ColName,OldValue,NewValue,--e.DoUserID,
							ISNULL(u1.name,u.name)DoName,e.CrtDate
				from AppLogs..EditLog e 
					inner join #TB t 
						on e.keycol = t.keycol
						'+ CASE WHEN @KeyCol2 is NOT NULL THEN 'AND e.keycol2 = t.keycol2 ' ELSE '' END 
						 + CASE WHEN @KeyCol3 is NOT NULL THEN 'AND e.keycol3 = t.keycol3 ' ELSE '' END 
						+'
						and e.DbName = '''+@DbName+'''
						and e.TbName = '''+@TbName+'''
					LEFT JOIN AppLogs..TbCol tc
						on tc.TbID = '+@TbID+' 
						AND tc.ColName = e.ColName						
					left join basicdata..[user] u on e.Douserid = u.userid
					left join ossapp..users u1 on e.Douserid = u1.ID
				where e.CrtDate between @bgntime and @endtime
				'+CASE WHEN isnull(@DoType,-1) = -1 THEN '' ELSE ' and e.DoType = @Dotype ' end+'
					ORDER BY e.KeyCol, e.CrtDate		
			'	
	end
	print @SQL
	EXEC	SP_EXECUTESQL @SQL,N'@bgntime datetime, @endtime datetime,@Dotype int',
				@bgntime = @bgntime,@endtime = @endtime,@Dotype = @Dotype
	DROP TABLE #T,#Tkid, #TB
END

GO
