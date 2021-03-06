USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[getgbinfo]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
            
--select * from growthbook where gbid=154676            
              
CREATE PROCEDURE [dbo].[getgbinfo]              
@cid int           
,@term nvarchar(10)='2013-0'            
 AS              
    
declare @kid int =0    
    
select @kid = kid from  BasicData..class    
 where cid=@cid      
    
if @kid=14938    
begin      
 select gb.gbid,uc.name            
  from growthbook gb inner join BasicData..User_Child uc     
   on gb.userid=uc.userid       
  where uc.cid=@cid and  gb.term=@term      
  order by uc.name             
end    
else    
begin    

 select gb.gbid            
      ,c.child_name            
    from growthbook gb left join homebook hb on gb.hbid=hb.hbid             
 left join childreninfo c on gb.gbid=c.gbid               
 where hb.term=@term                     
 and hb.classid=@cid            
 order by c.child_name  
 
 
 --select gb.gbid            
 --     ,c.child_name            
 --   from growthbook gb left join homebook hb on gb.hbid=hb.hbid             
 --left join childreninfo c on gb.gbid=c.gbid            
 --inner join basicdata..[user] u on gb.userid=u.userid       
 --inner join BasicData..child ch on gb.userid=ch.userid and ch.vipstatus=1           
 --inner join basicdata..user_class uc on u.userid=uc.userid            
 --where u.deletetag=1 and  uc.cid=@cid and            
 -- hb.term=@term          
 ----and gb.gbid=68955            
 ----and gb.userid=384921            
 --and hb.classid=@cid            
 --order by c.child_name      
end           
    
        
--select * from basicdata..class where kid=14938            
    
            
            
            
            
            
            
            
            
            
            
GO
