USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_scheduleattach_GetList]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：取教学安排附件列表 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 22:35:44
------------------------------------
CREATE PROCEDURE [dbo].[class_scheduleattach_GetList]
@scheduleid int
 AS 

	SELECT 
	attachid AS attachid,scheduleid AS scheduleid,title,filename,filepath,createdatetime
	 FROM class_scheduleattach where scheduleid=@scheduleid











GO
