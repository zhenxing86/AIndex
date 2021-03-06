USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetJoinKindergartenListByKid]    Script Date: 06/15/2013 15:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：得到加入幼儿园用户列表 
--项目名称：
--说明：
--时间：2011-5-20 16:57:46
------------------------------------
CREATE PROCEDURE [dbo].[user_GetJoinKindergartenListByKid]
@kid int,
@usertype int,
@page int,
@size int
 AS 
	DECLARE @prep int,@ignore int
	
	SET @prep = @size * @page
	SET @ignore=@prep - @size

	DECLARE @tmptable TABLE
	(
		--定义临时表
		row int IDENTITY (1, 1),
		tmptableid bigint
	)
	
	SET ROWCOUNT @prep
	INSERT INTO @tmptable(tmptableid)
	SELECT
		t1.userid
	FROM
		[user] t1 Inner JOIN [tem_user_kindergarten] t2 on t1.userid=t2.userid
	WHERE
		t2.kid=@kid and t1.deletetag=1 and t1.usertype=@usertype
	ORDER BY
		t1.regdatetime DESC


	SET ROWCOUNT @size
	SELECT 
		t1.userid,t1.account,t3.name,t3.gender,t3.mobile,t5.cname
	FROM @tmptable as tmptable inner join [user] t1 on tmptable.tmptableid = t1.userid inner join [user_baseinfo] t3 on t1.userid=t3.userid
		LEFT JOIN [tem_user_class] t4 on t1.userid=t4.userid  LEFT Join [class] t5 on t4.cid=t5.cid
	WHERE
		row > @ignore
	ORDER BY  t1.regdatetime DESC
GO
