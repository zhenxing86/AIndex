USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_friendapply_GetSubmitList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-02
-- Description: 取好友列表	
-- Memo:
	exec [blog_friendapply_GetSubmitList] 413540		
*/
CREATE PROCEDURE [dbo].[blog_friendapply_GetSubmitList]
	@userid int
 AS
BEGIN
	SET NOCOUNT ON 
	SELECT	bf.friendapplyid, bf.sourceuserid, bf.targetuserid, bf.applystatus, bf.remark,
					bf.invitetime, u.nickname, u.headpic, u.headpicupdate as headpicupdatetime
		FROM blog_friendapply bf 
			inner join BasicData.dbo.user_bloguser ub 
				on bf.targetuserid = ub.bloguserid
			inner join BasicData.dbo.[user] u 
				on ub.userid = u.userid
		WHERE u.deletetag = 1 
			and bf.sourceuserid = @userid 
			and bf.applystatus in(0,2)
END

GO
