USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_friendlist_GetCount]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-02
-- Description: 好友总数	
-- Memo:
DECLARE @TempID int
EXEC @TempID = blog_friendlist_GetCount 335726
SELECT @TempID 
*/
CREATE PROCEDURE [dbo].[blog_friendlist_GetCount]
	@userid int
AS
BEGIN
	SET NOCOUNT ON 
	DECLARE @TempID int, @appuserid int, @classid int, @usertype int, @kid int
	
	SELECT	@appuserid = ub.userid,
					@usertype = u.usertype  
		FROM BasicData.dbo.user_bloguser ub 
			inner join basicdata..[user] u 
				on ub.userid = u.userid
		where ub.bloguserid = @userid

	if(@usertype=0 or @usertype=1)
	begin
		select @classid = cid 
			from basicdata..user_class 
			where userid = @appuserid
	
		SELECT @TempID = count(1) 
		FROM BasicData..user_class uc 
		INNER JOIN BasicData.dbo.user_bloguser t2 
			ON uc.userid = t2.userid
		inner join BasicData.dbo.[user] u 
			on t2.userid = u.userid
		WHERE uc.cid = @classid 
			and t2.bloguserid <> @userid 
			and u.deletetag = 1
	end
	else
	begin
		select @kid = kid 
			from basicdata..[user]
			where userid = @appuserid

		SELECT @TempID = count(1) 
			FROM BasicData.dbo.user_bloguser ub
				inner join BasicData.dbo.[user] u 
					on ub.userid = u.userid
			WHERE u.kid = @kid 
				and ub.bloguserid <> @userid 
				and u.deletetag = 1
	end
	RETURN @TempID
END

GO
