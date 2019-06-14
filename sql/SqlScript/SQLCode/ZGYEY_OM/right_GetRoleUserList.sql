USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[right_GetRoleUserList]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-11
-- Description:	获取角色的用户列表
-- =============================================
CREATE PROCEDURE [dbo].[right_GetRoleUserList]
@role_id int
AS
SELECT
   sac_user_role.[user_id],role_id,account,username,org_id
FROM
   sac_user_role
INNER JOIN
   sac_user
ON sac_user_role.[user_id]=sac_user.[user_id]
WHERE role_id=@role_id



GO
