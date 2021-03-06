USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_baseconfig_default_GetModel]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：取个人博客中的默认设置
--项目名称：blog
--说明：
--时间：2009-5-27 17:10:57
------------------------------------
CREATE PROCEDURE [dbo].[blog_baseconfig_default_GetModel]
@userid int
 AS 
		 --如果配置表中无数据，初始化一条
 if not exists( select  userid from blog_baseconfig    where userid=@userid)
 begin
 declare @appuserid int,@usertype int,@gender nvarchar(50)
	select  @appuserid=u.userid,@usertype=usertype,@gender=gender  
	 from BasicData..user_bloguser ub  
	join BasicData..[user] u on ub.userid=u.userid where ub.bloguserid=@userid
	exec [blog_Register] @userid,@appuserid,@usertype,@gender,''
end	
	SELECT posttoclassdefault,commentpermission,openblogquestion,openbloganswer,kininfohide,messagepermission,postviewpermission,albumviewpermission
	FROM blog_baseconfig WHERE userid=@userid





GO
