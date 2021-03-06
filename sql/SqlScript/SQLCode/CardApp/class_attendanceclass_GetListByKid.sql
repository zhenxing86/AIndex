USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[class_attendanceclass_GetListByKid]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途:取班级学生数
--项目名称：classhomepage
--说明：
--时间：2009-7-18 14:54:31
------------------------------------
CREATE PROCEDURE [dbo].[class_attendanceclass_GetListByKid]
@kid int
AS
	SELECT t3.cname, t3.cid, (SELECT count(t1.userid) FROM basicdata.dbo.[user] t1 inner join basicdata.dbo.user_class t2 on t1.userid=t2.userid WHERE t1.usertype=0 and t1.deletetag=1 and t2.cid=t3.cid) AS childcount 
	From basicdata.dbo.class t3 WHERE t3.kid = @kid and t3.deletetag=1 and t3.iscurrent=1
	 and t3.grade <> 38 ORDER BY t3.[order]






GO
