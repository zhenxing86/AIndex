USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[UserInfoUpdate]    Script Date: 05/14/2013 14:58:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gaolao
-- Create date: 2011-1-4
-- Description:	用户资料修改
-- =============================================
CREATE PROCEDURE [dbo].[UserInfoUpdate]
@userid int,
@username nvarchar(30),
@oldpassword nvarchar(64),
@newpassword nvarchar(64)
AS
DECLARE @result int
SELECT @result=COUNT(*) FROM sac_user WHERE [user_id]=@userid AND password=@oldpassword
IF @result>0
BEGIN
    UPDATE sac_user 
    SET username=@username,password=@newpassword
    WHERE [user_id]=@userid
    RETURN @@ROWCOUNT
END
ELSE
BEGIN
    RETURN -1
END
GO
