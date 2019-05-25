USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_GetKindergartenInfo]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：得到幼儿园信息 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 11:50:29
------------------------------------
CREATE PROCEDURE [dbo].[class_GetKindergartenInfo]
@kid int
 AS 
	SELECT
	t1.siteid,t1.name,t1.sitedns as kurl,
	t2.isvip,
	t2.isvipcontrol
	 FROM kwebcms..site t1 inner join KWebCMS.dbo.site_config t2 on t1.siteid=t2.siteid
	 WHERE t1.siteid=@kid

GO
