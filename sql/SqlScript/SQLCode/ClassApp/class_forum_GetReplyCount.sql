USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_forum_GetReplyCount]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：查询级论坛留言回复数 
--项目名称：ClassHomePage
--说明：
--时间：2009-2-13 17:09:59
------------------------------------
CREATE PROCEDURE [dbo].[class_forum_GetReplyCount]
@classforumid int,
@userid int
AS
	DECLARE @TempID int
	DECLARE @isclassteacher int
	DECLARE @classid int
	DECLARE @kid int
	SELECT @classid=classid FROM class_forum WHERE classforumid=@classforumid
	SELECT @kid=kid FROM BasicData.dbo.class WHERE cid=@classid	
	EXEC @isclassteacher=class_GetIsClassTeacher @userid,@classid
	IF(@isclassteacher=1 or (SELECT  count(1) FROM BlogApp.dbo.permissionsetting WHERE kid=@kid and ptype=10)=0)
	BEGIN
		SELECT @TempID = count(1) FROM class_forum WHERE parentid=@classforumid AND status=1
		RETURN @TempID
	END
	ELSE 
	BEGIN
		SELECT @TempID = count(1) FROM class_forum WHERE parentid=@classforumid AND (approve=1 OR (userid=@userid and @userid<>0)) and status=1
		RETURN @TempID
	END







GO
