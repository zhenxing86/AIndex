USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[productappraise_GetListByPage]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询产品评价记录信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-8-13 9:40:48
------------------------------------
CREATE PROCEDURE [dbo].[productappraise_GetListByPage]
@productid int,
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
		SELECT productappraiseid FROM productappraise WHERE productid=@productid and status=1 ORDER BY appraisedatetime DESC

		SET ROWCOUNT @size
			SELECT 
			productappraiseid,productid,level,author,userid,parentid,contact,memo,appraisedatetime,fromip
			 FROM [productappraise] t1 INNER JOIN @tmptable as tmptable ON t1.productappraiseid=tmptable.tmptableid
			WHERE
				row>@ignore ORDER BY appraisedatetime DESC	

	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
		productappraiseid,productid,level,author,userid,parentid,contact,memo,appraisedatetime,fromip
		 FROM [productappraise] WHERE productid=@productid and status=1 ORDER BY appraisedatetime DESC
	END
GO
