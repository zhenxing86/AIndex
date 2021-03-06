USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_accesslogs_GetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-02
-- Description:	最近串门列表
-- Memo:	blog_accesslogs_GetList 12511	
*/ 
CREATE PROCEDURE [dbo].[blog_accesslogs_GetList]
	@userid int
 AS
BEGIN
	SET NOCOUNT ON  
	SELECT	top 9 ba.userid, ba.fromeuserid, ba.accessdatetime, u.nickname, 
					u.headpic,u.headpicupdate as headpicupdatetime
	 FROM AppAccessLogs.dbo.blog_accesslogs ba 
	 inner join BasicData.dbo.user_bloguser ub on ba.fromeuserid = ub.bloguserid 
	 INNER JOIN BasicData.dbo.[user] u on ub.userid = u.userid 	 
	WHERE ba.userid = @userid
	ORDER BY ba.accessdatetime desc
END

GO
