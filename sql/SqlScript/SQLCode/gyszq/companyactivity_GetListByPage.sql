USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companyactivity_GetListByPage]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询商家活动信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-11 10:47:40
------------------------------------
CREATE PROCEDURE [dbo].[companyactivity_GetListByPage]
@companyid int,
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
		SELECT activityid FROM [companyactivity] WHERE companyid=@companyid and status=1 ORDER BY createdatetime DESC

		SET ROWCOUNT @size
		SELECT activityid,companyid,title,activitycontent,targethref,createdatetime,commentcount
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			companyactivity t1 ON tmptable.tmptableid=t1.activityid
		WHERE 
			row >  @ignore ORDER BY createdatetime DESC
	
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
		activityid,companyid,title,activitycontent,targethref,createdatetime,commentcount
		 FROM [companyactivity] WHERE companyid=@companyid and status=1 ORDER BY createdatetime DESC
	END
GO
