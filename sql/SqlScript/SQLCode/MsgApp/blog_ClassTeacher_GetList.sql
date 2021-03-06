USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_ClassTeacher_GetList]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[blog_ClassTeacher_GetList]
@classid int,
@userid int
 AS
IF(@classid=-1)
	BEGIN
	DECLARE @kid INT
		select @kid=kid from BasicData.dbo.[user] where userid=@userid
		select u.userid,u.[name] from BasicData..[user] u
		where u.usertype=1 and 
		u.kid=@kid and u.userid <>@userid
	END
	ELSE
	BEGIN
	select u.userid,u.[name] from BasicData..[user] u
		inner join BasicData.dbo.user_class uc on u.userid=uc.userid
		where u.usertype=1 and 
		uc.cid=@classid
	END

GO
