USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_company_shortname_Update]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改商家简称 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-02-22 09:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_company_shortname_Update] 
@companyid int,
@shortname nvarchar(20)
 AS 
	UPDATE  company SET shortname=@shortname WHERE companyid=@companyid

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (1)
END
GO
