USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_forum_teacher_GetCount]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询教学交流 
--项目名称：ClassHomePage
--说明：
--时间：2009-2-13 17:09:59
------------------------------------
CREATE PROCEDURE [dbo].[class_forum_teacher_GetCount]
@kid int
 AS	
	DECLARE @count int
	SELECT
	@count=count(1)
	FROM dbo.class_forum_teacher t1 LEFT OUTER JOIN BasicData.dbo.[user] t2 ON t1.userid = t2.userid
	WHERE t1.parentid = 0 AND t1.status = 1 AND t1.kid=@kid
	RETURN @count

GO
