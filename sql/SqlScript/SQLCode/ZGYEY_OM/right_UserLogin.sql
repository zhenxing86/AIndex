USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[right_UserLogin]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-9-26
-- Description:	判断登录是否成功
-- =============================================
CREATE PROCEDURE [dbo].[right_UserLogin]
@account nvarchar(30),
@password nvarchar(64)
AS
IF EXISTS(SELECT * FROM sac_user WHERE account=@account 
      AND password=@password AND status=1)
SELECT DISTINCT [user_id],account,username FROM sac_user WHERE account=@account 
      AND password=@password AND status=1



GO
