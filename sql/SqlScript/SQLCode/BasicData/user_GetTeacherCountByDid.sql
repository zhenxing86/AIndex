USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetTeacherCountByDid]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：得到教师数 
--项目名称：
--说明：
--时间：2011-5-20 16:57:46
--[user_GetTeacherCountByDid] 79101
------------------------------------
CREATE PROCEDURE [dbo].[user_GetTeacherCountByDid]
@did int
 AS 
	declare @count int
	SELECT
		@count =COUNT(1)
	FROM
		[user] t1 Inner JOIN [teacher] t2 on t1.userid=t2.userid
	WHERE
		t2.did in  (select did from get_department_subsid(@did)) 
	and t1.deletetag=1 and t1.usertype<>0  and t1.usertype<>98
	and kid > 0
	select @count
	RETURN @count

GO
