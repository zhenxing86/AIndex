USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_company_GetModel]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询商家信息 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-12-22 11:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_company_GetModel] 
@companyid int
 AS 
SELECT t1.companyid,t1.account,t1.password,t1.province,t1.city,t1.companyname,t1.companysynopsis,t1.tel,t1.linkman,t1.address,t1.qqnumber,t1.email,t1.imagepath,t1.imagename,t1.regdatetime,t1.activitycount,t1.productscount,t1.companycommentcount,t1.companystatus,t1.website,t1.companycategoryid,t1.updatetime,t1.orderno,t1.companyappraisecount,t1.viewcount,
t1.isinterior,t1.status,t1.themeid,t1.shortname,t1.headdescription,t1.tipstatus
FROM 
	company t1 
WHERE t1.companyid=@companyid
GO
