USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[UserDelete]    Script Date: 05/14/2013 14:58:19 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UserDelete]
@user_id int
 AS
DECLARE @error_sum int
BEGIN TRANSACTION
    SET @error_sum=0

	DELETE FROM [sac_user] WHERE  [user_id]=@user_id --删除用户
    
    SET @error_sum=@error_sum+@@ERROR

    DELETE FROM sac_user_role WHERE [user_id]=@user_id

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
