USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_friendapply_GetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-02
-- Description: 取好友列表	
-- Memo:
	exec [blog_friendapply_GetList] 413494		
*/
CREATE PROCEDURE [dbo].[blog_friendapply_GetList]
	@userid int
 AS
BEGIN
	SET NOCOUNT ON 
	SELECT	bf.friendapplyid, bf.sourceuserid, bf.targetuserid, bf.applystatus,
					bf.remark, bf.invitetime, u.nickname, u.headpic, u.headpicupdate as headpicupdatetime
	 FROM blog_friendapply bf 
		 inner join BasicData.dbo.user_bloguser ub 
			on bf.sourceuserid = ub.bloguserid
		 inner join BasicData.dbo.[user] u 
			on ub.userid = u.userid
	WHERE bf.targetuserid = @userid 
		and bf.applystatus = 0 
		and u.deletetag = 1
END

GO
