USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[RightUpdate]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改权限 
--项目名称：Right
--说明：
--时间：2010-5-5
------------------------------------
CREATE PROCEDURE [dbo].[RightUpdate]
@right_id int,
@site_id int,
@site_instance_id int,
@up_right_id int,
@right_name nvarchar(100),
@right_code nvarchar(100)
AS
BEGIN
	DECLARE @old_site_instance_id INT
	SELECT @old_site_instance_id=site_instance_id FROM [sac_right] WHERE right_id=@right_id
	IF NOT EXISTS(SELECT * FROM sac_right WHERE right_name=@right_name and right_code=@right_code and up_right_id=@up_right_id and site_id=@site_id and site_instance_id=@old_site_instance_id)
	BEGIN
		UPDATE [sac_right] SET 
		[site_id] = @site_id,[site_instance_id] =@old_site_instance_id,[up_right_id] = @up_right_id,[right_name]=@right_name,[right_code]=@right_code
		WHERE right_id=@right_id 
	END
	ELSE
	BEGIN
		RETURN (-1)
	END

    IF(@@ERROR<>0)
    BEGIN
	   RETURN (-1)
    END
    ELSE
    BEGIN
	   RETURN (1)
    END
END


GO
