USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[kmp_getclasschildlist]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-06
-- Description:	取本班小朋友列表
-- Memo:
*/ 
CREATE PROCEDURE [dbo].[kmp_getclasschildlist]
	@classid int,
	@userid int
 AS
BEGIN
	SET NOCOUNT ON
	select	c.userid,u.name,cast(u.birthday as nvarchar(20)),c.vipstatus,u.mobile,
					ub.bloguserid,u.account as loginname,u.headpic,u.headpicupdate as headpicupdatetime
	From BasicData.dbo.child c 
		inner join BasicData.dbo.user_class uc on c.userid = uc.userid
		inner join BasicData.dbo.user_bloguser ub on c.userid = ub.userid
		inner join BasicData.dbo.[user] u on c.userid = u.userid
	where u.deletetag = 1 
		and uc.cid = @classid 
		and ub.bloguserid <> @userid
	order by ub.bloguserid desc
END

GO
