USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[company_GetCount]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询商家数 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-11 14:48:59
------------------------------------
CREATE PROCEDURE [dbo].[company_GetCount]
@companycategoryid int
 AS 	
	DECLARE @count INT
	IF(@companycategoryid=0)
	BEGIN
		SELECT @count=count(1) FROM company WHERE  companystatus=1 and status=1
	END
	ELSE
	BEGIN
		SELECT @count=count(1) FROM company WHERE companystatus=1 and status=1 and (companycategoryid=@companycategoryid or companycategoryid in (SELECT companycategoryid FROM companycategory WHERE parentid=@companycategoryid)) 
	END
	RETURN @count

GO
