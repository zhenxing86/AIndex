USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[UserUpdate]    Script Date: 2014/11/24 23:34:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：修改用户 高老
--项目名称：Right
--说明：
--时间：2010-9-25
------------------------------------
CREATE PROCEDURE [dbo].[UserUpdate]
@user_id int,
@account nvarchar(30),
@password nvarchar(64),
@username nvarchar(30),
@org_id int,
@status int
AS
	UPDATE [sac_user] SET 
	[account] = @account,[password] = @password,[username]=@username,
    [createdatetime]=getdate(),[org_id]=@org_id,[status]=@status
	WHERE [user_id]=@user_id

IF(@@ERROR<>0)
    BEGIN
        RETURN -1
    END
    ELSE
    BEGIN
        RETURN 1
    END

GO
