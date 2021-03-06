USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_forum_GetCount]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-18
-- Description:	查询级论坛留言数
-- Memo:	
EXEC class_albumphoto_GetAllCount 24989
*/
CREATE PROCEDURE [dbo].[class_forum_GetCount]
	@classid int,
	@userid int
AS
	DECLARE @TempID int, @isclassteacher int, @kid int
		
	EXEC @isclassteacher=class_GetIsClassTeacher @userid,@classid
	
	IF(@isclassteacher=1 or (SELECT  count(1) FROM blogapp.dbo.permissionsetting p INNER JOIN BasicData.dbo.class c on p.kid = c.kid and c.cid = @classid and p.ptype=10)=0)
	BEGIN
		SELECT @TempID = count(1) FROM class_forum WHERE classid=@classid and parentid=0 AND status = 1
		RETURN @TempID
	END
	ELSE
	BEGIN
		SELECT @TempID = count(1) FROM class_forum WHERE classid=@classid and parentid=0 AND (approve=1 OR (userid=@userid and @userid<>0)) AND status = 1
		RETURN @TempID
	END

GO
