USE master
GO
/*
	-- Author:      Master̷
	-- Create date: 2013-06-6
	-- Description:
	-- Paradef: 
	-- Memo:
*/ 
CREATE PROC sp_GetTbSpace	
AS
BEGIN
	SET NOCOUNT ON
	CREATE TABLE #TB_TEMP_SPACE(
		NAME VARCHAR(500)
		,ROWS INT
		,RESERVED VARCHAR(50)
		,DATA VARCHAR(50)
		,INDEX_SIZE VARCHAR(50)
		,UNUSED VARCHAR(50)		)
	EXEC SP_MSFOREACHTABLE 'INSERT INTO #TB_TEMP_SPACE exec sp_spaceused ''?'''
	SELECT *
	FROM #TB_TEMP_SPACE
	ORDER BY REPLACE(DATA,'KB','')+0 DESC
END
GO

USE master;EXEC sp_MS_marksystemobject 'dbo.sp_GetTbSpace';  
GO