USE master
GO
/*
	-- Author:      Master̷
	-- Create date: 2013-06-6
	-- Description:
	-- Paradef: 
	-- Memo:
*/ 
CREATE PROC sp_FindP	
	@S	NVARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @SQL NVARCHAR(4000);
	    CREATE  TABLE #T(DBName nvarchar(100), name nvarchar(100))     
    SET @SQL = N'
		insert into #T
			Select distinct db_Name () , a.name from sys.sysobjects a, sys.syscomments b
				where a.id = b.id and b.text like   ''%'+@S+'%'' escape ''/'' and a.name not like ''%TLdelete''
'
EXEC  (@SQL) 

    select * from #T 
END
GO

USE master;EXEC sp_MS_marksystemobject 'dbo.sp_FindP';  
GO