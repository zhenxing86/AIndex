USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_forum_teacher_Delete]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：删除班级论坛留言 
--项目名称：classhomepage
--说明：
--时间：2009-2-13 17:09:59
------------------------------------
CREATE PROCEDURE [dbo].[class_forum_teacher_Delete]
@classforumid int,
@blogpost int
 AS 
	--EXEC [class_actionlogs_Delete] @classforumid,32	
	UPDATE class_forum_teacher SET status=-1 WHERE classforumid=@classforumid or parentid=@classforumid
	
	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END











GO
