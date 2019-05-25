USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_forum_teacher_Update]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：修改班级论坛内容 
--项目名称：ClassHomePage
--说明：
--时间：2009-2-19 17:09:59
------------------------------------
CREATE PROCEDURE [dbo].[class_forum_teacher_Update]
@classforumid int,
@title nvarchar(200),
@contents ntext,
@author nvarchar(50),
@istop int
 AS 
	UPDATE class_forum_teacher SET 
	[title] = @title,[contents] = @contents,[author] = @author,[istop] = @istop,[createdatetime]=getdate()	
	WHERE classforumid=@classforumid 

	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END












GO
