USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[activitycomment_GetListByPage]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询商家活动评论
--项目名称：ServicePlatform
--说明：
--时间：2009-7-11 15:48:11
------------------------------------
CREATE PROCEDURE [dbo].[activitycomment_GetListByPage]
@activityid int,
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
		SELECT activitycommentid FROM activitycomment WHERE activityid=@activityid and status=1 ORDER BY commentdatetime DESC

		SET ROWCOUNT @size
		SELECT activitycommentid,activityid,author,userid,content,parentid,commentdatetime
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			[activitycomment] t1 ON tmptable.tmptableid=t1.activitycommentid
		WHERE 
			row > @ignore ORDER BY commentdatetime DESC
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
		activitycommentid,activityid,author,userid,content,parentid,commentdatetime
		 FROM [activitycomment] WHERE activityid=@activityid and status=1 ORDER BY commentdatetime DESC
	END	

GO
