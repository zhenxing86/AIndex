USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_user_GetUserInfo]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      Master谭      
-- Create date:       
-- Description: 取当班级主页登录用户信息(家长,老师)      
-- Memo: class_user_GetUserInfo 319       
class_user_GetUserInfo 810484    
*/      
CREATE PROCEDURE [dbo].[class_user_GetUserInfo]    
 @userid int      
AS       
BEGIN      
 SET NOCOUNT ON       
 declare @ClassID int, @usertype int, @loginname nvarchar(20), @nickname nvarchar(20),       
     @username nvarchar(20), @bloguserid int, @kid int, @kurl nvarchar(200),       
     @theme nvarchar(50), @cname nvarchar(20), @kname nvarchar(50),@isleave int=0      
           
 select @usertype = u.usertype, @loginname = u.account, @nickname = u.nickname, @username = u.name,       
     @kid = u.kid, @kname = k.kname, @bloguserid = ub1.bloguserid, @theme = sc.classtheme       
  from BasicData.dbo.[user] u      
   left join BasicData.dbo.kindergarten k      
    on u.kid = k.kid       
    and k.deletetag = 1      
   left join KWebCMS.dbo.site_config sc      
    on u.kid = sc.siteid      
   left join BasicData.dbo.user_bloguser ub1      
    on ub1.userid = u.userid      
  where u.userid = @userid      
   and u.deletetag = 1      
      
 select top 1 @kurl = domain       
  from KWebCMS.dbo.site_domain       
  where siteid = @kid      
      
 select top 1 @ClassID = c.cid, @cname = c.cname       
  from BasicData.dbo.user_class uc       
   inner join BasicData.dbo.class c       
    on uc.cid = c.cid       
    and c.deletetag = 1      
  where uc.userid = @userid      
        
 IF @@ROWCOUNT = 0  --离园用户      
 begin    
  select top 1 @ClassID = c.cid, @cname = c.cname       
   from BasicData.dbo.class c
    inner join BasicData..leave_user_class luc   
     on c.cid = luc.cid 
   where luc.userid = @userid       
    and c.deletetag = 1    
        
  if exists (select * from basicdata..leave_kindergarten where userid=@userid and leavereason=12001)    
  set @isleave=1    
  else if exists (select * from basicdata..leave_kindergarten where userid=@userid and leavereason<>12001)    
     set @isleave=2    
 end     
       
 SELECT @kname as KindergartenName, @kurl as kurl, @cname as ClassName, @username as usernam,      
     @kid as kid, @ClassID as ClassID, @userid as UserID, @theme as theme,@usertype as usertype,      
     @loginname as loginname, @nickname as nickname, @bloguserid as bloguserid,@isleave as isleave       
       
END      
      
      
      
GO
