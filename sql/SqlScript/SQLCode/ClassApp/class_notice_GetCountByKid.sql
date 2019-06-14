USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_notice_GetCountByKid]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-----------------------------------
--用途：取公告数 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 9:44:05
------------------------------------
CREATE  PROCEDURE [dbo].[class_notice_GetCountByKid]
@kid int
 AS
	DECLARE @count int
	SELECT @count=count(1) FROM class_notice_class t1 inner join basicdata..class t2 on t1.classid=t2.cid WHERE t2.deletetag=1 and  t2.kid=@kid 
	RETURN @count






GO
