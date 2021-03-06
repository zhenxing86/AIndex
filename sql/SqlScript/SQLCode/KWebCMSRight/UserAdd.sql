USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[UserAdd]    Script Date: 05/14/2013 14:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加用户
--项目名称：Right
--建立人:麦
--说明：
--时间：2010-5-5
------------------------------------
CREATE PROCEDURE [dbo].[UserAdd]
@account nvarchar(30),
@password nvarchar(64),
@username nvarchar(30),
@org_id int,
@status int
 AS
DECLARE @error_sum int
    DECLARE @user_id int
    DECLARE @siteid int
BEGIN TRANSACTION
    SET @error_sum=0
	INSERT INTO [sac_user](
	[account],[password],[username],[createdatetime],[org_id],[status]
	)VALUES(
	@account,@password,@username,getdate(),@org_id,@status
	)
	SET @user_id = @@IDENTITY
    
    SET @error_sum=@error_sum+@@ERROR
    SET @siteid=0
    SELECT @siteid=siteid FROM KWebCMS..site WHERE org_id=@org_id
    IF @siteid>0
    INSERT INTO KWebCMS..site_user(
    siteid,account,password,[name],createdatetime,usertype,UID
    )VALUES(
    @siteid,@account,@password,@username,getdate(),98,@user_id)
    SET @error_sum=@error_sum+@@ERROR    
    
IF(@error_sum<>0)
    BEGIN
	    ROLLBACK TRANSACTION
    END
    ELSE
    BEGIN
        COMMIT TRANSACTION
        RETURN (@user_id)
    END
GO
