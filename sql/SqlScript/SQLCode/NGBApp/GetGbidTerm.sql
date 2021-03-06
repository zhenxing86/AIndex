USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetGbidTerm]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
/*        
-- Author:      Master谭        
-- Create date: 2013-12-3        
-- Description: 读取成长档案的学期信息       
-- Memo:use ngbapp        
exec GetGbidTerm 558921      
  
 select gb.gbid, g.gname + CASE WHEN RIGHT(gb.term,1) = '1' then '上学期' ELSE '下学期' END term      
  from growthbook gb    
   inner join BasicData..[User_class_all] uca   
    on gb.userid=uca.userid and gb.term=uca.term and uca.deletetag=1  
   inner join BasicData..[class_all] ca   
    on uca.cid=ca.cid and uca.term=ca.term and ca.deletetag =1  
   inner join BasicData..grade g       
    on ca.grade = g.gid      
  where gb.userid = 558921      
 ORDER BY gb.term DESC   
*/        
--        
CREATE PROC [dbo].[GetGbidTerm]      
 @userid bigint      
AS      
BEGIN        
 SET NOCOUNT ON      
     
 --declare @gname nvarchar(10)    
 --select @gname =g.gname    
 -- from BasicData..[User_Child] uc     
 --  inner join BasicData..grade g       
 --   on uc.grade = g.gid      
 -- where userid=@userid    
     
 --if @@ROWCOUNT=0    
 -- select @gname =g.gname    
 -- from BasicData..[User] u    
 --  inner join BasicData..leave_user_class luc      
 --   on luc.userid=u.userid    
 --  inner join BasicData..class c      
 --   on c.cid=luc.cid    
 --  inner join BasicData..grade g       
 --   on c.grade = g.gid      
 -- where u.userid=@userid    
  
  declare @term nvarchar(6)    
select @term = commonFun.dbo.fn_getCurrentTerm(isnull(kid,0),GETDATE(),1)    
 from BasicData..[user] where userid=@userid    
         
 if not exists(select gbid from ngbapp..growthbook where userid=@userid and term=@term)
 begin
    declare @cid int=0
    select @cid=cid from BasicData..user_class where userid= @userid
	exec ngbapp..init_growthbook @cid, @term
 end
 
 select gb.gbid, g.gname + CASE WHEN RIGHT(gb.term,1) = '1' then '上学期' ELSE '下学期' END term      
  from growthbook gb    
   inner join BasicData..[User_class_all] uca   
    on gb.userid=uca.userid and gb.term=uca.term and uca.deletetag=1  
   inner join BasicData..[class_all] ca   
    on uca.cid=ca.cid and uca.term=ca.term and ca.deletetag =1  
   inner join BasicData..grade g       
    on ca.grade = g.gid      
  where gb.userid = @userid      
 ORDER BY gb.term DESC      
     
     
      
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'读取成长档案的学期信息 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetGbidTerm'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetGbidTerm', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
