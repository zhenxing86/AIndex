USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[right_GetRolesList]    Script Date: 05/14/2013 14:58:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-6
-- Description:	获取站点实例拥有的角色列表
-- =============================================
CREATE PROCEDURE [dbo].[right_GetRolesList]
@site_id int,
@site_instance_id int
AS
SELECT role_id,site_id,site_instance_id,role_name
FROM sac_role
WHERE site_id=@site_id AND site_instance_id=@site_instance_id
GO
