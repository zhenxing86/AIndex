USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[RoleAdd]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加角色
--项目名称：Right
--建立人:麦
--说明：
--时间：2010-5-5
------------------------------------
CREATE PROCEDURE [dbo].[RoleAdd]
@site_id int,
@site_instance_id int,
@role_name nvarchar(30)
 AS 
BEGIN
    DECLARE @role_id int
	INSERT INTO [sac_role](
	[site_id],[site_instance_id],[role_name]
	)VALUES(
	@site_id,@site_instance_id,@role_name
	)
	SET @role_id = @@IDENTITY

    IF(@@ERROR<>0)
    BEGIN
	    RETURN (-1)
    END
    ELSE
    BEGIN
	    RETURN (@role_id)
    END
END






GO
