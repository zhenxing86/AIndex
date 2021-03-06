USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[customService_Login]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-5-6
-- Description:	执行登录
-- =============================================
CREATE PROCEDURE [dbo].[customService_Login] 
(
   @account nvarchar(50),
   @password nvarchar(50)
)
AS
IF EXISTS(SELECT * FROM sac_User WHERE account=@account AND password=@password)
SELECT
   [user_id],account,password,username
FROM
   sac_User
WHERE 
   account=@account
   AND password=@password

GO
