use master
go
/*      
--检查单个对象名的一致性  
谭磊 2014-01-16 创建   
[sp_CheckObjectInfo] 'gbModList'
*/  
alter Procedure [dbo].[sp_CheckObjectInfo]
  @NAME varchar(50) = null
AS        
BEGIN        
	Set NoCount On  
 CREATE table #T(name SYSNAME, subname varchar(200),value sql_variant)
 INSERT INTO #T(name, subname,value)
 select o.name, null, e.value
 			FROM sys.objects o
				LEFT join sys.extended_properties e
					on o.object_id = e.major_id 
					and e.class = 1
					and e.minor_id = 0 
					and e.name = 'MS_Description'
			WHERE o.type in('U','V','P','TF','IF','FN','AF','FS','FT')
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
				and (o.name = @NAME or @NAME is null)
 
 INSERT INTO #T(name, subname, value)
 select o.name, c.name, e.value
 from sys.objects o
				inner join sys.columns c on o.object_id = c.object_id
				left join sys.extended_properties  e on o.object_id = e.major_id and e.class = 1 AND c.column_id = e.minor_id AND e.name = 'MS_Description' 
	WHERE c.name not in('kid','cid','userid')
				and c.is_identity = 0
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
				and (c.name = @NAME or @NAME is null)

 INSERT INTO #T(name, subname, value)				
 select o.name, p.name, e.value				
			from sys.objects o
				inner join sys.parameters p on o.object_id = p.object_id
				left join sys.extended_properties  e on o.object_id = e.major_id and e.class = 2 AND p.parameter_id = e.minor_id AND e.name = 'MS_Description' 
			WHERE  p.name not in('@kid','@cid','@userid')
				and p.parameter_id<>0 
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
				and (p.name = @NAME or @NAME is null)
	select * 
		from #T a where exists(select * from #T b where a.name = b.name and ISNULL(a.subname,'') = ISNULL(b.subname,'') and b.value is null)	
		ORDER BY case when subname IS null then name else REPLACE(subname,'@','') END,  name, value 
	DROP TABLE #T
END
GO
EXEC sp_MS_marksystemobject 'dbo.sp_CheckObjectInfo'; 