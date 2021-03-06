USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetJoinKindergartenCountByKid]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：得到加入幼儿园用户数
--项目名称：
--说明：
--时间：2011-5-20 16:57:46
------------------------------------
CREATE PROCEDURE [dbo].[user_GetJoinKindergartenCountByKid]
@kid int,
@usertype int
 AS 
	DECLARE @count int
	SELECT
		@count=COUNT(1)
	FROM
		[user] t1 Inner JOIN [tem_user_kindergarten] t2 on t1.userid=t2.userid
	WHERE
		t2.kid=@kid and t1.deletetag=1 and t1.usertype=@usertype
	RETURN @count




GO
