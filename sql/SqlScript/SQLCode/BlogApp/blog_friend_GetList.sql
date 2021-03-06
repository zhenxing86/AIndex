USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_friend_GetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-02
-- Description: 取好友列表	
-- Memo:
	exec [blog_friend_GetList] 191120		
*/
CREATE PROCEDURE [dbo].[blog_friend_GetList]
	@userid int
AS
BEGIN
	SET NOCOUNT ON
		SELECT bf.frienduserid as userid,u.nickname 
			FROM blog_friendlist bf 
				INNER JOIN BasicData.dbo.user_bloguser ub 
					ON bf.frienduserid = ub.bloguserid
				inner join BasicData.dbo.[user] u 
					on ub.userid = u.userid  
			where bf.userid = @userid  
				and u.deletetag = 1
END	

GO
