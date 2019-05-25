USE master
GO
/*
	-- Author:      Master̷
	-- Create date: 2013-06-6
	-- Description:
	-- Paradef: 
	-- Memo:
*/ 
ALTER PROC sp_FindObject	
	@S NVARCHAR(100),
	@T NVARCHAR(10)=NULL
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @SQL NVARCHAR(4000);
	    CREATE  TABLE #T(DBName nvarchar(100), name nvarchar(100))     
    SET @SQL = N'
    USE [?]
		insert into #T
			Select distinct db_Name () , name from sys.sysobjects where name like   ''%'+@S+'%'' escape ''/'' and name not like ''%TLdelete''
'
IF ISNULL(@T,'')<>''
SET @SQL = @SQL + ' AND type = '''+@T+''' '
EXEC  sys.sp_MSforeachdb @SQL 

    select * from #T 
END
GO

USE master;EXEC sp_MS_marksystemobject 'dbo.sp_FindObject';  
GO