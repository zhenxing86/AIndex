USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[class_GetStat]    Script Date: 2014/11/24 23:12:23 ******/
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
create PROCEDURE [dbo].[class_GetStat]
@classid int
 AS 
	SELECT	(SELECT COUNT(1) FROM class_accesslogs WHERE classid=@classid)AS accesscount,
			(SELECT COUNT(1) FROM class_album WHERE classid=@classid)AS albumcount,
			(SELECT SUM(photocount) FROM class_album WHERE classid=@classid)AS photocount,
			(SELECT COUNT(1) FROM thelp_documents WHERE classid=@classid AND classdisplay=1)AS schedulecount,
			(SELECT COUNT(1) FROM class_forum WHERE classid=@classid AND parentid=0)AS subjectcount,
			(SELECT COUNT(1) FROM class_video WHERE classid=@classid)AS videocount,
			(SELECT COUNT(1) FROM [kmp]..[T_Child] WHERE Status=1 AND ClassID=@classid)AS childcount

GO
