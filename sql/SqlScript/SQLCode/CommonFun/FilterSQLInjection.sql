USE CommonFun
GO
/*
	-- Author:      Master̷
	-- Create date: 2013-06-15
	-- Description:
	-- Paradef: 
	-- Memo: select CommonFun.dbo.FilterSQLInjection('sdfs/*sel*/ec')
*/ 
ALTER FUNCTION FilterSQLInjection(@cols NVARCHAR(2000))
	RETURNS NVARCHAR(2000)
AS
BEGIN
	SET @cols = REPLACE(@cols,N'0x','')  
	SET @cols = REPLACE(@cols,N';','')  
	SET @cols = REPLACE(@cols,N'''','')  
	SET @cols = REPLACE(@cols,N'--','')  
	SET @cols = REPLACE(@cols,N'/*','') 
	SET @cols = REPLACE(@cols,N'*/','')  
	SET @cols = REPLACE(@cols,N'EXEC','')  
	SET @cols = REPLACE(@cols,N'xp_','')  
	SET @cols = REPLACE(@cols,N'sp_','')  
	SET @cols = REPLACE(@cols,N'SELECT','')  
	SET @cols = REPLACE(@cols,N'INSERT','')  
	SET @cols = REPLACE(@cols,N'UPDATE','')  
	SET @cols = REPLACE(@cols,N'DELETE','')  
	SET @cols = REPLACE(@cols,N'TRUNCATE','')  
	SET @cols = REPLACE(@cols,N'CREATE','')  
	SET @cols = REPLACE(@cols,N'ALTER','')  
	SET @cols = REPLACE(@cols,N'DROP','')
	SET @cols = REPLACE(@cols,N'DATABASE','')  
	SET @cols = REPLACE(@cols,N'TABLE','')  

	RETURN @cols
END