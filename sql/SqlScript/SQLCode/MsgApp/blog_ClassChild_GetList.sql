USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_ClassChild_GetList]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取班级开通博客的小朋友
--项目名称：zgyeyblog
--说明：
--时间：2009-03-09 10:57:13
------------------------------------
CREATE PROCEDURE [dbo].[blog_ClassChild_GetList]
@classid int,
@userid int
 AS
IF(@classid=-1)
	BEGIN
		DECLARE @kid INT
		select @kid = kid from BasicData.dbo.[user] where userid = @userid
    select userid,name from BasicData..[user]
		where usertype = 0
		  and kid = @kid
		  and userid <> @userid

	END
	ELSE
	BEGIN
		
		select u.userid,u.[name] from BasicData..[user] u
		inner join BasicData.dbo.user_class uc on u.userid=uc.userid
		where u.usertype=0 and  uc.cid=@classid
	END

GO
