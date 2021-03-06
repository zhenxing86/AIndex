USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[RightDelete]    Script Date: 05/14/2013 14:58:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除权限
--项目名称：Right
--建立人：麦
--说明:
--时间：2010-05-05
------------------------------------
CREATE PROCEDURE [dbo].[RightDelete]
@right_id int
 AS 
BEGIN
	IF EXISTS(SELECT * FROM sac_right WHERE up_right_id=@right_id)
	BEGIN
		RETURN (-2)
	END
	ELSE
	BEGIN
		DELETE  [sac_right] WHERE right_id=@right_id --删除权限
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
