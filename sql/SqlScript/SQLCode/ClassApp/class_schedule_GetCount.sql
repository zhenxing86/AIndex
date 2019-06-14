USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_schedule_GetCount]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：取班级教学安排总数
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 22:03:20
------------------------------------
CREATE PROCEDURE [dbo].[class_schedule_GetCount]
@classid int
 AS 
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM class_schedule WHERE classid=@classid and status=1
	RETURN @TempID	











GO
