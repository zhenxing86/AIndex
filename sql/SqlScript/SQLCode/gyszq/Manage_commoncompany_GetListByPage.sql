USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_commoncompany_GetListByPage]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询品牌商家列表 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-2-1 16:29:55
------------------------------------
CREATE PROCEDURE [dbo].[Manage_commoncompany_GetListByPage]
@commonproductcategoryid int,
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
	END
IF(@commonproductcategoryid=0)
BEGIN
	IF(@page>1)
	BEGIN
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
		SELECT t1.commoncompanyid FROM [commoncompany] t1 INNER JOIN [company] t2 on t1.companyid=t2.companyid  WHERE t2.status=1 and t1.status=1 ORDER BY t1.orderno ASC

		SET ROWCOUNT @size
		SELECT t1.commoncompanyid,t1.companyid,t1.commonproductcategoryid,t1.orderno,t1.createdatetime,t1.status,t2.companyname
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			[commoncompany] t1 ON tmptable.tmptableid=t1.commoncompanyid
		INNER JOIN 
			[company] t2 ON t1.companyid=t2.companyid
		WHERE 
			row >  @ignore ORDER BY t1.orderno ASC
	
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
		t1.commoncompanyid,t1.companyid,t1.commonproductcategoryid,t1.orderno,t1.createdatetime,t1.status,t2.companyname
		 FROM [commoncompany] t1 inner join [company] t2 on t1.companyid=t2.companyid WHERE t2.status=1 and t1.status=1 ORDER BY t1.orderno ASC
	END
END
ELSE
BEGIN
	IF(@page>1)
	BEGIN
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
		SELECT t1.commoncompanyid FROM [commoncompany] t1 INNER JOIN [company] t2 on t1.companyid=t2.companyid  WHERE t2.status=1 and t1.commonproductcategoryid=@commonproductcategoryid and t1.status=1 ORDER BY t1.orderno ASC

		SET ROWCOUNT @size
		SELECT t1.commoncompanyid,t1.companyid,t1.commonproductcategoryid,t1.orderno,t1.createdatetime,t1.status,t2.companyname
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			[commoncompany] t1 ON tmptable.tmptableid=t1.commoncompanyid
		INNER JOIN 
			[company] t2 ON t1.companyid=t2.companyid
		WHERE 
			row >  @ignore ORDER BY t1.orderno ASC
	
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
		t1.commoncompanyid,t1.companyid,t1.commonproductcategoryid,t1.orderno,t1.createdatetime,t1.status,t2.companyname
		 FROM [commoncompany] t1 inner join [company] t2 on t1.companyid=t2.companyid WHERE t2.status=1 and t1.commonproductcategoryid=@commonproductcategoryid and t1.status=1 ORDER BY t1.orderno ASC
	END
END
GO
