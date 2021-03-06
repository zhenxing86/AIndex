USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_schedule_GetList]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途： 班级首页教学安排
--项目名称：ClassHomePage
--说明：
--时间：2009-1-20 10:28:40
------------------------------------
CREATE PROCEDURE [dbo].[class_schedule_GetList]
@classid int
 AS 
	SELECT TOP(5)
		scheduleid,title,userid,author,classid,kid,content,1,1,1,convert(varchar(10),createdatetime,120)as createdatetime,viewcount
	FROM class_schedule
	WHERE classid=@classid and status=1
	ORDER BY scheduleid DESC


GO
