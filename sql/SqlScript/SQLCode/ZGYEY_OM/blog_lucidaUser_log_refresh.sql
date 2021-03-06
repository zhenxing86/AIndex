USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[blog_lucidaUser_log_refresh]    Script Date: 2014/11/24 23:30:07 ******/
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
CREATE PROCEDURE [dbo].[blog_lucidaUser_log_refresh] 
@siteid int

 AS 
	
delete from kwebcms..blog_lucidaUser_log where siteid=@siteid

INSERT INTO kwebcms..blog_lucidaUser_log(appuserid,bloguserid,usertype,name,siteid)
select  t1.userid,t1.bloguserid,t4.usertype,t4.[name],t4.kid 
from  basicdata..user_bloguser  t1  
inner join basicdata..[user] t4 on t1.userid=t4.userid 
where t4.kid=@siteid

--登陆数
update   t1 set t1.logincount=(select sum(logincount) from applogs..log_login_month t2 where t1.appuserid=t2.userid) 
from kwebcms..blog_lucidaUser_log  t1 where t1.siteid=@siteid

--更新博客
update  t1  set 
 t1.postcount=(select count(*) from blogapp..blog_posts t2 where t2.userid=t1.bloguserid and deletetag=1) ,
 t1.albumcount=(select count(*) from blogapp..album_categories t3 where t3.userid=t1.bloguserid and deletetag=1),
 t1.messageboardcount=(select count(*) from  blogapp..blog_messageboard where t1.bloguserid=fromuserid),
 t1.visitscount=(select visitscount  from blogapp..blog_baseconfig where userid=t1.bloguserid)
 from kwebcms..blog_lucidaUser_log t1 where t1.siteid=@siteid
 
 
 --更新照片
 update  t1  set 
 t1.photocount=(select count(*) from blogapp..album_photos t2 inner join  blogapp..album_categories t3 on t2.categoriesid=t3.categoriesid where t3.userid=t1.bloguserid and t2.deletetag=1)
 from kwebcms..blog_lucidaUser_log t1 where t1.siteid=@siteid

--
delete t1 from kwebcms..blog_lucidateacher t1 
left join basicdata..user_bloguser t2
on t1.userid=t2.bloguserid
left join basicdata..[user] t3 on t2.userid=t3.userid  AND t3.kid > 0
where t3.kid is null and t1.siteid>0
and t1.siteid=@siteid
--

delete t1 from kwebcms..blog_lucidapapoose t1 left join basicdata..user_bloguser t2
on t1.userid=t2.bloguserid
left join basicdata..[user] t3 on t2.userid=t3.userid  AND t3.kid > 0
where t3.kid is null and t1.siteid>0
and t1.siteid=@siteid


delete t1 from 
kwebcms..blog_posts_list t1 left join basicdata..user_bloguser t2
on t1.userid=t2.bloguserid
left join basicdata..[user] t3 on t2.userid=t3.userid  AND t3.kid > 0
where t3.kid is null and t1.siteid>0
and t1.siteid=@siteid




update t1 set t1.headpic=t4.headpic,t1.headpicupdate=t4.headpicupdate,t1.name=t4.nickname 
from kwebcms..blog_lucidateacher t1 
left join basicdata..user_bloguser t2
on t1.userid=t2.bloguserid
left join basicdata..[user] t4 on t4.userid=t2.userid 
where t4.kid = @siteid

update t1 set t1.headpic=t4.headpic,t1.headpicupdate=t4.headpicupdate,t1.name=t4.nickname 
from kwebcms..blog_lucidapapoose t1 
left join basicdata..user_bloguser t2
on t1.userid=t2.bloguserid
left join basicdata..[user] t4 on t4.userid=t2.userid 
where t4.kid = @siteid

GO
