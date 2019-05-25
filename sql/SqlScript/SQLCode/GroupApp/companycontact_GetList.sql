USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companycontact_GetList]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询商家联系方式记录信息 
--项目名称：CodematicDemo
--说明：
--时间：2009-9-2 15:15:21
------------------------------------
CREATE PROCEDURE [dbo].[companycontact_GetList]
@companyid int
 AS 
	SELECT 
	companycontactid,companyid,contacttype,contactaccount,orderno,status
	 FROM [companycontact] where companyid=@companyid order by contacttype,orderno



GO
