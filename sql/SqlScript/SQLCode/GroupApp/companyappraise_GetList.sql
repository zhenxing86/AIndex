USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companyappraise_GetList]    Script Date: 2014/11/24 23:09:59 ******/
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
CREATE PROCEDURE [dbo].[companyappraise_GetList]
@companyid int
 AS 
	SELECT 
	companyappraiseid,companyid,level,author,userid,parentid,contact,memo,appraisedatetime,fromip
	 FROM [companyappraise] WHERE companyid=@companyid and status=1  ORDER BY appraisedatetime DESC

GO
