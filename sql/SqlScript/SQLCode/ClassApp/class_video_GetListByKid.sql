USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_video_GetListByKid]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：分页取视频信息 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 15:18:06
--exec [class_video_GetListByKid] 5380,1,11
------------------------------------
CREATE  PROCEDURE [dbo].[class_video_GetListByKid]
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
				videoid
			FROM
				class_video
			WHERE
				kid=@kid and status=1
			ORDER BY
				videoid DESC


			SET ROWCOUNT @size
			SELECT
				t1.videoid,t1.userid,t1.classid,t1.kid,t1.title,t1.description,t1.filename,t1.filepath,t1.filesize,t1.viewcount,t1.commentcount,t1.uploaddatetime,t1.author,t1.coverphoto,t2.cname as classname,t1.weburl,t1.videotype,t1.net
			FROM
				@tmptable as tmptable
			INNER JOIN
				class_video t1
			ON
				tmptable.tmptableid = t1.videoid
			INNER JOIN 
				basicdata..class t2
			ON 
				t1.classid=t2.cid and t2.deletetag=1
			WHERE
				row > @ignore
			ORDER BY
				videoid DESC
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT
			t1.videoid,t1.userid,t1.classid,t1.kid,t1.title,t1.description,t1.filename,t1.filepath,t1.filesize,t1.viewcount,t1.commentcount,t1.uploaddatetime,t1.author,t1.coverphoto,t2.cname as classname,t1.weburl,t1.videotype,t1.net
		FROM
			class_video t1 INNER JOIN basicdata..class t2 on t1.classid=t2.cid and t2.deletetag=1
		where t1.kid=@kid and t1.status=1
		order by t1.videoid desc
	END	











GO
