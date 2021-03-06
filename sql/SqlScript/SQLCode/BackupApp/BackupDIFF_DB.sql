USE [BackupApp]
GO
/****** Object:  StoredProcedure [dbo].[BackupDIFF_DB]    Script Date: 2014/11/24 21:16:10 ******/
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
