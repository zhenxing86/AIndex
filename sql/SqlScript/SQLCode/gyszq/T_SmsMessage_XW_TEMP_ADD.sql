USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[T_SmsMessage_XW_TEMP_ADD]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：商家注册短信通知 
--项目名称：ServicePlatform
--说明：
--时间：2010-03-22 11:48:26
------------------------------------
CREATE PROCEDURE [dbo].[T_SmsMessage_XW_TEMP_ADD]
@content nvarchar(100),
@qq nvarchar(30)
AS
	
IF(@@ERROR<>0)
BEGIN
	
	RETURN (-1)
END
ELSE
BEGIN
	
	RETURN (1)
END
GO
