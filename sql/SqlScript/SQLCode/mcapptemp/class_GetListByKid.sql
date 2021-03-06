USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[class_GetListByKid]    Script Date: 2014/11/24 23:19:15 ******/
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
CREATE PROCEDURE [dbo].[class_GetListByKid]
@kid int
 AS 
	
	SELECT g.gid,g.gname,g.[order],c.cid,c.cname,c.[order]
		FROM BasicData..[grade] g 
		inner join BasicData..[class] c 
			on g.gid=c.grade
		where g.gid<>38 and c.deletetag=1 and c.iscurrent=1 and c.kid=@kid  
		order by g.[order],c.[order]







GO
