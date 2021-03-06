USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[grade_GetListByKid]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：查询年级记录信息 
--项目名称：
--说明：
--时间：2011-5-24 14:57:22
------------------------------------
CREATE PROCEDURE [dbo].[grade_GetListByKid]
@kid int
 AS 
	
	SELECT 
	distinct t1.gid,t1.gname,t1.[order]
	FROM [grade] t1 inner join [class] t2 on t1.gid=t2.grade
	where t2.deletetag=1 and t2.iscurrent=1 and t2.kid=@kid  order by t1.[order]






GO
