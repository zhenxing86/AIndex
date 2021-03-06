USE [BackupApp]
GO
/****** Object:  StoredProcedure [dbo].[BackupFull]    Script Date: 2014/11/24 21:16:10 ******/
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
