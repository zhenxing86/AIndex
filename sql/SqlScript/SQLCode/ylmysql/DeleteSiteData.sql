USE [ylmysql]
GO
/****** Object:  StoredProcedure [dbo].[DeleteSiteData]    Script Date: 2014/11/24 23:29:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*  
-- Author:      Master谭  
-- Create date:   
-- Description:   
-- Memo:   
  
ALTER TABLE kwebcms..cms_content DISABLE TRIGGER Trg_cms_content  
ALTER TABLE kwebcms..cms_content DISABLE TRIGGER cms_content_AspNet_SqlCacheNotification_Trigger  
ALTER TABLE kwebcms..site DISABLE TRIGGER site_AspNet_SqlCacheNotification_Trigger  
ALTER TABLE BlogApp..blog_posts DISABLE TRIGGER blog_posts_AspNet_SqlCacheNotification_Trigger  
ALTER TABLE BlogApp..album_categories DISABLE TRIGGER album_categories_AspNet_SqlCacheNotification_Trigger  
ALTER TABLE BlogApp..blog_baseconfig DISABLE TRIGGER blog_baseconfig_AspNet_SqlCacheNotification_Trigger  
ALTER TABLE ClassApp.dbo.class_schedule DISABLE TRIGGER class_schedule_AspNet_SqlCacheNotification_Trigger  
ALTER TABLE basicdata..[user] DISABLE TRIGGER Del_User  
ALTER TABLE basicdata..[user] DISABLE TRIGGER Up_user  
ALTER TABLE basicdata..Class DISABLE TRIGGER Del_Class  
ALTER TABLE basicdata..Class DISABLE TRIGGER trg_class  
ALTER TABLE basicdata..User_Class DISABLE TRIGGER trg_User_Class  
  
exec [DeleteSiteData] 17614   
  
ALTER TABLE basicdata..Class ENABLE TRIGGER trg_class  
ALTER TABLE basicdata..Class ENABLE TRIGGER Del_Class  
ALTER TABLE basicdata..[user] ENABLE TRIGGER Up_user  
ALTER TABLE basicdata..[user] ENABLE TRIGGER Del_User  
ALTER TABLE ClassApp.dbo.class_schedule ENABLE TRIGGER class_schedule_AspNet_SqlCacheNotification_Trigger  
ALTER TABLE BlogApp..blog_baseconfig ENABLE TRIGGER blog_baseconfig_AspNet_SqlCacheNotification_Trigger  
ALTER TABLE BlogApp..album_categories ENABLE TRIGGER album_categories_AspNet_SqlCacheNotification_Trigger  
ALTER TABLE BlogApp..blog_posts ENABLE TRIGGER blog_posts_AspNet_SqlCacheNotification_Trigger  
ALTER TABLE kwebcms..site ENABLE TRIGGER site_AspNet_SqlCacheNotification_Trigger  
ALTER TABLE kwebcms..cms_content ENABLE TRIGGER Trg_cms_content  
ALTER TABLE kwebcms..cms_content ENABLE TRIGGER cms_content_AspNet_SqlCacheNotification_Trigger  
ALTER TABLE basicdata..User_Class ENABLE TRIGGER trg_User_Class  
  
  
*/  
CREATE PROC [dbo].[DeleteSiteData]   
 @kid int  
AS  
SET NOCOUNT ON  
declare @userid int,  
    @did int, @did2 int, @did3 int, @did4 int, @did5 int, @did6 int, @did7 int  
  
--DECLARE @yp_sId int = 2, @kid int  
--select @kid = kid from  BasicData..kindergarten where NGB_Descript = '岳麓区批量导入' and synstatus = @yp_sId  
--SELECT @kid  
IF ISNULL(@kid,0)< 1 RETURN  

if Exists (Select * From [ossapp].[dbo].[kinbaseinfo] Where kid = @kid and status = '正常缴费') Return

Update ossapp.dbo.filteredrecord set Status=2 where kid=@kid and adddate <= Getdate()
print 'del filteredrecord '

--插入园所简介  
delete kwebcms..cms_content WHERE siteid = @kid  
print 'del cms_content successful '  
delete basicdata..department where kid = @kid  
print 'del department successful '  
             
  ------------------ site ----------------    
 DECLARE @site_instance_id int, @org_id int  
 select @org_id = org_id from KwebCMS..site where siteid = @kid   
 DELETE KwebCMS..site WHERE siteid = @kid  
print 'del site successful '  
 DELETE KWebCMS_Right..sac_org WHERE org_id = @org_id   
print 'del sac_org successful '  
 DELETE KWebCMS_Right..sac_user WHERE org_id = @org_id   
print 'del sac_user successful '  
 DELETE KWebCMS_Right..sac_site_instance WHERE org_id = @org_id   
print 'del sac_site_instance successful '  
     
--初始化列表      
  delete bp  
from BlogApp..blog_postscategories bp   
inner join BasicData..user_bloguser ub on bp.userid = ub.bloguserid  
inner join BasicData..[user] u on ub.userid = u.userid   
where u.kid = @kid   
print 'del blog_postscategories successful '  
  delete bp  
from BlogApp..blog_posts bp   
inner join BasicData..user_bloguser ub on bp.userid = ub.bloguserid  
inner join BasicData..[user] u on ub.userid = u.userid   
where u.kid = @kid  
print 'del blog_posts successful '  
  
delete bp  
from BlogApp..album_categories bp   
inner join BasicData..user_bloguser ub on bp.userid = ub.bloguserid  
inner join BasicData..[user] u on ub.userid = u.userid   
where u.kid = @kid  
print 'del album_categories successful '  
  
delete bp  
from BlogApp..blog_messageboard bp   
inner join BasicData..user_bloguser ub on bp.userid = ub.bloguserid  
inner join BasicData..[user] u on ub.userid = u.userid   
where u.kid = @kid  
print 'del blog_messageboard successful '  
  
  delete KWebCMS..blog_classlist   
where siteid = @kid   
print 'del blog_classlist successful '  
  
  delete KWebCMS..T_DictionarySetting  
where kid = @kid   
print 'del T_DictionarySetting successful '  
  
  delete bp  
from BlogApp..Video_Categories bp   
inner join BasicData..user_bloguser ub on bp.userid = ub.bloguserid  
inner join BasicData..[user] u on ub.userid = u.userid   
where u.kid = @kid   
print 'del Video_Categories successful '  
  
  delete bp  
from BlogApp..album_categories bp   
inner join BasicData..user_bloguser ub on bp.userid = ub.bloguserid  
inner join BasicData..[user] u on ub.userid = u.userid   
where u.kid = @kid  
print 'del album_categories successful '  
  
  delete bp  
from BlogApp..blog_baseconfig bp   
inner join BasicData..user_bloguser ub on bp.userid = ub.bloguserid  
inner join BasicData..[user] u on ub.userid = u.userid   
where u.kid = @kid    
print 'del blog_baseconfig successful '  
  
delete bp  
from BlogApp..blog_messageboard bp   
inner join BasicData..user_bloguser ub on bp.userid = ub.bloguserid  
inner join BasicData..[user] u on ub.userid = u.userid   
where u.kid = @kid  
print 'del blog_messageboard successful '  
       
delete ClassApp.dbo.class_schedule where kid = @kid  
print 'del class_schedule successful '  
  
delete ClassApp.dbo.class_album where kid = @kid  
print 'del class_album successful '  
  
delete ClassApp.dbo.class_photos where kid = @kid  
print 'del class_photos successful '  
  
delete ClassApp.dbo.class_notice where kid = @kid  
print 'del class_notice successful '  
  
delete ClassApp.dbo.class_article where kid = @kid  
print 'del class_article successful '  
  
delete ClassApp.dbo.class_video where kid = @kid  
print 'del class_video successful '  
delete ClassApp.dbo.class_forum where kid = @kid  
print 'del class_forum successful '  
delete ClassApp.dbo.class_backgroundmusic where kid = @kid  
print 'del class_backgroundmusic successful '  
delete ClassApp.dbo.class_birthday_start where kid = @kid  
print 'del class_birthday_start successful '  
  
--delete basicdata..[user]  where kid = @kid  
--print 'del [user] successful '  
--delete BasicData..kindergarten where kid = @kid   
--print 'del kindergarten successful '  
  
delete kwebcms..site_config where siteid = @kid   
print 'del site_config successful '  
  
delete kwebcms..site where siteid = @kid   
print 'del site successful '  



GO
