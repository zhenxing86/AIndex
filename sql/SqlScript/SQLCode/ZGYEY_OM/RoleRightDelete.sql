USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[RoleRightDelete]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：删除角色
--项目名称：Right
--建立人：麦
--说明:
--时间：2010-05-05
------------------------------------
create PROCEDURE [dbo].[RoleRightDelete]
@role_id int,
@right_id int
 AS 
BEGIN
	DELETE from [sac_role_right] 
    WHERE role_id=@role_id and right_id=@right_id
   
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
