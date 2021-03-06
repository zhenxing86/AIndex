USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[pro_init_bloglist]    Script Date: 2014/11/24 23:04:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pro_init_bloglist]
 AS 

delete [bloglist]

INSERT INTO [dbo].[bloglist]
           ([postid]
           ,[userid]
           ,[title]
           ,[author]
           ,[kname]
           ,[sitedns]
           ,[postdatetime],usertype,[areaid])    
	
select  t4.postid,t4.userid,t4.title,t4.author,t1.kname,t1.sitedns,
t4.postdatetime,t3.usertype,t1.areaid
	from dbo.gartenlist t1
inner join kwebcms..blog_posts t6 on t1.kid=t6.siteid	
inner join BlogApp..blog_posts t4 on t6.postid=t4.postid
inner join basicdata..user_bloguser t2 on t2.bloguserid=t4.userid
inner join basicdata..[user] t3 on t2.userid=t3.userid
	WHERE t4.title not in ('我的教学助手开通啦','我的成长档案开通啦')
	order by t4.postid desc 
GO
