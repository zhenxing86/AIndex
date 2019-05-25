USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[class_GetModel]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：得到班级实体对象的详细信息 
--项目名称：
--说明：
--时间：2011-5-24 14:57:22
------------------------------------
CREATE PROCEDURE [dbo].[class_GetModel]
@cid int
 AS 
	SELECT 
	t1.cid,t1.cname,t1.grade,isnull(t1.sname,''),t2.gname,t1.kid
	 FROM [class] t1 inner join [grade] t2 on t1.grade=t2.gid
	 WHERE cid=@cid 







GO
