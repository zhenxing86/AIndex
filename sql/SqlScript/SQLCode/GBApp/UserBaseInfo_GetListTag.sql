USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[UserBaseInfo_GetListTag]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------      
--用途：得到用户的详细信息      
--项目名称：ArchivesApply      
--说明：下载成长档案      
--select * from growthbook where userid=280153      
--时间：-1-6 11:50:29      
    
exec [UserBaseInfo_GetListTag] 655163,'2014-0',1 ,'2014-1'     
*/    
------------------------------------       
CREATE  PROCEDURE [dbo].[UserBaseInfo_GetListTag]      
@userid int,      
@term nvarchar(50),      
@flag int,    
@curterm nvarchar(50)='2014-0'  --已经废弃    
      
 AS       
begin   

 declare @isvip int =0
 select @isvip = case when a.ftime<=GETDATE() And a.ltime>=GETDATE() And a3>0 then 1 else 0 end
  from ossapp..addservice a 
   where a.deletetag=1 and a.[uid]=@userid and a.describe='开通'  --and a.vippaystate=1  
       
 if(@flag=0)      
 begin      
    
  select  u.userid,u.name,k.kid,k.kname,uca.cid,ca.cname,g.gid,g.gname,isnull(p.re_beancount,0) beancount,      
    @isvip,'',@term,gb.gbid      
   from BasicData..[user] u       
   inner join BasicData..user_class_all uca   
    on uca.userid =u.userid and uca.term=@term     
   inner join BasicData..class_all ca   
    on ca.cid =uca.cid and uca.term=ca.term    
   inner join BasicData..kindergarten k   
    on k.kid=ca.kid      
   inner join GBApp..GrowthBook gb   
    on gb.userid = u.userid and gb.term=@term      
   inner join BasicData..grade g on g.gid = ca.grade      
   left join PayApp..user_pay_account p on p.userid=u.userid        
   where u.userid=@userid     
 end      
 else      
 begin      
  select  u.userid,u.name,k.kid,k.kname,uca.cid,ca.cname,g.gid,g.gname,isnull(p.re_beancount,0) beancount,      
    @isvip,'',@term,gb.gbid      
   from BasicData..[user] u       
   inner join BasicData..user_class_all uca   
    on uca.userid =u.userid and uca.term=@term     
   inner join BasicData..class_all ca   
    on ca.cid =uca.cid and uca.term=ca.term    
   inner join BasicData..kindergarten k   
    on k.kid=ca.kid      
   inner join NGBApp..GrowthBook gb   
    on gb.userid = u.userid and gb.term=@term      
   inner join BasicData..grade g on g.gid = ca.grade        
   left join PayApp..user_pay_account p on p.userid=u.userid        
   where u.userid=@userid      
    
 end      
end   
  
  
  
GO
