USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[productcomment_GeTopListByPage]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询记录信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-30 10:19:51
------------------------------------
CREATE PROCEDURE [dbo].[productcomment_GeTopListByPage]
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
		SELECT productcommentid FROM productcomment WHERE productid=@productid and status=1 and parentid=0 ORDER BY commentdatetime DESC

		SET ROWCOUNT @size
		SELECT productcommentid,productid,author,userid,content,parentid,commentdatetime,contact,fromip
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			productcomment t1 ON tmptable.tmptableid=t1.productcommentid
		WHERE 
			row >  @ignore ORDER BY commentdatetime DESC
	
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
		productcommentid,productid,author,userid,content,parentid,commentdatetime,contact,fromip
		 FROM [productcomment] WHERE productid=@productid and status=1 and parentid=0 ORDER BY commentdatetime DESC
	END
GO
