USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_GetStat]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途： 班级首页统计信息
--项目名称：ClassHomePage
--说明：
--时间：2009-2-19 10:24:28
------------------------------------
CREATE PROCEDURE [dbo].[class_GetStat]
@classid int
 AS 
	SELECT	(SELECT accessnum FROM class_config WHERE cid=@classid)AS accesscount,
			--(SELECT COUNT(1) FROM class_album WHERE classid=@classid)AS albumcount,
0 AS albumcount,
			0 AS photocount,
			(SELECT COUNT(1) FROM class_schedule WHERE classid=@classid and [status]=1)AS schedulecount,
			0 AS subjectcount,
			(SELECT COUNT(1) FROM class_video WHERE classid=@classid and status=1)AS videocount,
			 0 AS childcount

GO
