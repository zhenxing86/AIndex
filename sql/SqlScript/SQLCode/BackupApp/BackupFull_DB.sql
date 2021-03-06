USE [BackupApp]
GO
/****** Object:  StoredProcedure [dbo].[BackupFull_DB]    Script Date: 2014/11/24 21:16:10 ******/
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
