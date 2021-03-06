USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_user_GetUserInfo]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：取当前登录用户信息
--项目名称：zgyeyblog
--说明：
--时间：2008-09-29 10:23:01
--作者：along
--exec [blog_user_GetUserInfo] 4
------------------------------------
CREATE PROCEDURE [dbo].[blog_user_GetUserInfo]
@userid int
 AS
SELECT 
	t1.userid,t1.account,t1.nickname,t1.email,	
	t2.gender,t2.birthday,t2.blogtitle,t2.description,t2.defaultdispmode,t2.postdispcount,t2.themes,t2.messagepref,t2.postscount,
	t2.albumcount,t2.photocount,t2.visitscount,t2.createdatetime,t2.updatedatetime,t2.lastposttitle,t2.lastpostid,t2.headpic,
	t2.blogtype,t2.blogurl,t2.integral,t2.iskmpuser,t2.province,t2.city,t2.truename,t2.kininfohide,t2.headpicupdate as headpicupdatetime,
	t2.messagepermission,[dbo].[ReturnUserMobile](t1.userid) as mobile,t2.photowatermark
	 FROM blog_user t1 
	LEFT JOIN blog_baseconfig t2 ON t1.userid=t2.userid 
	 WHERE t1.userid=@userid and t1.activity=1








GO
