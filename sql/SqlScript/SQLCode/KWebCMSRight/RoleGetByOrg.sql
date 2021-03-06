USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[RoleGetByOrg]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		高老
-- Create date: 2010-9-17
-- Description:	获取组织下所有角色
-- =============================================
CREATE PROCEDURE [dbo].[RoleGetByOrg]
@org_id int
AS
SELECT role_id,role_name
FROM sac_role 
INNER JOIN sac_site_instance 
ON sac_role.site_instance_id=sac_site_instance.site_instance_id
WHERE org_id=@org_id AND role_name!='超级管理员'
UNION
SELECT role_id,role_name
FROM sac_role
WHERE site_instance_id=0
GO
