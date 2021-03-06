USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetGrowthBook_PermissionList]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      xie    
-- Create date: 2014-01-20  
-- Description: 读取growthbook下载权限表的数据    
-- Memo:    
[GetGrowthBook_PermissionList] 12511  
*/    
--    
CREATE PROC [dbo].[GetGrowthBook_PermissionList]    
 @kid int   
AS    
BEGIN    
 SET NOCOUNT ON     
 select ID,kid,term,bgntime,endtime,candown,deletetag   
  from  GrowthBook_Permission gp    
  where gp.kid=@kid   
   and gp.deletetag = 1  
     
END 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'读取growthbook下载权限表的数据' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetGrowthBook_PermissionList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetGrowthBook_PermissionList', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
