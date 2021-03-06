USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_friendlist_GetList_v2]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-02
-- Description: 取好友列表	
-- Memo:
	exec  [blog_friendlist_GetList_v2] 335726,444662,10341,59223,98
*/
CREATE PROCEDURE [dbo].[blog_friendlist_GetList_v2]
	@userid int,
	@appuserid int,
	@kid int,
	@classid int,
	@usertype int
 As
BEGIN
	SET NOCOUNT ON
	if(@usertype=0)
	begin
		SELECT	top 9 @userid, ub.bloguserid as frienduserid, u.headpicupdate, 
						u.headpic, u.nickname, u.headpicupdate as headpicupdatetime, newid()
			FROM BasicData..user_class uc 
				INNER JOIN BasicData.dbo.user_bloguser ub 
					ON uc.userid = ub.userid
				inner join BasicData.dbo.[user] u 
					on ub.userid = u.userid
			WHERE uc.cid = @classid 
				and ub.bloguserid <> @userid 
				and u.deletetag = 1 
			order by newid()
		end
	else if(@usertype = 1)
	begin
		SELECT	top 9 @userid, ub.bloguserid as frienduserid, u.headpicupdate,
						u.headpic, u.nickname, u.headpicupdate as headpicupdatetime, newid()
		FROM BasicData.dbo.user_bloguser ub
			inner join BasicData.dbo.[user] u 
				on ub.userid = u.userid
		WHERE u.kid=@kid 
			and ub.bloguserid <> @userid 
			and u.deletetag = 1 
			and u.usertype <> 0 
		order by newid()
	end
	else
	begin		
		SELECT	top 9 @userid,ub.bloguserid as frienduserid, u.headpicupdate,
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
