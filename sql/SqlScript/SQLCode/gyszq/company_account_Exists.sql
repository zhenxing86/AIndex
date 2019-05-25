USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[company_account_Exists]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：账号重复检查 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-11 9:09:49
------------------------------------
CREATE PROCEDURE [dbo].[company_account_Exists]
@account nvarchar(30)
AS
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM company WHERE account=@account
	RETURN @TempID
GO
