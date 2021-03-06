USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_friendlist_GetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-02
-- Description: 取好友列表	
-- Memo:
	exec  blog_friendlist_GetList 335726
*/
CREATE PROCEDURE [dbo].[blog_friendlist_GetList] 
	@userid int
 As
BEGIN
	SET NOCOUNT ON
	declare @appuserid int, @classid int, @usertype int, @kid int
	
	SELECT	@appuserid = ub.userid,
					@usertype = u.usertype  
		FROM BasicData.dbo.user_bloguser ub 
			inner join basicdata..[user] u 
				on ub.userid = u.userid
		where ub.bloguserid = @userid

	if(@usertype in (0, 1))
	begin

		select @classid = uc.cid 
			from basicdata..user_class uc 
			where userid = @appuserid

		SELECT	top 9 @userid, ub.bloguserid as frienduserid, u.headpicupdate,
						u.headpic, u.nickname, u.headpicupdate as headpicupdatetime, newid()
			FROM BasicData..user_class uc 
				INNER JOIN BasicData.dbo.user_bloguser ub ON uc.userid = ub.userid
				inner join BasicData.dbo.[user] u on ub.userid = u.userid
			WHERE uc.cid = @classid 
				and ub.bloguserid <> @userid 
				and u.deletetag = 1 
			order by newid()
	end
	else
	begin		
		select @kid = kid 
			from basicdata..[user] 
			where userid = @appuserid
		SELECT	top 9 @userid, ub.bloguserid as frienduserid, u.headpicupdate, 
						u.headpic, u.nickname, u.headpicupdate as headpicupdatetime, newid()
			FROM BasicData.dbo.user_bloguser ub 
				inner join BasicData.dbo.[user] u 
					on ub.userid = u.userid
			WHERE u.kid = @kid 
				and ub.bloguserid <> @userid 
				and u.deletetag = 1 
				and u.usertype <> 0 
			order by newid()
	end
END

GO
