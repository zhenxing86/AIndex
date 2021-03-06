USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[RoleUpdate]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改角色 
--项目名称：Right
--说明：
--时间：2010-5-5
------------------------------------
create PROCEDURE [dbo].[RoleUpdate]
@role_id int,
@site_id int,
@site_instance_id int,
@role_name nvarchar(30)
AS 
BEGIN
	UPDATE [sac_role] SET 
	[site_id] = @site_id,[site_instance_id] =@site_instance_id,[role_name] = @role_name
	WHERE role_id=@role_id 

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
