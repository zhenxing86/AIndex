USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[RightAdd]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加权限
--项目名称：Right
--建立人:麦
--说明：
--时间：2010-5-5
------------------------------------
CREATE PROCEDURE [dbo].[RightAdd]
@site_id int,
@site_instance_id int,
@up_right_id int,
@right_name nvarchar(100),
@right_code nvarchar(100)
 AS
BEGIN
	IF NOT EXISTS(SELECT * FROM sac_right WHERE right_code=@right_code and up_right_id=@up_right_id and site_id=@site_id and site_instance_id=@site_instance_id)
	BEGIN
		DECLARE @right_id int
		INSERT INTO [sac_right](
		[site_id],[site_instance_id],[up_right_id],[right_name],[right_code]
		)VALUES(
		@site_id,@site_instance_id,@up_right_id,@right_name,@right_code
		)
		SET @right_id = @@IDENTITY
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
	    RETURN (@right_id)
    END
END
GO
