USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetChildCountByCid]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：得到幼儿数 
--项目名称：
--说明：
--时间：2011-5-20 16:57:46
------------------------------------
CREATE PROCEDURE [dbo].[user_GetChildCountByCid]
@cid int
 AS 
	declare @count int
	SELECT
		@count=COUNT(1)
	FROM
		[user] t1 
		Inner JOIN [user_class] t2 on t1.userid=t2.userid
		left join leave_kindergarten lk on t1.userid=lk.userid
	WHERE
		t1.usertype=0 and t1.deletetag=1  and t2.cid=@cid and lk.userid is null
	RETURN @count

GO
