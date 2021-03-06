USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[right_GetCurrentUserRoles]    Script Date: 05/14/2013 14:58:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-6
-- Description:	获取用户拥有的角色列表
-- =============================================
CREATE PROCEDURE [dbo].[right_GetCurrentUserRoles]
@user_id int
AS
SELECT [user_id],sac_user_role.role_id,site_id,site_instance_id,role_name
FROM sac_user_role
INNER JOIN sac_role ON sac_role.role_id=sac_user_role.role_id
WHERE [user_id]=@user_id
GO
