USE [ResourceApp]
GO
/****** Object:  StoredProcedure [dbo].[course_content_GetSubtypeListByPage]    Script Date: 2014/11/24 23:26:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：分页取互动学堂系列课件
--项目名称：CLASSHOMEPAGE
--说明：
--时间：2009-3-29 22:30:07
------------------------------------
CREATE PROCEDURE [dbo].[course_content_GetSubtypeListByPage]
@subtypeid int,
@page int,
@size int,
@userid int,
@isvip int
 AS
 
 declare @status varchar(10)
 select @status=status from basicdata..[User] u left join ossapp..kinbaseinfo k 
 on u.kid=k.kid  where u.userid=@userid
 
 if(@status='正常缴费')
 begin
	set @isvip=1
 end
 else
 begin
    set @isvip=0
 end
 
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
END
IF(@isvip=1)
BEGIN
	IF(@page>1)
	BEGIN
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
			SELECT
				id
			FROM
				course_content
			WHERE
				subtypeno=@subtypeid				
			ORDER BY
				[dbo].IsRead(@userid,id,3) asc,orderno desc


			SET ROWCOUNT @size
			SELECT
				t1.id,t1.thumbpath,t1.thumbfilename,t1.title,[dbo].IsRead(@userid,t1.id,3) AS isread,t1.createdatetime,t2.subtypeid,t2.title as subtitle
			FROM
				@tmptable as tmptable
			INNER JOIN
				course_content t1
			ON
				tmptable.tmptableid = t1.id
			INNER JOIN
				course_subtype t2 
			ON 
				t1.subtypeno=t2.subtypeid
			WHERE
				row > @ignore
			ORDER BY isread asc, t1.orderno desc
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT
			t1.id,t1.thumbpath,t1.thumbfilename,t1.title,[dbo].IsRead(@userid,t1.id,3) AS isread,t1.createdatetime,t2.subtypeid,t2.title as subtitle
		FROM
			course_content t1 INNER JOIN course_subtype t2 ON t1.subtypeno=t2.subtypeid
		where t1.subtypeno=@subtypeid
		order by isread asc, t1.orderno desc
	END
END
ELSE
BEGIN
	IF(@page>1)
	BEGIN
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
			SELECT
				id
			FROM
				course_content
			WHERE
			subtypeno=@subtypeid AND status <> 1
			ORDER BY
				[dbo].IsRead(@userid,id,3) asc,orderno desc


			SET ROWCOUNT @size
			SELECT
				t1.id,t1.thumbpath,t1.thumbfilename,t1.title,[dbo].IsRead(@userid,t1.id,3) AS isread,t1.createdatetime,t2.subtypeid,t2.title as subtitle
			FROM
				@tmptable as tmptable
			INNER JOIN
				course_content t1
			ON
				tmptable.tmptableid = t1.id
			LEFT JOIN 
				course_subtype t2 
			ON
				t1.subtypeno=t2.subtypeid
			WHERE
				row > @ignore
			ORDER BY isread asc, t1.orderno desc
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT
			t1.id,t1.thumbpath,t1.thumbfilename,t1.title,[dbo].IsRead(@userid,t1.id,3) AS isread,t1.createdatetime,t2.subtypeid,t2.title as subtitle
		FROM
			course_content t1 INNER JOIN course_subtype t2 ON t1.subtypeno=t2.subtypeid
		where t1.subtypeno=@subtypeid AND t1.status <> 1
		order by isread asc, t1.orderno desc
	END
END




GO
