USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companyappraise_GetTopListByPage]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询商家评价记录信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-8-13 9:40:48
------------------------------------
CREATE PROCEDURE [dbo].[companyappraise_GetTopListByPage]
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
		SELECT companyappraiseid FROM companyappraise WHERE companyid=@companyid AND status=1 AND parentid=0 ORDER BY appraisedatetime DESC

		SET ROWCOUNT @size
			SELECT 
			companyappraiseid,companyid,level,author,userid,parentid,contact,memo,appraisedatetime,fromip
			 FROM [companyappraise] t1 INNER JOIN @tmptable as tmptable ON t1.companyappraiseid=tmptable.tmptableid
			WHERE
				row>@ignore ORDER BY appraisedatetime DESC	

	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
		companyappraiseid,companyid,level,author,userid,parentid,contact,memo,appraisedatetime,fromip
		 FROM [companyappraise] WHERE companyid=@companyid AND status=1 AND parentid=0 ORDER BY appraisedatetime DESC
	END
GO
