USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[company_GetLoginLastTime]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：得到商家的上次登录时间 
--项目名称：ServicePlatform
--说明：
--时间：2010-2-25 9:56:53
------------------------------------
CREATE PROCEDURE [dbo].[company_GetLoginLastTime]
@companyid int
 AS 
	DECLARE @actiondatetime DATETIME
	SELECT @actiondatetime=Max(actiondatetime) FROM [actionlogs] WHERE actionid=@companyid and actionmodel='1'
	SELECT top(1) id,actionid,actionname,actiondescription,actionmodel,actiondatetime,objectid,ownid,ownname
	 FROM [actionlogs]
	 WHERE actionid=@companyid and actionmodel='1' and actiondatetime<@actiondatetime order by actiondatetime desc
GO
