USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_forum_teacher_GetReplyCount]    Script Date: 2014/11/24 22:57:28 ******/
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
CREATE PROCEDURE [dbo].[class_forum_teacher_GetReplyCount]
@classforumid int
AS
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM class_forum_teacher WHERE parentid=@classforumid AND status=1
	RETURN @TempID










GO
