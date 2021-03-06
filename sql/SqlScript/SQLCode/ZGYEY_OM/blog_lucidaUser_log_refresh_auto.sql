USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[blog_lucidaUser_log_refresh_auto]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加一条记录 
--项目名称：storybook
--说明：
--时间：2011/11/20 21:20:08
-------------[blog_lucidaUser_log_refresh] 14570
CREATE PROCEDURE [dbo].[blog_lucidaUser_log_refresh_auto] 
 AS 


delete t1 from kwebcms..blog_lucidaUser_log t1 left join kwebcms..site_config t2
on t1.siteid=t2.siteid where t2.isvip=1

INSERT INTO kwebcms..blog_lucidaUser_log(appuserid,bloguserid,usertype,name,siteid)
select  t1.userid,t1.bloguserid,t4.usertype,t4.[name],t4.kid 
from  basicdata..user_bloguser  t1  
 inner join basicdata..[user] t4 on t1.userid=t4.userid 
left join kwebcms..site_config t5 on t4.kid=t5.siteid
where t5.isvip=1 and  t4.deletetag=1  

--登陆数
update   t1 set t1.logincount=(select sum(logincount) from applogs..log_login_month t2 where t1.appuserid=t2.userid) 
from kwebcms..blog_lucidaUser_log  t1

--更新博客
update  t1  set 
 t1.postcount=(select count(1) from blogapp..blog_posts t2 where t2.userid=t1.bloguserid and deletetag=1 and poststatus=1) ,
 t1.albumcount=(select count(1) from blogapp..album_categories t3 where t3.userid=t1.bloguserid and deletetag=1),
 t1.messageboardcount=(select count(1) from  blogapp..blog_messageboard where t1.bloguserid=fromuserid),
 t1.visitscount=(select visitscount  from blogapp..blog_baseconfig where userid=t1.bloguserid)
 from kwebcms..blog_lucidaUser_log t1
 
update t1 set t1.postscount=t2.postcount from blogapp..blog_baseconfig t1
inner join kwebcms..blog_lucidaUser_log t2 on t1.userid=t2.bloguserid
 
 --更新照片
 update  t1  set 
 t1.photocount=(select count(1) from blogapp..album_photos t2 inner join  blogapp..album_categories t3 on t2.categoriesid=t3.categoriesid where t3.userid=t1.bloguserid and t2.deletetag=1)
 from kwebcms..blog_lucidaUser_log t1

GO
