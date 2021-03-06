USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[autoexe_blog_actionlogs_GetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-02
-- Description:	取最新动态
-- Memo:		
*/ 
CREATE PROCEDURE [dbo].[autoexe_blog_actionlogs_GetList]
 AS
BEGIN
	SET NOCOUNT ON 
	delete from AppLogs.dbo.blog_tmp_actionlogs

	INSERT INTO AppLogs.dbo.blog_tmp_actionlogs(actionuserid, actionusername, actiondesc, actiondatetime, headpic, headpicupdate)
	select top 20 bl.actionuserid, bl.actionusername, bl.actiondesc, bl.actiondatetime, u.headpic, u.headpicupdate
		from AppLogs.dbo.blog_log bl 
			inner join BasicData.dbo.user_bloguser ub 
				on bl.actionuserid=ub.bloguserid 
			inner join BasicData.dbo.[user] u on ub.userid=u.userid
			inner join blog_baseconfig bb on bl.actionuserid=bb.userid
		where u.deletetag=1 and datediff(dd,bb.createdatetime,getdate())>3 order by bl.actiondatetime desc
END

GO
