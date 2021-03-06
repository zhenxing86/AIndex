USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[class_sms_GetGradeList]    Script Date: 05/14/2013 14:52:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取幼儿园年级
--项目名称：classhomepage
--说明：
--时间：2009-4-10 9:54:31
------------------------------------
alter PROCEDURE [dbo].[class_sms_GetGradeList]
@kid int
AS
--	SELECT gid,gname FROM BasicData.dbo.grade
--	WHERE gid in 
--(SELECT DISTINCT(grade) FROM BasicData.dbo.class 
--WHERE kid=@kid and deletetag=1 and iscurrent=1 AND grade<>38)
--	ORDER BY gid

SELECT distinct gid,gname FROM BasicData.dbo.grade t1 inner join BasicData.dbo.class t2
on t1.gid=t2.grade
where t2.kid=@kid and t2.deletetag=1 and t2.iscurrent=1 AND t2.grade<>38
ORDER BY t1.gid
GO
