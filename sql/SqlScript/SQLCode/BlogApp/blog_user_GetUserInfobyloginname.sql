USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_user_GetUserInfobyloginname]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-06
-- Description:	取当前登录用户信息
-- Memo:
exec blog_user_GetUserInfobyloginname 'dmzlqy'
*/ 
CREATE PROCEDURE [dbo].[blog_user_GetUserInfobyloginname]
	@account nvarchar(30)
 AS
 BEGIN 
	SELECT	ub.bloguserid,u.account,u.nickname,u.email,	u.gender,u.birthday,ub1.blogtitle,ub1.description,
					ub1.defaultdispmode,ub1.postdispcount,ub1.themes,ub1.messagepref,ub1.postscount,	ub1.albumcount,ub1.photocount,
					ub1.visitscount,ub1.createdatetime,ub1.updatedatetime,ub1.lastposttitle,ub1.lastpostid,u.headpic,
					ub1.blogtype,ub1.blogurl,ub1.integral,ub1.iskmpuser,ub1.kininfohide,u.headpicupdate as headpicupdatetime
		FROM BasicData.dbo.[user] u 
			INNER JOIN BasicData.dbo.user_bloguser ub on u.userid = ub.userid 
			LEFT JOIN blog_baseconfig ub1 ON ub.bloguserid = ub1.userid 
		WHERE u.account = @account 
			and u.deletetag = 1
END

GO
