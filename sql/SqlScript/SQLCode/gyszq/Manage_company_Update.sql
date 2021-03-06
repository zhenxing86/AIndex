USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_company_Update]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改商家信息 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-12-22 11:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_company_Update] 
@companyid int,
@shortname nvarchar(20),
@headdescription nvarchar(200),
@viewcount int,
@tipstatus int
 AS 
	update company set shortname=@shortname,headdescription=@headdescription,viewcount=@viewcount,tipstatus=@tipstatus WHERE companyid=@companyid

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (1)
END
GO
