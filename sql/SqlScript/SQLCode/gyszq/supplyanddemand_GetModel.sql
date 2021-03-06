USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[supplyanddemand_GetModel]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：得到供求实体对象的详细信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-8-26 15:00:28
------------------------------------
CREATE PROCEDURE [dbo].[supplyanddemand_GetModel]
@supplyanddemandid int
 AS 
	SELECT 
	t1.supplyanddemandid,t1.companyid,t1.bloguserid,t1.content,t1.createdatetime,t1.orderno,t2.companyname,t3.nickname,t1.title
	 FROM [supplyanddemand] t1 left join company t2 on t1.companyid=t2.companyid left join blog..blog_user t3 on t1.bloguserid=t3.userid
	 WHERE t1.supplyanddemandid=@supplyanddemandid and t1.status=1
GO
