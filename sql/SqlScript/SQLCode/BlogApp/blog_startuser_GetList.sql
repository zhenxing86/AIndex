USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_startuser_GetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：明星博客
--项目名称：zgyeyblog
--说明：
--时间：2009-4-28 16:55:19
-- exec blog_startuser_GetList 0
------------------------------------
CREATE PROCEDURE [dbo].[blog_startuser_GetList]
	@usertype int
AS
BEGIN
	SET NOCOUNT ON
	IF(@usertype>0)
	BEGIN
		SELECT ub.bloguserid,u.nickname,u.headpic,u.headpicupdate 
			FROM blog_baseconfig bb 
				INNER JOIN BasicData.dbo.user_bloguser ub ON bb.userid = ub.bloguserid 
				inner join BasicData.dbo.[user] u on ub.userid = u.userid
			WHERE bb.isstart = 1 
			and u.usertype > 0 
			and u.deletetag = 1
			ORDER BY headpicupdate  DESC
	END
	ELSE
	BEGIN
		SELECT ub.bloguserid,u.nickname,u.headpic,u.headpicupdate 
			FROM blog_baseconfig bb 
				INNER JOIN BasicData.dbo.user_bloguser ub ON bb.userid = ub.bloguserid 
				inner join BasicData.dbo.[user] u on ub.userid = u.userid
			WHERE bb.isstart = 1 
				and u.usertype = @usertype 
				and u.deletetag = 1	
				ORDER BY headpicupdate  DESC
	END
END

GO
