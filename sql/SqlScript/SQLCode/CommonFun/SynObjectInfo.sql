USE [CommonFun]
GO
/****** Object:  StoredProcedure [dbo].[SynObjectInfo]    Script Date: 2014/11/24 22:58:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
--当前同步数据字典主表  
谭磊 2013-03-10 创建  
AF = 聚合函数 (CLR)
FN = SQL 标量函数
FS = 程序集 (CLR) 标量函数
FT = 程序集 (CLR) 表值函数
IF = SQL 内联表值函数
P = SQL 存储过程
TF = SQL 表值函数
U = 表（用户定义类型）
V = 视图    
*/  
CREATE Procedure [dbo].[SynObjectInfo] 
AS        
BEGIN        
	Set NoCount On  
	DECLARE @SQL NVARCHAR(4000) 	
	  CREATE  TABLE #T
	  (DBName nvarchar(100) NOT NULL,Object_id int NOT NULL, 
	  Type char(2) NOT NULL, Name nvarchar(100) NOT NULL, Descript sql_variant, Abolish sql_variant, UpdateTime datetime) 
	  ALTER TABLE #T ADD CONSTRAINT	PK_SynObjectInfo_T PRIMARY KEY CLUSTERED (DBName, Object_id) WITH(IGNORE_DUP_KEY = ON) 

    SET @SQL = N'
    USE [?]
    IF db_Name () not in(''master'',''model'',''msdb'',''tempdb'',''mcapptemp'')
		insert into #T(DBName, Object_id, Type, Name, Descript, Abolish, UpdateTime)
			Select db_Name (), o.Object_id, o.Type, o.name, e.[value], e1.[value], o.modify_date 
				FROM sys.objects o
					left join sys.extended_properties e
						on o.object_id = e.major_id 
						and e.class = 1
						and e.minor_id = 0 
						and e.name = ''MS_Description''
					left join sys.extended_properties e1
						on o.object_id = e1.major_id 
						and e1.class = 1
						and e1.minor_id = 0 
						and e1.name = ''Abolish''
				where o.type in(''U'',''V'',''P'',''TF'',''IF'',''FN'',''AF'',''FS'',''FT'')
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

	EXEC  sys.sp_MSforeachdb @SQL
		Delete ol 
		from Object_List ol
			left join #T t 
				on ol.DBName = t.DBName
				and ol.Object_id = t.Object_id
			WHERE t.Object_id is null
			
		insert into Object_List(DBName, Object_id, Type, Name, Descript, UpdateTime)   	
			SELECT t.DBName, t.Object_id, t.Type, t.Name, t.Descript, t.UpdateTime 
				FROM #T t 
					left join Object_List ol
					on ol.DBName = t.DBName
					and ol.Object_id = t.Object_id
				WHERE ol.Object_id is null				

	DECLARE @DBStr nvarchar(2000)
		SELECT @DBStr = STUFF(dbo.GetSumStr_New(DISTINCT ','''+ol.DBName+'''') ,1,1,'')
			FROM Object_List ol
				inner join #T t 
					on ol.DBName = t.DBName
					and ol.Object_id = t.Object_id
			WHERE ISNULL(ol.UpdateTime ,0) <> ISNULL(t.UpdateTime ,0)	
				and ol.Is_FullFill = 1

	IF @DBStr IS NOT NULL
	BEGIN	
	  CREATE  TABLE #FullFill(DBName nvarchar(100) NOT NULL, Object_id int NOT NULL) 
	  CREATE unique INDEX idx_ on #FullFill(DBName, Object_id)WITH (IGNORE_DUP_KEY = ON)
		--以下部分不允许修改插入#T的字段    
/*================================================================================*/
    SET @SQL = N'
    USE [?]
    IF db_Name() not in('+@DBStr+')
    BEGIN
		insert into #FullFill(DBName, Object_id)
			select DISTINCT DB_Name(),	o.object_id
				from sys.objects o
					inner join sys.columns c on o.object_id = c.object_id
					left join sys.extended_properties  e 
						on o.object_id = e.major_id 
						and e.class = 1 
						AND c.column_id = e.minor_id 
						AND e.name = ''MS_Description'' 
				WHERE c.name not in(''kid'',''cid'',''userid'',''deletetag'')
					and c.is_identity = 0
					and e.value is null
		union
			select DISTINCT DB_Name(), o.object_id
				from sys.objects o
					inner join sys.parameters p on o.object_id = p.object_id
					left join sys.extended_properties  e 
						on p.object_id = e.major_id and e.class = 2 AND p.parameter_id = e.minor_id AND e.name = ''MS_Description'' 
			where p.name not in(''@kid'',''@cid'',''@userid'')
				and p.parameter_id <> 0 				
		END
'
	
	EXEC  sys.sp_MSforeachdb @SQL
			
		UPDATE ol SET Is_FullFill = CASE WHEN ol.Descript IS NOT NULL And f.Object_id is null then 1 else 0 end
			from Object_List ol
				inner join #T t 
					on ol.DBName = t.DBName
					and ol.Object_id = t.Object_id
					AND ISNULL(ol.UpdateTime ,0) <> ISNULL(t.UpdateTime ,0)	
					and ol.Is_FullFill = 1
				LEFT join #FullFill f 
					on ol.DBName = f.DBName
					and ol.Object_id = f.Object_id
			WHERE  ol.Is_FullFill <> CASE WHEN ol.Descript IS NOT NULL And f.Object_id is null then 1 else 0 end
	END

	UPDATE ol 
		SET UpdateTime = t.UpdateTime
		from Object_List ol
			inner join #T t 
				on ol.DBName = t.DBName
				and ol.Object_id = t.Object_id
			WHERE ISNULL(ol.UpdateTime ,0) <> ISNULL(t.UpdateTime, 0)	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用于同步数据字典主表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SynObjectInfo'
GO
