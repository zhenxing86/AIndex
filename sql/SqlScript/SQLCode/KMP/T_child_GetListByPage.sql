USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[T_child_GetListByPage]    Script Date: 2014/11/24 23:12:24 ******/
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
SELECT @kid=kindergartenid FROM t_class WHERE id=@classid

IF(@childname<>'')
BEGIN
	SELECT
		t1.userid,t1.name,t2.userid as classvideo
	FROM
		[t_child] t1  LEFT JOIN [T_bbzx_video] t2 on t1.userid=t2.userid 
	where t1.status=1 and t1.kindergartenid=@kid and t1.name like '%'+@childname+'%'
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
				[t_child] t1 --left join bloguserkmpUser t2 on 
			WHERE
				t1.status=1 and t1.classid=@classid and t1.name like 
'%'+@childname+'%'
			ORDER BY
				t1.[userid]  DESC

			SET ROWCOUNT @size
			SELECT
				t1.userid,t1.name,t2.userid as classvideo
			FROM
				@tmptable as tmptable
			INNER JOIN
				[t_child] t1 on t1.userid=tmptable.tmptableid
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
			t1.userid,t1.name,t2.userid as classvideo
		FROM
			[t_child] t1 --left join bloguserkmpUser t2 on 
		 LEFT JOIN [T_bbzx_video] t2 on t1.userid=t2.userid
		where t1.status=1 and t1.classid=@classid and t1.name like '%'+@childname+'%'
		order by t1.[userid]  DESC
	END	
END

GO
