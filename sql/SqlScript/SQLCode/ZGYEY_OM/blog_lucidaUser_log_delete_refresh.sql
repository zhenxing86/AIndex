USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[blog_lucidaUser_log_delete_refresh]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











------------------------------------
--用途：
--项目名称：oss
--说明：
--时间：2011/11/20 21:20:08
CREATE PROCEDURE [dbo].[blog_lucidaUser_log_delete_refresh] 

 AS 
	
delete t1 from kwebcms..blog_lucidaUser_log t1 left join basicdata..user_bloguser t2
on t1.bloguserid=t2.bloguserid
left join basicdata..[user] u on t2.userid=u.userid
where u.deletetag=0-- t3.kid is null and t1.siteid>0

--
--select * from kwebcms..blog_lucidaUser_log t1 left join basicdata..user_bloguser t2
--on t1.bloguserid=t2.bloguserid
--left join basicdata..[user] u on t2.userid=u.userid
--where u.deletetag=0 

--
delete t1 from kwebcms..blog_lucidateacher t1 left join basicdata..user_bloguser t2
on t1.userid=t2.bloguserid
left join basicdata..[user] u on t2.userid=u.userid
where u.deletetag=0



delete t1 from kwebcms..blog_lucidapapoose t1 left join basicdata..user_bloguser t2
on t1.userid=t2.bloguserid
left join basicdata..[user] u on t2.userid=u.userid
where u.deletetag=0



delete t1 from 
kwebcms..blog_posts_list t1 left join basicdata..user_bloguser t2
on t1.userid=t2.bloguserid
left join basicdata..[user] u on t2.userid=u.userid
where u.deletetag=0












GO
