USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[right_DelUserRole]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-12
-- Description:	删除用户已分配角色
-- =============================================
CREATE PROCEDURE [dbo].[right_DelUserRole]
@user_id int,
@role_id int
AS
IF EXISTS(SELECT * FROM sac_user_role WHERE [user_id]=@user_id AND role_id=@role_id)
BEGIN
DELETE FROM
      sac_user_role
WHERE
      [user_id]=@user_id AND role_id=@role_id
RETURN @@ROWCOUNT
END
ELSE
 RETURN 0



GO
