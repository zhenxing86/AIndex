use master
go
/*      
--同步单个对象  
谭磊 2014-01-16 创建   
*/  
ALTER Procedure [dbo].[sp_AutoFillObjectInfo]
AS        
BEGIN        
	Set NoCount On  
PRINT '/*
[sp_CheckObjectInfo] 
*/'
DECLARE @SQL nvarchar(max) = '
CREATE TABLE #TA(DbName VARCHAR(50),ObjName sysname, subObjName VARCHAR(200), value nvarchar(4000))'
DECLARE @cStr nvarchar(MAX),@pStr nvarchar(MAX),@oStr nvarchar(MAX)
	select @cStr = 'case c.name'+NULLIF(CommonFun.dbo.GetSumStr_New(DISTINCT '
when '''+c.name+''' THEN '''''),'') 
				from sys.objects o
				inner join sys.columns c on o.object_id = c.object_id
				left join sys.extended_properties  e on o.object_id = e.major_id and e.class = 1 AND c.column_id = e.minor_id AND e.name = 'MS_Description' 
			WHERE c.name not in('kid','cid','userid')
				and c.is_identity = 0
				and e.value is null
				and o.type in('U','V','P','TF','IF','FN','AF','FS','FT')
				and o.name not in(
				'sysdiagrams',
				'fn_diagramobjects',
				'sp_alterdiagram',
				'sp_creatediagram',
				'sp_dropdiagram',
				'sp_helpdiagramdefinition',
				'sp_helpdiagrams',
				'sp_renamediagram',
				'sp_upgraddiagrams')

	select @pStr = 'case p.name'+NULLIF(CommonFun.dbo.GetSumStr_New(DISTINCT '
when '''+p.name+''' THEN '''''),'') 
				from sys.objects o
				inner join sys.parameters p on o.object_id = p.object_id
				left join sys.extended_properties  e on o.object_id = e.major_id and e.class = 2 AND p.parameter_id = e.minor_id AND e.name = 'MS_Description' 
			WHERE p.parameter_id<>0 
				and p.name not in('@kid','@cid','@userid')
				and e.value is null
				and o.type in('U','V','P','TF','IF','FN','AF','FS','FT')
				and o.name not in(
				'sysdiagrams',
				'fn_diagramobjects',
				'sp_alterdiagram',
				'sp_creatediagram',
				'sp_dropdiagram',
				'sp_helpdiagramdefinition',
				'sp_helpdiagrams',
				'sp_renamediagram',
				'sp_upgraddiagrams')

				
				
	select @oStr = 'case o.name'+nullif(CommonFun.dbo.GetSumStr_New(DISTINCT '
when '''+o.name+''' THEN '''''),'') 
			FROM sys.objects o
				LEFT join sys.extended_properties e
					on o.object_id = e.major_id 
					and e.class = 1
					and e.minor_id = 0 
					and e.name = 'MS_Description'
			WHERE e.value is null
				and o.type in('U','V','P','TF','IF','FN','AF','FS','FT')
				and o.name not in(
				'sysdiagrams',
				'fn_diagramobjects',
				'sp_alterdiagram',
				'sp_creatediagram',
				'sp_dropdiagram',
				'sp_helpdiagramdefinition',
				'sp_helpdiagrams',
				'sp_renamediagram',
				'sp_upgraddiagrams')

SELECT @SQL
SET @SQL = ''
IF @cStr IS NOT NULL
BEGIN
SELECT  '
INSERT INTO #TA
	select DISTINCT db_name(), o.name , 
	c.name subObjName,'	
SELECT @cStr
SELECT '
ELSE NULL END VALUE
				from sys.objects o
				inner join sys.columns c on o.object_id = c.object_id
				left join sys.extended_properties  e on o.object_id = e.major_id and e.class = 1 AND c.column_id = e.minor_id AND e.name = ''MS_Description'' 
			WHERE c.name not in(''kid'',''cid'',''userid'')
				and c.is_identity = 0
				and e.value is null
				and o.type in(''U'',''V'',''P'',''TF'',''IF'',''FN'',''AF'',''FS'',''FT'')
				and o.name not in(
				''sysdiagrams'',
				''fn_diagramobjects'',
				''sp_alterdiagram'',
				''sp_creatediagram'',
				''sp_dropdiagram'',
				''sp_helpdiagramdefinition'',
				''sp_helpdiagrams'',
				''sp_renamediagram'',
				''sp_upgraddiagrams'')'

END
SET @SQL = ''
IF @pStr IS NOT NULL
begin
SELECT '
INSERT INTO #TA				
	select DISTINCT db_name(), o.name, 
	p.name,  
'
SELECT @pStr
SELECT 'ELSE NULL END VALUE
			from sys.objects o
				inner join sys.parameters p on o.object_id = p.object_id
				left join sys.extended_properties  e 
					on o.object_id = e.major_id 
					and e.class = 2 
					AND p.parameter_id = e.minor_id 
					AND e.name = ''MS_Description'' 
			WHERE p.parameter_id<>0 
				and e.value is null
				and o.type in(''U'',''V'',''P'',''TF'',''IF'',''FN'',''AF'',''FS'',''FT'')
				and o.name not in(
				''sysdiagrams'',
				''fn_diagramobjects'',
				''sp_alterdiagram'',
				''sp_creatediagram'',
				''sp_dropdiagram'',
				''sp_helpdiagramdefinition'',
				''sp_helpdiagrams'',
				''sp_renamediagram'',
				''sp_upgraddiagrams'')'
end		
SET @SQL = ''	
IF @oStr IS NOT NULL
BEGIN
SELECT '
INSERT INTO #TA				
	select DISTINCT db_name(), o.name, 
	null,  
'
SELECT @oStr
SELECT '
ELSE NULL END VALUE
			FROM sys.objects o
				LEFT join sys.extended_properties e
					on o.object_id = e.major_id 
					and e.class = 1
					and e.minor_id = 0 
					and e.name = ''MS_Description''
			WHERE e.value is null
				and o.type in(''U'',''V'',''P'',''TF'',''IF'',''FN'',''AF'',''FS'',''FT'')
				and o.name not in(
				''sysdiagrams'',
				''fn_diagramobjects'',
				''sp_alterdiagram'',
				''sp_creatediagram'',
				''sp_dropdiagram'',
				''sp_helpdiagramdefinition'',
				''sp_helpdiagrams'',
				''sp_renamediagram'',
				''sp_upgraddiagrams'')
		
'	

END
SET @SQL =  '
SELECT * FROM #TA ORDER BY subObjName, ObjName
delete #TA WHERE VALUE IS NULL OR VALUE = ''''
SELECT * FROM #TA 
EXEC Commonfun..AutoFillByTA
DROP TABLE #TA
'
SELECT @SQL

END
GO
EXEC sp_MS_marksystemobject 'dbo.sp_AutoFillObjectInfo'; 