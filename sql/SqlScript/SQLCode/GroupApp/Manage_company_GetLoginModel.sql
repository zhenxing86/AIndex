USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_company_GetLoginModel]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询登录商家用的信息 
--项目名称：ServicePlatformManage
--说明：
--时间：2009-01-29 11:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_company_GetLoginModel] 
@companyid int
 AS 
	SELECT companyid,account,companyname FROM company WHERE companyid=@companyid

GO
