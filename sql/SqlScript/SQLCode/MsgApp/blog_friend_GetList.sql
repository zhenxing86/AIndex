USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_friend_GetList]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[blog_friend_GetList]
@userid int
AS
declare @reuserid int

select @reuserid=bloguserid from BasicData..user_bloguser where userid=@userid

SELECT 
	dbo.GetUserIdByBlogUserId(t1.frienduserid),t4.nickname,t1.updatetime,t4.headpic,t4.headpicupdate as headpicupdatetime
	 FROM blogapp..blog_friendlist t1 inner join BasicData.dbo.user_bloguser t2 on t1.frienduserid=t2.bloguserid
	   inner join BasicData.dbo.[user] t4 on t2.userid=t4.userid
	WHERE t1.userid=@reuserid and t4.deletetag=1

GO
