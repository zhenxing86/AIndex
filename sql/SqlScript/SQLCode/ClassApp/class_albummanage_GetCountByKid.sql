USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_albummanage_GetCountByKid]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








------------------------------------
--用途：取相册数 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 10:58:57
--exec [class_albummanage_GetCountByKid] 5380
------------------------------------
CREATE PROCEDURE [dbo].[class_albummanage_GetCountByKid] 
@kid int
 AS


	declare @count1 int
	
	SELECT @count1=count(1) FROM dbo.class_album AS t1 inner join basicdata..class t2 on t1.classid=t2.cid
	WHERE t2.kid=@kid and t2.deletetag=1 and t1.status =1
	return @count1
	








GO
