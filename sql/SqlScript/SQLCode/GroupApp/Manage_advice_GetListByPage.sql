USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_advice_GetListByPage]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询建议列表 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-2-24 9:20:09
------------------------------------
CREATE PROCEDURE [dbo].[Manage_advice_GetListByPage]
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
		SELECT t1.adviceid FROM [advice] t1 INNER JOIN [company] t2 ON t1.companyid=t2.companyid
		WHERE t1.status=1 AND t2.status=1 ORDER BY t1.createdatetime DESC

		SET ROWCOUNT @size
			SELECT 	t1.adviceid,t1.companyid,t1.content,t1.createdatetime,t1.status,t2.companyname
			FROM  @tmptable as tmptable INNER JOIN [advice] t1 ON t1.adviceid=tmptable.tmptableid
				INNER JOIN [company] t2 ON t1.companyid=t2.companyid
			WHERE
				row>@ignore ORDER BY t1.createdatetime DESC

	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
		t1.adviceid,t1.companyid,t1.content,t1.createdatetime,t1.status,t2.companyname
		 FROM [advice] t1 INNER JOIN [company] t2 ON t1.companyid=t2.companyid
		WHERE t1.status=1 AND t2.status=1 ORDER BY t1.createdatetime DESC
	END




GO
