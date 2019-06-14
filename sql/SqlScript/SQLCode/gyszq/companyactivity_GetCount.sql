USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companyactivity_GetCount]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询商家活动数 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-11 14:48:59
------------------------------------
CREATE PROCEDURE [dbo].[companyactivity_GetCount]
@companyid int
 AS 

	DECLARE @count INT
	SELECT @count=count(1) FROM companyactivity WHERE companyid=@companyid and status=1
	RETURN @count
GO
