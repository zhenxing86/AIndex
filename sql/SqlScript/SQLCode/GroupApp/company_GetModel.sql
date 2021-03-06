USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[company_GetModel]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：得到商家的详细信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-11 11:12:43
------------------------------------
CREATE PROCEDURE [dbo].[company_GetModel]
@companyid int
 AS 
	SELECT 
	t1.companyid,t1.account,t1.password,t1.province,t1.city,t1.companyname,t1.companysynopsis,t1.tel,t1.linkman,t1.address,t1.qqnumber,t1.email,t1.imagepath,t1.imagename,t1.regdatetime,t1.activitycount,t1.productscount,t1.companycommentcount,t1.companystatus,t1.website,t1.companycategoryid,t1.updatetime,t1.orderno,t1.companyappraisecount,t1.viewcount,
		t2.source,t2.title,t1.headdescription,t1.tipstatus
	 FROM [company] t1 INNER JOIN companycategory t2 ON t1.companycategoryid=t2.companycategoryid 
	 WHERE t1.companyid=@companyid and t1.status=1

GO
