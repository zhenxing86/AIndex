USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_ClassChild_GetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-02
-- Description: 取班级开通博客的小朋友	
-- Memo:
	exec [blog_ClassChild_GetList] 46144,191120		
*/
CREATE PROCEDURE [dbo].[blog_ClassChild_GetList]
	@classid int,
	@userid int
 AS
BEGIN
	SET NOCOUNT ON 
	IF(@classid=-1)
	BEGIN
		DECLARE @kid INT
		
		SELECT @kid = u.kid 
			FROM BasicData.dbo.user_bloguser ub
				inner join BasicData.dbo.[user] u  
					on ub.userid=u.userid 
			WHERE ub.bloguserid=@userid	
		
		SELECT ub.bloguserid, u.nickname 
			FROM BasicData.dbo.user_bloguser ub 
				INNER JOIN BasicData.dbo.[user] u 
					on ub.userid = u.userid 
			WHERE u.usertype = 0 
				and u.deletetag = 1 
				and u.kid = @kid 
				and ub.bloguserid <> @userid 
	END
	ELSE
	BEGIN
		SELECT ub.bloguserid, u.name 
		FROM BasicData.dbo.user_bloguser ub 
		inner join BasicData.dbo.user_class uc 
			on ub.userid = uc.userid
		INNER JOIN BasicData.dbo.[user] u 
			on uc.userid = u.userid 
		WHERE u.usertype = 0 
			and u.deletetag = 1 
			and uc.cid = @classid 
	END
END

GO
