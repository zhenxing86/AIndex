USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_periodical_GetModel]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：得到实体对象期刊 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-4-20 10:24:40
------------------------------------
CREATE PROCEDURE [dbo].[Manage_periodical_GetModel]
@periodicalid int
 AS 
	SELECT 
	periodicalid,title,createdatetime,status
	 FROM [periodical]
	 WHERE periodicalid=@periodicalid 


GO
