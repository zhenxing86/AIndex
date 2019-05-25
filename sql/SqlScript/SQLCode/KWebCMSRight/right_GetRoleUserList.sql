USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[right_GetRoleUserList]    Script Date: 05/14/2013 14:53:16 ******/
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
