USE [BackupApp]
GO

/****** Object:  StoredProcedure [dbo].[BackupDIFF]    Script Date: 2019/5/25 14:14:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*
-- Author:      Master谭
-- Create date: 2013-06-29
-- Description:	过程用于差异备份
-- Memo: 	
*/
CREATE PROC [dbo].[BackupDIFF]
as
BEGIN
	SET NOCOUNT ON	
	declare @sql varchar(max)
	SELECT @sql = isnull(@sql,'') + '
	begin try
	  BACKUP DATABASE '+ dbname +' 
			to DISK = ''E:\BACKUP\DIFF\'+ dbname +'\'+ dbname 
				+'_DIFF_' + REPLACE(REPLACE(CONVERT(Varchar(40), GETDATE(), 120),'-','_'),':','_') +'.bak ''  WITH DIFFERENTIAL,COMPRESSION ; 
	end try
	begin catch 
		INSERT INTO Backup_Error_log(dbname,backuptype,errormessage)
			VALUES('''+ dbname +''',1,error_message() ) 
	end catch
' 
		from BackupDIFF_config 
		where datepart(hh,GETDATE())%backuphour  = 0
	--PRINT @sql
	exec(@sql)
END




GO

/****** Object:  StoredProcedure [dbo].[BackupDIFF_DB]    Script Date: 2019/5/25 14:14:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      Master谭
-- Create date: 2013-06-29
-- Description:	过程用于差异备份
-- Memo: 	
*/
CREATE PROC [dbo].[BackupDIFF_DB]
@dbname varchar(20)
as
BEGIN
	SET NOCOUNT ON	
	declare @sql varchar(max)
	SELECT @sql = isnull(@sql,'') + '
	begin try
	  BACKUP DATABASE '+ @dbname +' 
			to DISK = ''E:\BACKUP\DIFF\'+ @dbname +'\'+ @dbname 
				+'_DIFF_' + REPLACE(REPLACE(CONVERT(Varchar(40), GETDATE(), 120),'-','_'),':','_') +'.bak ''  WITH DIFFERENTIAL,COMPRESSION ; 
	end try
	begin catch 
		INSERT INTO Backup_Error_log(dbname,backuptype,errormessage)
			VALUES('''+ @dbname +''',1,error_message() ) 
	end catch
' 
		--from BackupDIFF_config 
		--where datepart(hh,GETDATE())%backuphour  = 0
	--PRINT @sql
	exec(@sql)
END



GO

/****** Object:  StoredProcedure [dbo].[BackupFull]    Script Date: 2019/5/25 14:14:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      Master谭
-- Create date: 2013-06-29
-- Description:	过程用于完整备份
-- Memo: 	
*/
CREATE PROC [dbo].[BackupFull]
as
BEGIN
	SET NOCOUNT ON	
	declare @sql varchar(max)
	SELECT @sql = isnull(@sql,'') +
	'
	begin try
		USE [master] 
		ALTER DATABASE '+ dbname +' SET RECOVERY SIMPLE WITH NO_WAIT
		ALTER DATABASE '+ dbname +' SET RECOVERY SIMPLE   --简单模式
		USE '+ dbname +'
		DBCC SHRINKFILE (N'''+ dbname +'_Log'' , 11, TRUNCATEONLY)
		USE [master] 
		ALTER DATABASE '+ dbname +' SET RECOVERY FULL WITH NO_WAIT
		ALTER DATABASE '+ dbname +' SET RECOVERY FULL  --还原为完全模式
		use BackupApp
		BACKUP DATABASE '+ dbname +' 
			to DISK = ''E:\BACKUP\FULL\'+ dbname +'\'+ dbname +'_Full_' + REPLACE(REPLACE(CONVERT(Varchar(40), GETDATE(), 120),'-','_'),':','_') + '.bak '' WITH COMPRESSION; 

	end try
	begin catch 
		INSERT INTO Backup_Error_log(dbname,backuptype,errormessage)
			VALUES('''+ dbname +''',0,error_message() ) 
	end catch
' 
		from BackupFull_config 
		where DATEDIFF(day, '19000101' , getdate()) % 7 +1 = backup_week
	--PRINT @sql
	exec(@sql)
END

GO

/****** Object:  StoredProcedure [dbo].[BackupFull_DB]    Script Date: 2019/5/25 14:14:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      Master谭
-- Create date: 2013-06-29
-- Description:	过程用于完整备份
-- Memo: 
	[BackupFull_DB] 'BasicData'
	[BackupFull_DB] 'ClassApp'
	[BackupFull_DB] 'BlogApp'
	[BackupFull_DB] 'KWebCMS'
	[BackupFull_DB] 'KWebCMS_Right'		
	[BackupFull_DB] 'AppConfig'
	[BackupFull_DB] 'DocApp'
	[BackupFull_DB] 'AndroidApp'
	[BackupFull_DB] 'AppLogs'
	[BackupFull_DB] 'BackupApp'
	[BackupFull_DB] 'CommonFun'
	[BackupFull_DB] 'DrawApp'
	[BackupFull_DB] 'EBook'
	[BackupFull_DB] 'edu_dx'
	[BackupFull_DB] 'edu_ta'
	[BackupFull_DB] 'fmcapp'
	[BackupFull_DB] 'gameapp'
	[BackupFull_DB] 'healthapp'
	[BackupFull_DB] 'gyszq'
	[BackupFull_DB] 'kininfoapp'
	[BackupFull_DB] 'KwebCMS_Temp'
	[BackupFull_DB] 'libapp'
	[BackupFull_DB] 'logdata'
	[BackupFull_DB] 'mcapp'
	[BackupFull_DB] 'msgapp'
	[BackupFull_DB] 'ngbapp'
	[BackupFull_DB] 'omapp'
	[BackupFull_DB] 'ossapp'
	[BackupFull_DB] 'ossrep'
	[BackupFull_DB] 'payapp'
	[BackupFull_DB] 'reportapp'
	[BackupFull_DB] 'sbapp'
	[BackupFull_DB] 'sms'
	[BackupFull_DB] 'sms_history'
	[BackupFull_DB] 'zgyey_om'
	[BackupFull_DB] 'zgyeycms_right'
	[BackupFull_DB] 'groupapp'
	[BackupFull_DB] 'sqlagentdb'
	[BackupFull_DB] 'settlerep'
	[BackupFull_DB] 'sbapplog'
	[BackupFull_DB] 'ResourceApp'
	[BackupFull_DB] 'kmp'
	
*/
CREATE PROC [dbo].[BackupFull_DB]
@dbname varchar(20)
as
BEGIN
	SET NOCOUNT ON	
	declare @sql varchar(max)
	SELECT @sql = isnull(@sql,'') +
	'
	begin try
		USE [master] 
		ALTER DATABASE '+ @dbname +' SET RECOVERY SIMPLE WITH NO_WAIT
		ALTER DATABASE '+ @dbname +' SET RECOVERY SIMPLE   --简单模式
		USE '+ @dbname +'
		DBCC SHRINKFILE (N'''+ @dbname +'_Log'' , 1, TRUNCATEONLY)
		USE [master] 
		ALTER DATABASE '+ @dbname +' SET RECOVERY FULL WITH NO_WAIT
		ALTER DATABASE '+ @dbname +' SET RECOVERY FULL  --还原为完全模式
		use BackupApp
		BACKUP DATABASE '+ @dbname +' 
			to DISK = ''E:\BACKUP\to54\'+ @dbname +'_Full_' + REPLACE(REPLACE(CONVERT(Varchar(40), GETDATE(), 120),'-','_'),':','_') + '.bak '' WITH COMPRESSION; 

	end try
	begin catch 
		INSERT INTO Backup_Error_log(dbname,backuptype,errormessage)
			VALUES('''+ @dbname +''',0,error_message() ) 
	end catch
' 
		--from BackupFull_config 
		--where DATEDIFF(day, '19000101' , getdate()) % 7 +1 = backup_week
	--PRINT @sql
	exec(@sql)
END

GO

/****** Object:  StoredProcedure [dbo].[BackUpTable]    Script Date: 2019/5/25 14:14:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      Master谭
-- Create date: 2013-07-26
-- Description:	备份表
-- Memo:	
CREATE TABLE TableInfo(DBName varchar(125) NOT NULL, TBName varchar(125) NOT NULL, Keystr varchar(200) NOT NULL, FilStr varchar(2000) NOT NULL  )
INSERT INTO TableInfo(DBName, TBName, Keystr, FilStr )
SELECT 'Basicdata','user','userid', 'WHERE a.kid = @kid'
declare @result int
exec @result = BackUpTable @kid = 12511, @dbname = 'BlogApp', @TBName = 'album_categories', @VersionNo = 3
select @result
*/
CREATE PROC [dbo].[BackUpTable]
	@kid int,
	@dbname varchar(125),
	@TBName varchar(125),
	@VersionNo int
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @object_name_back varchar(125), @dbobject_name varchar(125), 
					@FilStr varchar(2000),@DelFilStr varchar(2000), @S NVARCHAR(MAX), @VersionCtrl varchar(2000) , 
					@Keystr varchar(200), @USINGStr varchar(2000), @DelExistGStr varchar(2000), @OnStr varchar(200),
					@DelOnStr varchar(200), @UpdateStr varchar(2000), @InsertStr varchar(2000) 

	SELECT	@FilStr = FilStr, @Keystr = Keystr, @VersionCtrl = VersionCtrl, 
					@DelFilStr = replace(replace(replace(replace(FilStr,']',''),'[',''),'..','_'),'.dbo.','_') 
	FROM TableInfo 
		WHERE DBName = @dbname 
			and TBName = @TBName
	IF @Keystr IS NULL
	RETURN -1		
	SET @dbobject_name = '['+@dbname + '].[dbo].['+ @TBName + ']'
	set @object_name_back = '[dbo].['+@dbname + '_' + @TBName + ']'
	SET @S = '
	IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'''+@object_name_back+''') AND type in (N''U''))
	BEGIN
		select top(0)* into '+@object_name_back+' from '+@dbobject_name+'
				cross join (select n as VersionNo from commonfun.dbo.Nums100 where n = 1)b 
	END
	'
	print @S
		EXEC SP_EXECUTESQL @S; 

  SET @S = 'Use ' + @dbname + CHAR(13) + CHAR(10) + ' 
  Declare @Alter NVARCHAR(MAX)
  Select b.Name ColName, c.name TypeName, c.length, COLUMNPROPERTY(b.id, b.name, ''PRECISION'') PREC, isnull(COLUMNPROPERTY(b.id, b.name, ''Scale''),0) Scale, b.colid Into #col 
     From sys.sysobjects a, sys.syscolumns b, sys.systypes c
    Where a.Name = ''' + @TBName + ''' and a.xType = ''U'' and a.ID = b.ID and b.xtype = c.xtype and c.status = 0
      and Not Exists (Select * From BackupApp.sys.syscolumns d Where b.name = d.name and d.ID = Object_ID(''BackupApp.dbo.' + @dbname + '_' + @TBName + '''))
  if Exists (Select * From #col)
  Begin
    Select @Alter = Isnull(@Alter + Char(13) + CHAR(10), '''') + ''Alter Table BackupApp.dbo.[' + @dbname + '_' + @TBName + '] Add ['' + ColName + ''] '' + TypeName + 
    Case When length = 8000 Then ''(max)'' When TypeName In (''Char'', ''Varchar'', ''NVarchar'') Then + ''('' + Cast(length as Varchar) + '')'' When TypeName In (''numeric'') Then ''('' + Cast(PREC as Varchar) + '', '' + Cast(Scale as Varchar) + '')'' Else '''' End
      From #col Order by colid
    Exec(@Alter)
  End  
  Drop Table #col'
  
  Print @S
		EXEC SP_EXECUTESQL @S; 
  
	select @USINGStr = 'SELECT ' + CommonFun.dbo.sp_GetSumStr('a.['+name+'],' ) + ' @VersionNo [VersionNo]
		FROM '+@dbobject_name+' a 
		' + @FilStr 
		from sys.columns 
		where object_id = object_id(@object_name_back) 
			and name <> 'VersionNo'
	select @DelExistGStr = 'SELECT 1
						FROM '+@dbobject_name+' ai 
						' + REPLACE(@FilStr,' a.',' ai.') 
		from sys.columns 
		where object_id = object_id(@object_name_back) 
			and name <> 'VersionNo'
			
	select @OnStr = CommonFun.dbo.sp_GetSumStr('a.['+col+'] = b.['+col+'] and ') + 'a.[VersionNo] = b.[VersionNo]'  
			from BasicData.dbo.f_split(@Keystr,',')
	select @DelOnStr = CommonFun.dbo.sp_GetSumStr(' and a.['+col+'] = ai.['+col+'] ') 
			from BasicData.dbo.f_split(@Keystr,',')	

	select @UpdateStr = 'WHEN MATCHED THEN
	UPDATE SET '+STUFF(CommonFun.dbo.sp_GetSumStr(',
		b.['+name+'] = a.['+name+']'),1,1,'')
		from sys.columns 
		where object_id = object_id(@object_name_back) 
			and name <> 'VersionNo'
			and name not in(select col from BasicData.dbo.f_split(@Keystr,','))	
			
	select @InsertStr = 'INSERT ('+STUFF(CommonFun.dbo.sp_GetSumStr(', ['+name+']'),1,2,'')+')
	VALUES (' +STUFF(CommonFun.dbo.sp_GetSumStr(', a.['+name+']'),1,2,'') + ')'
		from sys.columns 
		where object_id = object_id(@object_name_back) 
		
	SET @S = '
	;MERGE '+@object_name_back+' AS b
	USING 
	(	
		'+@USINGStr+'
	)AS a
	ON ('+@OnStr+')
	'+isnull(@UpdateStr,'')+'
	WHEN NOT MATCHED THEN
	'+@InsertStr+';
	'	

if OBJECTPROPERTY(OBJECT_ID(@object_name_back),'TableHasIdentity') = 1
  Set @S = 'SET IDENTITY_INSERT '+@object_name_back+' ON 
  ' + @S + '
  SET IDENTITY_INSERT '+@object_name_back+' OFF'
  
Print @S
		EXEC SP_EXECUTESQL @S,N'@kid INT, @VersionNo INT',	@kid = @kid, @VersionNo = @VersionNo; 
		
IF EXISTS( select * from BackupApp..BackupWebInfo where kid = @kid and VersionNo = @VersionNo )	
AND NOT EXISTS(SELECT * FROM BackupInnerTable a WHERE NOT EXISTS(SELECT * FROM BackupApp..TableInfo b WHERE a.DBName = b.DBName and a.TBName = b.TBName) )		
SET @S = @S + '
   	delete '+@object_name_back+' 
		from '+@object_name_back+' a 
			'+@DelFilStr+' 
			AND a.[VersionNo] = @VersionNo ' + @VersionCtrl+' 
			and not exists
				(
					'+ @DelExistGStr +'
						'+ @DelOnStr + '
				)

'

	PRINT @S
		EXEC SP_EXECUTESQL @S,N'@kid INT, @VersionNo INT',	@kid = @kid, @VersionNo = @VersionNo; 
	RETURN 1
END
GO

/****** Object:  StoredProcedure [dbo].[BackupWeb]    Script Date: 2019/5/25 14:14:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      Master谭
-- Create date: 2013-07-26
-- Description:	备份网站
-- Memo:
exec BackupWeb @KID = 12511, @VersionNo = 1
*/
CREATE PROC [dbo].[BackupWeb]
	@KID INT,
	@Oper Varchar(50)
AS
BEGIN
	SET NOCOUNT ON 
	--SET @kid = 12511
	Declare @VersionNo Int, @ID Int
  Select @VersionNo = MAX(VersionNo) From BackupWebInfo where kid = @KID

  Select @VersionNo = Isnull(@VersionNo, 0) + 1
  
  Insert Into BackupApp.dbo.BackupWeb_History(KID, Oper, type) Values (@KID, @Oper, 0)
  Select @ID = Scope_Identity()

	SELECT * INTO #T FROM TableInfo
	declare @dbname varchar(125), @TBName varchar(125),@referenced_object_name varchar(125), @result int, @ProcName Varchar(50), @Msg Varchar(max)
	WHILE (1 = 1)
	BEGIN	
		select top(1)@dbname = DBName, @TBName = TBName from #T ORDER BY TBName desc
		IF @@ROWCOUNT = 0 BREAK	

	DELETE #T WHERE DBName = @dbname and TBName = @TBName
	
  begin try
	  exec @result = BackUpTable @kid = @kid, @dbname = @dbname, @TBName = @TBName, @VersionNo = @VersionNo
	end try
	begin catch
    Select @ProcName = Cast(ERROR_PROCEDURE() as Varchar),
           @Msg = '消息 ' + Cast(ERROR_NUMBER() as Varchar) + '，级别 ' + Cast(ERROR_SEVERITY() as Varchar) + '，状态 ' + Cast(ERROR_STATE() as Varchar) + 
                  '，过程 ' + Cast(ERROR_PROCEDURE() as Varchar) + '，第 ' + Cast(ERROR_LINE() as Varchar) + ' 行 ' + Cast(ERROR_MESSAGE() as Varchar)
	end catch
		IF @result = -1 
		GOTO ERRORReturn

	END

	while 1 = 0
	begin
	ERRORReturn:
	UPdate BackupApp.dbo.BackupWeb_History Set OperEndTime = GETDATE(), Result = -1, ProcName = @ProcName, Msg = @Msg Where ID = @ID
	SELECT '备份出错' RESULT		
	return
	end
	Finish:
	insert into BackupWebInfo(kid, VersionNo) 
		select @KID, @VersionNo
	UPdate BackupApp.dbo.BackupWeb_History Set OperEndTime = GETDATE(), Result = 1 Where ID = @ID
	SELECT '备份成功' RESULT
	DROP TABLE #T
END
GO

/****** Object:  StoredProcedure [dbo].[CheckIdentity]    Script Date: 2019/5/25 14:14:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      Master谭
-- Create date: 2013-07-26
-- Description:	检查自增属性
-- Memo:
*/
CREATE PROC [dbo].[CheckIdentity]
	@dbname varchar(125),	
	@TBName varchar(125),
	@IsIdentity bit output
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @S nvarchar(2000)
	set @IsIdentity = 0
	select @S = 'USE '+@dbname+'	
	Select @IsIdentity = 1 from sys.objects
           Where objectproperty(OBJECT_ID, ''TableHasIdentity'') = 1
             and name = @TBName
	'
--	PRINT @S
	EXEC SP_EXECUTESQL @S,N'@IsIdentity bit output, @TBName varchar(125)',	@IsIdentity output, @TBName = @TBName; 
END
GO

/****** Object:  StoredProcedure [dbo].[CheckReferenced]    Script Date: 2019/5/25 14:14:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      Master谭
-- Create date: 2013-07-26
-- Description:	检查主键表约束
-- Memo:
*/
CREATE PROC [dbo].[CheckReferenced]
	@dbname varchar(125),	
	@TBName varchar(125),
	@referenced_object_name varchar(125) output
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @S nvarchar(2000)
	set @referenced_object_name = null
	select @S = 'USE '+@dbname+'
	select @referenced_object_name = object_name(referenced_object_id)
	from sys.foreign_keys 
	where object_name(parent_object_id) = @TBName'
--	PRINT @S
	EXEC SP_EXECUTESQL @S,N'@referenced_object_name varchar(125) output, @TBName varchar(125)',	@referenced_object_name output, @TBName = @TBName; 
END
GO

/****** Object:  StoredProcedure [dbo].[GetBackupWeb_History]    Script Date: 2019/5/25 14:14:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*  
-- Author:      蔡杰
-- Create date: 2014-04-22  
-- Description: 获取备份记录
-- Memo:        GetBackupWeb_History 10, 1
*/   
CREATE Procedure [dbo].[GetBackupWeb_History]
@page int,
@size int, 
@type int
as

Declare @where Varchar(2000)
Select @where = ' BackupWeb_History Where type = ' + Cast(@type as Varchar) + ' Or -1 = ' + Cast(@type as Varchar)

exec sp_MutiGridViewByPager      
@fromstring = @where,      --数据集      
@selectstring =       
' KID, Oper, OperBgnTime, Case Result When 1 Then ''成功'' When -1 Then ''失败'' Else ''未执行'' End Result, type ',      --查询字段      
@returnstring =       
'KID, Oper, OperBgnTime, Result, type',      --返回字段      
@pageSize = @Size,                 --每页记录数      
@pageNo = @page,                     --当前页      
@orderString = ' OperBgnTime Desc ',          --排序条件      
@IsRecordTotal = 1,             --是否输出总记录条数      
@IsRowNo = 0           --是否输出行号
GO

/****** Object:  StoredProcedure [dbo].[RestoreDB]    Script Date: 2019/5/25 14:14:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      Master谭
-- Create date: 2013-06-29
-- Description:	过程用于还原备份
-- Memo: 
RestoreDB 'BBtest','C:\backup\FULL\BBtest\BBtest_Full_2013_06_29 14_37_50.bak', 'C:\backup\DIFF\BBtest\BBtest_Differential_2013_06_29 14_53_47.bak'
	
*/
CREATE PROC [dbo].[RestoreDB]
	@DBName NVARCHAR(50),
	@FULLBACKUP NVARCHAR(300),
	@DIFFBACKUP nvarchar(300)=NULL,
	@LOGBACKUP nvarchar(300)=NULL,
	@STOPAT datetime =NULL
as
BEGIN
	SET NOCOUNT ON	
	declare @sql varchar(max)
	set @LOGBACKUP = nullif(@LOGBACKUP,'')
	DECLARE @devname varchar(256)
	SELECT @devname = 'E:\backup\logbackup\'+ @DBName +'_LOG_' + REPLACE(REPLACE(CONVERT(Varchar(40), GETDATE(), 120),'-','_'),':','_') + '.bak';
	SET @sql = '	EXEC MASTER.[dbo].[p_killspid] '''+@DBName+'''
	BACKUP LOG '+ @DBName +' TO DISK =  '''+@devname+''''
	IF ISNULL(@DIFFBACKUP,'') = ''  and @LOGBACKUP is null and @STOPAT is null
	SET @sql = @sql +'
	RESTORE DATABASE '+ @DBName +'
		 FROM DISK = '''+@FULLBACKUP+'''
		 WITH RECOVERY;
		 '
	ELSE if @LOGBACKUP is null and @STOPAT is null
	SET @sql = @sql +'
	RESTORE DATABASE '+ @DBName +'
		 FROM DISK = '''+@FULLBACKUP+'''
		 WITH NORECOVERY;
	RESTORE DATABASE '+ @DBName +'
		 FROM DISK = '''+@DIFFBACKUP+'''
		 WITH RECOVERY;
		 '
	ELSE
	SET @sql = @sql +'
	RESTORE DATABASE '+ @DBName +'
		 FROM DISK = '''+@FULLBACKUP+'''
		 WITH NORECOVERY;
	RESTORE LOG '+ @DBName +'
		 FROM DISK = '''+ISNULL(@LOGBACKUP,@devname)+'''
		 WITH RECOVERY, STOPAT = '''+CONVERT(VARCHAR(19),@STOPAT,120)+''';
		 ' 
	PRINT @sql
	EXEC(@sql)
END
GO

/****** Object:  StoredProcedure [dbo].[ReStoreTable]    Script Date: 2019/5/25 14:14:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*    
-- Author:      Master谭    
-- Create date: 2013-07-26    
-- Description: 还原表    
-- Memo:    
SELECT * FROM BASICDATA_USER_CLASS WHERE VERSIONNO = 2    
    
declare @result int    
exec @result = ReStoreTable @kid = 12511, @dbname = 'Basicdata', @TBName = 'user_CLASS', @VersionNo = 3    
select @result    
*/    
CREATE PROC [dbo].[ReStoreTable]    
 @kid int,    
 @dbname varchar(125),    
 @TBName varchar(125),    
 @VersionNo int    
AS    
BEGIN    
 SET NOCOUNT ON    
     
 DECLARE @object_name_back varchar(125), @dbobject_name varchar(125), @FilStr varchar(2000), @S NVARCHAR(MAX), @S1 NVARCHAR(MAX),   
     @Keystr varchar(200), @USINGStr varchar(2000), @OnStr varchar(2000), @UpdateStr varchar(2000),     
     @InsertStr varchar(2000), @VersionCtrl varchar(2000),@DelFilStr varchar(2000), @DelExistGStr varchar(2000),     
     @DelOnStr varchar(200), @IsCanDel BIT    
 SELECT @FilStr = replace(replace(replace(replace(FilStr,']',''),'[',''),'..','_'),'.dbo.','_'),    
     @DelFilStr = FilStr,    
     @Keystr = Keystr, @VersionCtrl = VersionCtrl,     
     @IsCanDel = IsCanDel    
 FROM TableInfo     
  WHERE DBName = @dbname     
   and TBName = @TBName    
 IF @Keystr IS NULL    
 RETURN -1      
 IF charindex('@kid',@DelFilStr) = 0    
 RETURN -1       
 SET @dbobject_name = '['+@dbname + '].[dbo].['+ @TBName + ']'    
 set @object_name_back = '[dbo].['+@dbname + '_' + @TBName + ']'    
    
 Declare @temps NVARCHAR(MAX)
 select @temps = 'SELECT @Str = ''SELECT '' + STUFF(CommonFun.dbo.sp_GetSumStr('',a.[''+name+'']'' ),1,1,'''') + ''     
  FROM '+@object_name_back+' a     
  ' + @FilStr +' AND a.[VersionNo] = @VersionNo ' + @VersionCtrl + '''   
  from ' + @dbname + '.sys.columns     
  where object_id = object_id(''' + @dbobject_name + ''')     
   and name <> ''VersionNo'' '     

 Exec sp_executesql @temps, N'@Str Nvarchar(2000) output', @USINGStr output  
 Select @temps = ''

 select @OnStr = STUFF(CommonFun.dbo.sp_GetSumStr('and a.['+col+'] = b.['+col+'] '),1,3,'')    
   from BasicData.dbo.f_split(@Keystr,',')    
     
 select @DelOnStr = CommonFun.dbo.sp_GetSumStr(' and a.['+col+'] = ai.['+col+'] ')     
   from BasicData.dbo.f_split(@Keystr,',')     
 
 Select @temps = 'select @Str = ''WHEN MATCHED THEN    
 UPDATE SET ''+STUFF(CommonFun.dbo.sp_GetSumStr('',    
  b.[''+name+''] = a.[''+name+'']''),1,1,'''')    
  from ' + @dbname + '.sys.columns     
  where object_id = object_id(''' + @dbobject_name + ''')     
   and name <> ''VersionNo''    
   and name not in(select col from BasicData.dbo.f_split(''' + @Keystr + ''','',''))     
   and Not (name = ''id'' and ''' + @dbname + ''' = ''ClassApp'' and ''' + @TBName + ''' = ''class_notice_class'')    '

 Exec sp_executesql @temps, N'@Str Nvarchar(2000) output', @UpdateStr output  
 Select @temps = ''

 Select @temps = 'select @Str = ''INSERT (''+STUFF(CommonFun.dbo.sp_GetSumStr('', [''+name+'']''),1,2,'''')+'')    
 VALUES ('' +STUFF(CommonFun.dbo.sp_GetSumStr('', a.[''+name+'']''),1,2,'''') + '')''  
  from ' + @dbname + '.sys.columns     
  where object_id = object_id(''' + @dbobject_name + ''') and name <> ''VersionNo'' '   

 Exec sp_executesql @temps, N'@Str Nvarchar(2000) output', @InsertStr output  

 declare @IsIdentity bit     
     
 exec CheckIdentity  @dbname = @dbname, @TBName = @TBName, @IsIdentity = @IsIdentity output    
      
 SET @S = CASE WHEN @IsIdentity = 1 THEN '    
 SET IDENTITY_INSERT '+@dbobject_name+' ON ' + CHAR(10)   
 ELSE '' END +    
' ;MERGE '+@dbobject_name+' AS b    
 USING     
 (     
  '+@USINGStr+'    
 )AS a    
 ON ('+@OnStr+')    
 '+isnull(@UpdateStr,'')+'    
 WHEN NOT MATCHED THEN    
 '+@InsertStr+'; '    
 + CASE WHEN @IsIdentity = 1 THEN '    
 SET IDENTITY_INSERT '+@dbobject_name+' OFF ' + CHAR(10)   
 ELSE '' END + ';'    
   
Set @S = '  
Alter Table '+@dbobject_name+' Disable Trigger All     
' + @S + '    
Alter Table '+@dbobject_name+' Enable Trigger All '    
  
 Set @S1 = '    
 IF EXISTS( '+@USINGStr+' ) and '+CAST(@IsCanDel AS VARCHAR(10))+' = 1       
 delete '+@dbobject_name+'    
  FROM '+@dbobject_name+' a     
  '+@DelFilStr+'     
   and not exists    
    (    
     '+replace(replace(@USINGStr,' a.',' ai.'),' a ',' ai ')+'    
      '+ @DelOnStr + '     
    )       
        
'    
Set @S1 = 'Alter Table '+@dbobject_name+' Disable Trigger All     
' + @S1 + '    
Alter Table '+@dbobject_name+' Enable Trigger All '    
     
 PRINT @S1    
  EXEC SP_EXECUTESQL @S1,N'@kid INT, @VersionNo INT', @kid = @kid, @VersionNo = @VersionNo;     
  
 PRINT @S    
  EXEC SP_EXECUTESQL @S,N'@kid INT, @VersionNo INT', @kid = @kid, @VersionNo = @VersionNo;     
 RETURN 1    
END 
GO

/****** Object:  StoredProcedure [dbo].[RestoreWeb]    Script Date: 2019/5/25 14:14:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*  
-- Author:      Master谭  
-- Create date: 2013-07-26  
-- Description: 还原网站  
-- Memo:  
exec RestoreWeb @KID = 12511, @VersionNo = 1  
*/  
CREATE PROC [dbo].[RestoreWeb]  
 @KID INT,  
 @VersionNo INT,
 @Oper Varchar(50) = '系统'  
AS  
BEGIN  
SET NOCOUNT ON   
--SET @kid = 12511  
  
Select @VersionNo = MAX(VersionNo) From BackupWebInfo where kid = @KID

IF ISNULL(@VersionNo, 0) = 0
GOTO NoVersion  

Declare @ID Int
Insert Into BackupApp.dbo.BackupWeb_History(KID, Oper, type) Values (@KID, @Oper, 1)
Select @ID = Scope_Identity()

SELECT * INTO #T FROM TableInfo  
CREATE TABLE #T1(rowno int identity,dbname varchar(125), TBName varchar(125))  
declare @dbname varchar(125), @TBName varchar(125),@referenced_object_name varchar(125), @result int  
WHILE (1 = 1)  
BEGIN   
 select top(1)@dbname = DBName, @TBName = TBName from #T ORDER BY CASE WHEN DBName = 'Basicdata' THEN 0 ELSE 1 END  
 IF @@ROWCOUNT = 0 BREAK   
   
 WHILE 1 = 1   
 BEGIN  
  exec CheckReferenced @dbname = @dbname, @TBName= @TBName, @referenced_object_name = @referenced_object_name OUTPUT  
  IF @referenced_object_name IS NULL OR exists(select * from #T1 where dbname = @dbname and TBName = @referenced_object_name) BREAK  
  if @referenced_object_name = 'PageTpl' BREAK
  SELECT @TBName = @referenced_object_name   
 END  
 DELETE #T WHERE dbname = @dbname and TBName = @TBName  
 INSERT INTO #T1(dbname, TBName)   
  SELECT @dbname, @TBName  
  
 exec @result = ReStoreTable @kid = @kid, @dbname = @dbname, @TBName = @TBName, @VersionNo = @VersionNo  
 IF @result = -1   
 GOTO ERRORReturn  
  
END  

Declare @ProcName Varchar(50), @Msg Varchar(max)
while 1 = 0  
begin  
UPdate BackupApp.dbo.BackupWeb_History Set OperEndTime = GETDATE(), Result = -1, ProcName = @ProcName, Msg = @Msg Where ID = @ID
ERRORReturn:  
SELECT '还原出错'+@dbname+'_'+@TBName RESULT    
return  
end  
while 1 = 0  
begin  
NoVersion:  
SELECT '幼儿园'+CAST(@KID as varchar(10))+' 没有版本'+CAST(@VersionNo as varchar(10))+' 的备份' RESULT    
return  
end  
Finish:  
UPdate BackupApp.dbo.BackupWeb_History Set OperEndTime = GETDATE(), Result = 1 Where ID = @ID
SELECT '还原成功' RESULT  
DROP TABLE #T, #T1  
END
GO


