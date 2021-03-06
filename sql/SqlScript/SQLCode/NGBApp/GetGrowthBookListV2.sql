USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetGrowthBookListV2]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      xie    
-- Create date: 2014-02-08    
-- Description: 读取growthbook的数据    
-- Memo:  

select * from  BasicData..user_class_all 
where userid= 295765 
select * from  BasicData..class_all 
where cid= 46144
[GetGrowthBookListV2] 295765
*/    
--    
CREATE PROC [dbo].[GetGrowthBookListV2]    
 @userid int   
     
AS    
BEGIN    
 SET NOCOUNT ON     
 select gbid,uca.term,ca.cname,'0' as candownload from  growthbook g    
   inner join BasicData..user_class_all uca
    on g.userid=uca.userid 
    and uca.term=g.term and uca.deletetag=1  
   inner join BasicData..class_all ca
    on uca.cid=ca.cid 
    and uca.term=ca.term and ca.deletetag=1
  where g.userid=@userid   
  order by gbid desc  
     
     
END 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'读取growthbook的数据' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetGrowthBookListV2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetGrowthBookListV2', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
