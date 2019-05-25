USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companyactivity_GetModel]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：得到商家活动的详细信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-11 10:47:40
------------------------------------
CREATE PROCEDURE [dbo].[companyactivity_GetModel]
@activityid int
 AS 
	SELECT 
	activityid,companyid,title,activitycontent,targethref,createdatetime,commentcount
	 FROM [companyactivity]
	 WHERE activityid=@activityid and status=1


GO
