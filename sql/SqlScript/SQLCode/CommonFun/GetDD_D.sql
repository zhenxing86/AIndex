USE [CommonFun]
GO
/****** Object:  StoredProcedure [dbo].[GetDD_D]    Script Date: 2014/11/24 22:58:53 ******/
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
CREATE Procedure [dbo].[GetDD_D]
 @dbname sysname,
 @Objname sysname  
AS        
BEGIN        
	Set NoCount On  
	DECLARE @SQL NVARCHAR(MAX)				 				
	select @SQL = '					
	USE '+@dbname+'
	EXECUTE sp_GetColInfo 
	@Objname = @Objname'; 				
	EXEC SP_EXECUTESQL 
	@SQL,
	N'@Objname sysname',	
	@Objname = @Objname; 
				 
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'查看数据字典明细表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDD_D'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDD_D', @level2type=N'PARAMETER',@level2name=N'@dbname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'对象名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDD_D', @level2type=N'PARAMETER',@level2name=N'@Objname'
GO
