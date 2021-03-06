USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[class_GetListByUserid]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[class_GetListByUserid]
@userid int
 AS 

declare @kid int
select @kid=kid from [user] where userid=@userid
	SELECT 
	t1.cid,t1.cname,t1.grade,t1.sname
	 FROM [class] t1 inner join [user_class] t2 on t1.cid=t2.cid
	 inner join [grade] t3 on t1.grade=t3.gid
	 WHERE t2.userid=@userid 
	 and t1.deletetag=1 
	 and t1.iscurrent=1 
	 and t1.kid=@kid
	 order by t3.[order] asc, t1.[order] desc

GO
