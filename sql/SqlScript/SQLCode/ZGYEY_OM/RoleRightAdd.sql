USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[RoleRightAdd]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加角色权限
--项目名称：Right
--建立人:麦
--说明：
--时间：2010-5-5
------------------------------------
create PROCEDURE [dbo].[RoleRightAdd]
@role_id int,
@right_id int
 AS 
BEGIN
    DECLARE @id int
	INSERT INTO [sac_role_right](
	[role_id],[right_id]
	)VALUES(
	@role_id,@right_id
	)
	SET @id = @@IDENTITY

    IF(@@ERROR<>0)
    BEGIN
	    RETURN (-1)
    END
    ELSE
    BEGIN
	    RETURN (@id)
    END
END







GO
