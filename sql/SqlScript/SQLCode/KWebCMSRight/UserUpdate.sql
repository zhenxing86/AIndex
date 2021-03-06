USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[UserUpdate]    Script Date: 05/14/2013 14:53:17 ******/
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
DECLARE @error_sum int
BEGIN TRANSACTION
    SET @error_sum=0
	UPDATE [sac_user] SET 
	[account] = @account,[password] = @password,[username]=@username,
    [createdatetime]=getdate(),[org_id]=@org_id,[status]=@status
	WHERE [user_id]=@user_id
    SET @error_sum=@error_sum+@@ERROR

    UPDATE KWebCMS..site_user
    SET account=@account,password=@password,[name]=@username
    WHERE UID=@user_id
    SET @error_sum=@error_sum+@@ERROR

IF(@error_sum<>0)
    BEGIN
	    ROLLBACK TRANSACTION
        RETURN -1
    END
    ELSE
    BEGIN
        COMMIT TRANSACTION
        RETURN 1
    END
GO
