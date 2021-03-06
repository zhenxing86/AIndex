USE [CommonFun]
GO
/****** Object:  StoredProcedure [dbo].[GetDD_Model]    Script Date: 2014/11/24 22:58:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
--查看数据字典明细表  
谭磊 2014-01-17 创建  
GetDD_D 'COMMONFUN','fn_MutiSplitTSQL_New' 
GetDD_D 'COMMONFUN','sp_GetSumStr' 
select * from Object_List where type = 'AF'
*/  
CREATE Procedure [dbo].[GetDD_Model]
 @dbname sysname,
 @Objname sysname,
 @SubObjname sysname = null 
AS        
BEGIN        
	Set NoCount On;
	IF isnull(@SubObjname,'') = ''
	select DBName, Object_id, Type, Name, Descript, UpdateTime, Is_FullFill, Is_Abolish, userName,ModifyTime 
	from Object_List 
	where DBName = @dbname
	and Name = @Objname
	ELSE
	BEGIN  
		DECLARE @SQL NVARCHAR(MAX)				 				
		select @SQL = '					
		USE '+@dbname+'
		EXECUTE sp_GetColInfoModel 
		@Objname = @Objname,
		@SubObjname = @SubObjname'; 				
		EXEC SP_EXECUTESQL 
		@SQL,
		N'@Objname sysname,
			@SubObjname sysname',	
		@Objname = @Objname,
		@SubObjname = @SubObjname; 
	END			 
END
GO
