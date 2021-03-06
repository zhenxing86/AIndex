USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[right_GetRoleRightList]    Script Date: 05/14/2013 14:58:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-6
-- Description:	获取角色拥有的权限列表
-- =============================================
CREATE PROCEDURE [dbo].[right_GetRoleRightList]
@role_id int
AS
SELECT role_id,sac_role_right.right_id,site_id,site_instance_id,up_right_id,right_name,right_code
FROM sac_role_right
INNER JOIN sac_right ON sac_role_right.right_id=sac_right.right_id
WHERE role_id=@role_id
GO
