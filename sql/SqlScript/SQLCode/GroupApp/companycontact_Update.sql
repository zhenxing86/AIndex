USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companycontact_Update]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：修改一条商家联系方式记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-9-2 15:15:21
------------------------------------
CREATE PROCEDURE [dbo].[companycontact_Update]
@companycontactid int,
@contactaccount nvarchar(30)
 AS 
	UPDATE [companycontact] SET 
	[contactaccount] = @contactaccount
	WHERE companycontactid=@companycontactid 
IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (1)
END



GO
