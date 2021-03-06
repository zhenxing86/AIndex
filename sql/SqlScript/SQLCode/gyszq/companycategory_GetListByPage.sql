USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companycategory_GetListByPage]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询商家分类记录信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-8-5 11:48:26
------------------------------------
CREATE PROCEDURE [dbo].[companycategory_GetListByPage]
@page int,
@size int
 AS 
	IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		SET @prep=@page*@size
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int identity (1,1),
			tmptableid bigint
		)

		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
			SELECT companycategoryid FROM companycategory ORDER BY orderno

		SET ROWCOUNT @size
		SELECT 	companycategoryid,title,description,source,orderno,companycount,createdate,parentid
		FROM 
			[companycategory] t1
		INNER JOIN 
			@tmptable AS tmptable ON t1.companycategoryid=tmptable.tmptableid
		WHERE
			row>@ignore 
		ORDER BY orderno
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
		companycategoryid,title,description,source,orderno,companycount,createdate,parentid
		 FROM [companycategory] ORDER BY orderno
	END
GO
