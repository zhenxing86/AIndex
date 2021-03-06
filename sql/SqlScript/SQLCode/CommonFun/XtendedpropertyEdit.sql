USE [CommonFun]
GO
/****** Object:  StoredProcedure [dbo].[XtendedpropertyEdit]    Script Date: 2014/11/24 22:58:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
--当前同步数据字典主表  
谭磊 2014-01-16 创建   
*/  
CREATE Procedure [dbo].[XtendedpropertyEdit]
 @type int,---- 0新增 1修改 2删除 3标识作废 4取消标识作废	
 @dbname sysname,
 @name sysname = 'MS_Description', --MS_Description, Abolish
 @value sql_variant   = NULL,  
 @level1type varchar(128) = NULL,  --TABLE, VIEW, FUNCTION, PROCEDURE
 @level1name sysname   = NULL,  
 @level2type varchar(128) = NULL,  --COLUMN, PARAMETER
 @level2name sysname   = NULL,
 @userName varchar(50) = null  
AS        
BEGIN        
	Set NoCount On  
	IF @name NOT IN('MS_Description', 'Abolish') RETURN
	IF @level1type NOT IN('TABLE', 'VIEW', 'FUNCTION', 'PROCEDURE') RETURN
	IF isnull(@level2type,'NULL') NOT IN('COLUMN', 'PARAMETER', 'NULL') RETURN
	IF @type IN(3,4) 
	BEGIN
		SET @name = 'Abolish'
		SET @value = '作废'
		IF @type = 3
		SET @type = 0
		IF @type = 4
		SET @type = 2
	END
	IF @level1name IS NOT NULL AND @level1type IS NULL
	SELECT @level1type = 
					CASE Type 
					WHEN 'U' THEN 'TABLE' 
					WHEN 'V' THEN 'VIEW' 
					WHEN 'P' THEN 'PROCEDURE' 
					WHEN 'AF' THEN 'AGGREGATE' 
					ELSE 'FUNCTION' END 
		FROM Object_List WHERE DBName = @dbname and Name = @level1name
	IF @level1name IS NOT NULL AND @level1type IS NULL RETURN
	IF @level2name IS NOT NULL
	BEGIN
		IF charindex('@',@level2name) = 1
		SET @level2type = 'PARAMETER'
		else 
		SET @level2type = 'COLUMN'
	END
	DECLARE @SQL NVARCHAR(MAX), @ParmDefinition NVARCHAR(4000)
	DECLARE @Msg nvarchar(200) = '操作成功'
	DECLARE @level0type varchar(128) = 'SCHEMA', @level0name sysname = 'dbo' 
				SET @ParmDefinition = 
				N' @Msg nvarchar(200) output, 
					 @name sysname,
					 @value sql_variant   = NULL, 
					 @level0type varchar(128) = NULL,  
					 @level0name sysname   = NULL,  
					 @level1type varchar(128) = NULL,
					 @level1name sysname   = NULL,  
					 @level2type varchar(128) = NULL,
					 @level2name sysname   = NULL,
					 @userName VARCHAR(50) = NULL
					 ' 				
				select @SQL = '	
				Begin tran  			
				BEGIN TRY
				USE '+@dbname+'
				EXECUTE sp_'+CASE @type WHEN 0 then 'add' when 1 then 'update' when 2 then 'drop' end +'extendedproperty 
					@name = @name, 
					@level0type = @level0type, 
					@level0name = @level0name, 
					@level1type = @level1type, 
					@level1name = @level1name, 
					@level2type = @level2type, 
					@level2name = @level2name
				' 				
				IF @type IN(0,1)	 
				SET @SQL = @SQL + ',@value = @value  '; 
				SET @SQL = @SQL + '
				 exec sp_SynObjectInfo @objtype = @level1type, @objname = @level1name, @userName = @userName
				 Commit tran  
				End Try      
				Begin Catch     
					Rollback tran  
					SELECT @Msg = error_message()
				end Catch  '; 				
				--PRINT @SQL	
				EXEC SP_EXECUTESQL @SQL,@ParmDefinition,	
					@Msg = @Msg output,					
					@name = @name, 
					@level0type = @level0type, 
					@level0name = @level0name, 
					@level1type = @level1type, 
					@level1name = @level1name, 
					@level2type = @level2type, 
					@level2name = @level2name,
					@value = @value,
					@userName = @userName; 
				 
				SELECT @Msg Msg
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改数据字典描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'XtendedpropertyEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0新增 1修改 2删除 3标识作废 4取消标识作废' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'XtendedpropertyEdit', @level2type=N'PARAMETER',@level2name=N'@type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'XtendedpropertyEdit', @level2type=N'PARAMETER',@level2name=N'@dbname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MS_Description, Abolish' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'XtendedpropertyEdit', @level2type=N'PARAMETER',@level2name=N'@name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'说明描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'XtendedpropertyEdit', @level2type=N'PARAMETER',@level2name=N'@value'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'level1类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'XtendedpropertyEdit', @level2type=N'PARAMETER',@level2name=N'@level1type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'level1名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'XtendedpropertyEdit', @level2type=N'PARAMETER',@level2name=N'@level1name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'level2类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'XtendedpropertyEdit', @level2type=N'PARAMETER',@level2name=N'@level2type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'level2名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'XtendedpropertyEdit', @level2type=N'PARAMETER',@level2name=N'@level2name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'填写人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'XtendedpropertyEdit', @level2type=N'PARAMETER',@level2name=N'@userName'
GO
