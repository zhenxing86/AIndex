USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[UserPwdUpdate]    Script Date: 2014/11/24 23:34:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		高老
-- Create date: 2010-9-29
-- Description:	密码修改
-- =============================================
CREATE PROCEDURE [dbo].[UserPwdUpdate]
@account nvarchar(30),
@oldPassword nvarchar(64),
@newPassword nvarchar(64)
AS
IF EXISTS(SELECT * FROM sac_user WHERE account=@account AND password=@oldPassword)
BEGIN
UPDATE sac_user
SET password=@newPassword
WHERE account=@account AND status=1
RETURN @@ROWCOUNT
END
ELSE
RETURN 0



GO
