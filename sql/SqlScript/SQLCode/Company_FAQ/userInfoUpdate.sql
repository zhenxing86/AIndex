USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[userInfoUpdate]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gaolao
-- Create date: 2010-12-20
-- Description:	用户信息修改
-- =============================================
CREATE PROCEDURE [dbo].[userInfoUpdate]
@userid int,
@username nvarchar(50),
@password nvarchar(50),
@newpassword nvarchar(50)
AS
DECLARE @count int
SELECT @count=COUNT(*) FROM sac_User WHERE [user_id]=@userid AND password=@password
IF @count>0
BEGIN
UPDATE sac_User
SET username=@username,
    password=@newpassword
WHERE [user_id]=@userid
RETURN 1
END
ELSE
RETURN -1

GO
