USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetUserInfo]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-06
-- Description:	得到注册用户的详细信息
-- Memo:
Manage_GetUserInfo 191117
*/ 
CREATE PROCEDURE [dbo].[Manage_GetUserInfo]
	@userid int
 AS
BEGIN 
	SET NOCOUNT ON
	SELECT bb.userid,u.account,u.nickname,u.regdatetime as createdate,bb.postscount,bb.albumcount,bb.photocount
		FROM basicdata.dbo.[user] u 
			inner join basicdata.dbo.user_bloguser ub on u.userid = ub.userid
			inner join blog_baseconfig bb on ub.bloguserid = bb.userid
		WHERE ub.bloguserid = @userid 
			AND u.deletetag = 1
END

GO
