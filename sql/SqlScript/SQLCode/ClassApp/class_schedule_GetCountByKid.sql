USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_schedule_GetCountByKid]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：取班级教学安排数
--项目名称：ClassHomePage
--说明：[class_schedule_GetCountByKid] 12511
--时间：2009-1-6 22:03:20
------------------------------------
CREATE PROCEDURE [dbo].[class_schedule_GetCountByKid]
@kid int
 AS
	DECLARE @count int
	SELECT @count=count(1) FROM class_schedule t1 
--inner join
 --basicdata..class t2 on t1.classid=t2.cid 
WHERE t1.status=1 and t1.kid=@kid 
	RETURN @count







GO
