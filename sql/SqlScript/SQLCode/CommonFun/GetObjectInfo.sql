use CommonFun
go
/*      
--当前数据库的数据表数据字典  
谭磊 2014-01-16 创建     
*/  
ALTER Procedure [dbo].[GetObjectInfo]
AS        
BEGIN        
	Set NoCount On  
	 	DECLARE @SQL NVARCHAR(4000), @PreTid int;
	 	SET @PreTid = OBJECT_ID('tempdb..#T')
	 	IF @PreTid IS NULL 
	  CREATE  TABLE #T(DBName nvarchar(100),Object_id int, Type char(2), Name nvarchar(100), 
	  Descript sql_variant, Abolish sql_variant, UpdateTime datetime) 
	--以下部分不允许修改插入#T的字段    
/*================================================================================*/

/*================================================================================*/
	IF @PreTid IS NULL  
	SELECT * FROM #T ORDER BY DBName,type,name

END
GO
go