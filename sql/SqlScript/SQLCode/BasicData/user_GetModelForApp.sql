USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetModelForApp]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
/*          
-- Author:      Master谭          
-- Create date: 2013-12-5          
-- Description: 手机客户端获取用户信息        
-- Memo:use ngbapp          
exec user_GetModelForApp 777001    
 select * from ossapp..addservice  where userid=777001    
 select ossapp.dbo.addservice_vip_GetRule(777001,808) 
*/          
--          
CREATE PROCEDURE [dbo].[user_GetModelForApp]         
 @userid int          
 AS           
BEGIN        
 SET NOCOUNT ON        
select uc.Account,uc.Nickname,uc.name Username,uc.Userid,uc.Kid,k.Kname,uc.cid,        
    uc.cname,uc.sex,uc.birthday,uc.headpicupdate,headpic        
 from basicdata..[User_Child] uc        
  inner join BasicData..kindergarten k        
   on uc.kid = k.kid        
 where userid = @userid        
  
declare @term nvarchar(6)  
select @term = commonFun.dbo.fn_getCurrentTerm(isnull(kid,0),GETDATE(),1)  
 from BasicData..[user] where userid=@userid  
       
select gbid from ngbapp..growthbook where userid=@userid and term=@term    
        
declare @gtype int,@nowterm int,@termstr varchar(100),@kid int,@healthvip int=0    
        
        
        
      
        
select @kid=kid from basicdata..[user] where userid=@userid        
      
--if(@kid in (12511,22188,23115))      
begin      
 if(not exists(select top 1 1 from BlogApp..permissionsetting where ptype=67 and kid=@kid))    
 begin    
  set @healthvip=ossapp.dbo.addservice_vip_GetRule(@userid,808)     
 end    
end      
        
        
set @termstr=healthapp.dbo.getTerm_New(@kid,getdate())         
set @termstr=right(@termstr,1)        
        
select @gtype=(case when gtype>0         
  then gtype else         
  CASE CommonFun.dbo.fn_age(u.birthday)         
  WHEN 2 THEN 1 WHEN 3 THEN 1 WHEN 4 THEN 2 ELSE 3 END         
   end)        
  from  basicdata..user_child u        
  inner join basicdata..grade g on g.gid=u.grade        
 where u.userid=@userid        
        
if(@gtype=4)set @gtype=1        
 --@gtype 1小班；中班；大班        
 --@termstr 1:上学期；：下学期        
 if(@termstr=1)        
 begin        
  if(@gtype=1)set @nowterm=0        
  if(@gtype=2)set @nowterm=2        
  if(@gtype=3)set @nowterm=4        
 end        
 else if(@termstr=0)        
 begin        
  if(@gtype=1)set @nowterm=1        
  if(@gtype=2)set @nowterm=3        
  if(@gtype=3)set @nowterm=5        
 end        
         
 select @gtype,@healthvip        
END 
GO
