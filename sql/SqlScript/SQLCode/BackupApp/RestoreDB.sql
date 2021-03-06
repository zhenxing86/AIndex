USE [BackupApp]
GO
/****** Object:  StoredProcedure [dbo].[RestoreDB]    Script Date: 2014/11/24 21:16:10 ******/
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
