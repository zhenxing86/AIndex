USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[GetGrowthBookListV2]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      xie    
-- Create date: 2014-02-08    
-- Description: 读取growthbook的数据    
-- Memo:    
[GetGrowthBookList] 295765,'2013-1'     
*/    
--    
CREATE PROC [dbo].[GetGrowthBookListV2]    
 @userid int   
     
AS    
BEGIN    
 SET NOCOUNT ON     
 select gbid,term,c.cname,'0' as candownload from  growthbook g    
   left join BasicData..user_class uc on g.userid=uc.userid    
   left join BasicData..class c on uc.cid=c.cid    
  where g.userid=@userid   
  order by gbid desc  
     
     
END 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'读取growthbook的数据' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetGrowthBookListV2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetGrowthBookListV2', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
