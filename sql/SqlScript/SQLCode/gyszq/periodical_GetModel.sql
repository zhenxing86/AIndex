USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[periodical_GetModel]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：得到实体对象期刊 
--项目名称：ServicePlatform
--说明：
--时间：2010-4-20 10:24:40
------------------------------------
CREATE PROCEDURE [dbo].[periodical_GetModel]
@periodicalid int
 AS 
	SELECT 
	periodicalid,title,createdatetime,status
	 FROM [periodical]
	 WHERE periodicalid=@periodicalid
GO
