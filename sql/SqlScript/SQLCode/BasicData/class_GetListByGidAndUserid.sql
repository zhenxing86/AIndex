USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[class_GetListByGidAndUserid]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[class_GetListByGidAndUserid]
@gid int,
@userid int
 AS 
	SELECT 
	t1.cid,t1.cname,t1.grade
	 FROM [class] t1 inner join user_class t2 on t1.cid=t2.cid
	 WHERE t2.userid=@userid and t1.grade=@gid and t1.deletetag=1 and t1.iscurrent=1			 
	 order by t1.[order] desc	 


GO
