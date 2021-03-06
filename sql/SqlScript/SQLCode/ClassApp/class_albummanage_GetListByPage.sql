USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_albummanage_GetListByPage]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：分页取相册信息 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 10:58:57
------------------------------------
CREATE PROCEDURE [dbo].[class_albummanage_GetListByPage]
@classid int,
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
				albumid
			FROM
				class_album
			WHERE
				classid=@classid AND status=1
			ORDER BY
				albumid DESC 

			SET ROWCOUNT @size
			SELECT t1.albumid,t1.title,t1.description,t1.photocount,t1.classid,t1.kid,t1.userid,t1.author,t1.createdatetime,
				(select top 1 filepath+'\'+ filename from class_photos t2 where t2.albumid=t1.albumid and t2.status=1) as defaultcoverphoto,
				(select top(1) filepath+'\'+ filename from class_photos t2 where t2.albumid=t1.albumid and t2.iscover=1 and t2.status=1) as coverphoto,
                (SELECT TOP (1) uploaddatetime FROM dbo.class_photos AS t2 WHERE (t2.albumid = t1.albumid) and t2.status=1) AS defaultphotodatetime,
                (SELECT top(1) uploaddatetime FROM dbo.class_photos AS t2  WHERE (t2.albumid = t1.albumid) AND (t2.iscover = 1) and t2.status=1) AS coverphotodatetime
			FROM
				@tmptable as tmptable
			INNER JOIN
				class_album t1
			ON
				tmptable.tmptableid = t1.albumid
			WHERE
				row > @ignore

	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT
			t1.albumid,t1.title,t1.description,t1.photocount,t1.classid,t1.kid,t1.userid,t1.author,t1.createdatetime,
			(select top 1 filepath+'\'+ filename from class_photos t2 where t2.albumid=t1.albumid and t2.status=1) as defaultcoverphoto,
			(select top(1) filepath+'\'+ filename from class_photos t2 where t2.albumid=t1.albumid and t2.iscover=1 and t2.status=1) as coverphoto,
            (SELECT TOP (1) uploaddatetime FROM dbo.class_photos AS t2 WHERE (t2.albumid = t1.albumid) and t2.status=1) AS defaultphotodatetime,
            (SELECT top(1) uploaddatetime FROM dbo.class_photos AS t2  WHERE (t2.albumid = t1.albumid) AND (t2.iscover = 1) and t2.status=1) AS coverphotodatetime

		FROM
			class_album t1 
		where t1.classid=@classid 
		order by createdatetime desc
	END






GO
