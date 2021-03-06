USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_commoncompany_GetCount]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询品牌商家数
--项目名称：ServicePlatformManage
--说明：
--时间：2010-2-1 16:29:55
------------------------------------
CREATE PROCEDURE [dbo].[Manage_commoncompany_GetCount]
@commonproductcategoryid int
AS
	DECLARE @count INT
	IF(@commonproductcategoryid=0)
	BEGIN
		SELECT @count=count(1) FROM [commoncompany] t1 inner join [company] t2 on t1.companyid=t2.companyid WHERE t2.status=1 and t1.status=1 
	END
	ELSE
	BEGIN
		SELECT @count=count(1) FROM [commoncompany] t1 inner join [company] t2 on t1.companyid=t2.companyid WHERE t2.status=1 and t1.commonproductcategoryid=@commonproductcategoryid and t1.status=1 
	END
	RETURN @count

GO
