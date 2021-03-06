USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_child_diseases_history]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  yz    
-- Create date: 2014-7-28    
-- Description: 幼儿疾病史情况    
--[dbo].[rep_child_diseases_history] 12511,-1    
-- =============================================   
CREATE PROCEDURE [dbo].[rep_child_diseases_history]    
@kid int,    
@gid int    
    
AS    
BEGIN    
 SET NOCOUNT ON;    
 
 select '掌握本园幼儿的疾病史情况<br />能够更好地创造适应患病幼儿学习的环境，减少意外伤害的发生'string
 
 -------------------------------

 create table #t(gorder int,corder int,class varchar(50),name varchar(50),title varchar(50))    
     
 if @gid = -1    
 begin    
     
 insert into #t(gorder,corder,class,name,title)    
 select g.[order],    
        c.[order],    
        c.cname class,    
        u.name name,    
        h.title title    
         
    from [healthapp].[dbo].[hc_user_health] uh    
   inner join [HealthApp].[dbo].[hc_health] h    
     on uh.hid = h.hid    
   inner join BasicData..[user] u    
     on uh.userid= u.userid    
   inner join BasicData..user_class uc     
     on uh.userid = uc.userid    
   inner join BasicData..class c    
     on uc.cid = c.cid    
   -- and u.kid = c.kid    
   left join BasicData..grade g    
     on g.gid = c.grade    
   where u.kid = @kid    
     and h.[types] = '遗传病史' and h.custom_user = 0   
   order by name    
       
   end    
       
   else    
       
   begin    
       
    insert into #t(gorder,corder,class,name,title)    
    select g.[order],    
        c.[order],    
        c.cname class,    
        u.name name,    
        h.title title    
            
    from [healthapp].[dbo].[hc_user_health] uh    
   inner join [HealthApp].[dbo].[hc_health] h    
     on uh.hid = h.hid    
   inner join BasicData..[user] u    
     on uh.userid= u.userid    
   inner join BasicData..user_class uc     
     on uh.userid = uc.userid    
   inner join BasicData..class c    
     on uc.cid = c.cid    
   -- and u.kid = c.kid    
   left join BasicData..grade g    
     on g.gid = c.grade    
   where u.kid = @kid    
     and c.grade = @gid    
     and h.[types] = '遗传病史' and h.custom_user = 0   
   order by name    
   end    
       
   select distinct t.gorder,t.corder,t.name,t.class into #p from #t t    
       
   select p.gorder,    
          p.corder,    
          p.class,    
          p.name,    
          stuff((    
                 select '，'+ title     
                   from #t     
                  where p.name = name     
                  order by title     
                    for xml path('')     
                ),1,1,'') title    
     from #p p    
         
     order by class    
         
   drop table #t,#p    
       
                                                                                                                              
END 
GO
