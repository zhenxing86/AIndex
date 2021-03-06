USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companyactivity_GetList]    Script Date: 08/28/2013 14:42:21 ******/
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
CREATE PROCEDURE [dbo].[companyactivity_GetList]
@companyid int
 AS 
	SELECT top 3
	activityid,companyid,title,activitycontent,targethref,createdatetime,commentcount
	 FROM [companyactivity] WHERE companyid=@companyid and status=1 ORDER BY createdatetime DESC
GO
