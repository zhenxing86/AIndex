USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companyactivity_GetTopList]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询商家活动信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-11 10:47:40
------------------------------------
CREATE PROCEDURE [dbo].[companyactivity_GetTopList]
 AS 
	SELECT TOP(10)
		t1.activityid,t1.companyid,t1.title,t1.activitycontent,t1.targethref,t1.createdatetime,t1.commentcount,t2.companyname
	 FROM [companyactivity] t1 inner join company t2 on t1.companyid=t2.companyid WHERE t2.companystatus=1 and t2.status=1 and t1.status=1 ORDER BY t1.createdatetime DESC


GO
