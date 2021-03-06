USE [CommonFun]
GO
/****** Object:  StoredProcedure [dbo].[AutoFillByTA]    Script Date: 2014/11/24 22:58:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
--当前同步数据字典主表  
谭磊 2014-01-26 创建  

*/  
CREATE Procedure [dbo].[AutoFillByTA] 
AS        
BEGIN        
	Set NoCount On  
--	CREATE TABLE #TA(DbName VARCHAR(50),ObjName VARCHAR(50), subObjName VARCHAR(50), value nvarchar(4000))
	DECLARE @DbName VARCHAR(50),@ObjName VARCHAR(50), @subObjName VARCHAR(50), @value nvarchar(4000);
	DECLARE contact_cursor CURSOR FOR
	SELECT DbName,ObjName, subObjName, value 
	FROM #TA

	OPEN contact_cursor;
	FETCH NEXT FROM contact_cursor
	INTO @DbName,@ObjName, @subObjName, @value;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		exec CommonFun..XtendedpropertyEdit
			@type			= 0,-- 0新增 1修改 2删除 3标识作废 4取消标识作废	
			@dbname		= @dbname, -- 数据库名
			@value			= @value,  -- 说明文本
			@level1name	= @ObjName,  --对象名
			@level2name	= @subObjName,  -- 字段/参数名,
			@userName		= '谭磊' --操作人姓名
	FETCH NEXT FROM contact_cursor
	INTO @DbName,@ObjName, @subObjName, @value;
	END
	CLOSE contact_cursor;
	DEALLOCATE contact_cursor;
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'根据#TA后台自动填写数据字典描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'AutoFillByTA'
GO
