USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_schedule_GetListByKid]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：分页取班级教学安排
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 22:03:20
------------------------------------
CREATE PROCEDURE [dbo].[class_schedule_GetListByKid]
@kid int,
@page int,
@size int
 
 AS
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
				scheduleid
			FROM
				class_schedule
			WHERE
				kid=@kid and status=1
			ORDER BY
				scheduleid DESC


			SET ROWCOUNT @size
			SELECT
				t1.scheduleid AS scheduleid,t1.title,t1.userid,t1.author,t1.classid,t1.kid,t1.content AS content,1,1,1, convert(varchar(19),t1.createdatetime,120)as createdatetime,t1.viewcount,t2.cname as classname,
				0 as mastercommentcount
			FROM
				@tmptable as tmptable
			INNER JOIN
				class_schedule t1
			ON
				tmptable.tmptableid = t1.scheduleid
			INNER JOIN 
				basicdata..class t2
			ON 
				t1.classid=t2.cid and t2.deletetag=1
			WHERE
				row > @ignore
			ORDER BY
					t1.scheduleid DESC
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT
			t1.scheduleid AS scheduleid,t1.title,t1.userid,t1.author,t1.classid,t1.kid,t1.content AS content,1,1,1,convert(varchar(19),createdatetime,120)as createdatetime,viewcount,t2.cname as classname,
			--(select count(1) from class_schedulemastercomment t3 where t3.docid=t1.scheduleid ) 
				0 as mastercommentcount
		FROM
			class_schedule t1 INNER JOIN basicdata..class t2 ON t1.classid=t2.cid and t2.deletetag=1 
		where t1.kid=@kid and t1.[status]=1
		order by t1.scheduleid desc
	END	










GO
