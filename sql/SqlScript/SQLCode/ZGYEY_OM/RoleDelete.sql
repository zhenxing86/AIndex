USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[RoleDelete]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RoleDelete]
@role_id int
AS
DECLARE @error_sum int
BEGIN TRANSACTION
SET @error_sum=0
DELETE FROM sac_role WHERE role_id=@role_id
SET @error_sum=@error_sum+@@ERROR
DELETE FROM sac_role_right WHERE role_id=@role_id
SET @error_sum=@error_sum+@@ERROR
DELETE FROM sac_user_role WHERE role_id=@role_id
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
