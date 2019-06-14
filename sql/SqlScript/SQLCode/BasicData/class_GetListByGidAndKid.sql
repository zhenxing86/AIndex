USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[class_GetListByGidAndKid]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[class_GetListByGidAndKid]
@gid int,
@kid int
 AS 
	SELECT 
	cid,cname,grade
	 FROM [class] 
	 WHERE kid=@kid and grade=@gid and deletetag=1 and iscurrent=1			 
	 order by [order] desc



GO
