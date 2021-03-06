USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[T_child_GetListByPage]    Script Date: 05/14/2013 14:43:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取本班小朋友列表
--项目名称：classhomepage
--说明：
--时间：2009-2-25 14:54:31
------------------------------------
CREATE PROCEDURE [dbo].[T_child_GetListByPage]
	@classid int,	
	@childname nvarchar(30),
	@page int,
	@size int
 AS 

DECLARE @kid int
SELECT @kid=kid FROM basicdata..user_class t1 INNER JOIN basicdata..user_kindergarten t2 on t1.userid=t2.userid  WHERE t1.cid=@classid

IF(@childname<>'')
BEGIN
	SELECT
		t1.userid,t1.name,t2.userid as classvideo
	FROM
		basicdata..user_baseinfo  t1 INNER JOIN  basicdata..user_kindergarten t3 on t1.userid=t3.userid  inner join basicdata..[user] t4 on t1.userid=t4.userid   inner join basicdata..user_class t5 on  t1.userid=t5.userid   LEFT JOIN [T_bbzx_video] t2 on t1.userid=t2.userid  
	where t4.deletetag=1 and  t4.usertype=0 and  t3.kid=@kid and t5.cid=@classid  and t1.name like '%'+@childname+'%'
	order by t1.[userid]  DESC
END
ELSE
BEGIN
	IF(@page>1)
	BEGIN
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
				basicdata..user_baseinfo  t1  INNER JOIN basicdata..user_kindergarten t2 on t1.userid=t2.userid inner join basicdata..[user] t3 on t1.userid=t3.userid inner join basicdata..user_class t4 on t1.userid=t4.userid  
			WHERE
				t2.kid=@kid and t4.cid=@classid and t3.deletetag=1  and t1.name like 
'%'+@childname+'%'
			ORDER BY
				t1.[userid]  DESC

			SET ROWCOUNT @size
			SELECT
				t1.userid,t1.name,t2.userid as classvideo
			FROM
				@tmptable as tmptable
			INNER JOIN
				basicdata..user_baseinfo t1 on t1.userid=tmptable.tmptableid
			LEFT JOIN
				[T_bbzx_video] t2 ON t1.userid=t2.userid
			WHERE
				row > @ignore
			ORDER BY
				t1.[userid]  DESC
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT
			t1.userid,t1.name,t5.userid as classvideo
		FROM
				basicdata..user_baseinfo  t1  INNER JOIN basicdata..user_kindergarten t2 on t1.userid=t2.userid inner join basicdata..[user] t3 on t1.userid=t3.userid inner join basicdata..user_class t4 on t1.userid=t4.userid   left join [T_bbzx_video] t5 on t1.userid=t5.userid
			WHERE
				t2.kid=@kid and t4.cid=@classid and t3.deletetag=1  and t1.name like '%'+@childname+'%'
			ORDER BY
				t1.[userid]  DESC
	END	
END
GO
