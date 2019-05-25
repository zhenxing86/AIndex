USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_schedule_Update]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：修改班级教学安排 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 22:03:20
------------------------------------
CREATE PROCEDURE [dbo].[class_schedule_Update]
@scheduleid int,
@title nvarchar(100),
@classid int,
@content ntext,
@publishdisplay int,
@classdisplay int,
@kindergartendisplay int

 AS 
	UPDATE [class_schedule] SET 
	[title] = @title,[classid] = @classid,[content] = @content
	WHERE scheduleid=@scheduleid 

	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN(-1)
	END
	ELSE
	BEGIN	
	   RETURN (1)
	END












GO
