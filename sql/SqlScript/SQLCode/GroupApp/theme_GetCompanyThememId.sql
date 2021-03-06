USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[theme_GetCompanyThememId]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：取出商家模板id 
--项目名称：ServicePlatform
--说明：
--时间：2010-02-18 16:28:40
------------------------------------
CREATE PROCEDURE [dbo].[theme_GetCompanyThememId]
@companyid int
AS 
	DECLARE @themeid int
	SELECT @themeid=themeid FROM company WHERE companyid=@companyid and status=1
	RETURN Isnull(@themeid, 0)

GO
