USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[right_GetAllUserRole]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		高老
-- Create date: 2010-9-30
-- Description:	获取组织下所有用户角色
-- =============================================
CREATE PROCEDURE [dbo].[right_GetAllUserRole]
@org_id int
AS
SELECT U.[user_id],username,R.role_id,role_name
FROM sac_user U
INNER JOIN sac_user_role ON U.[user_id]=sac_user_role.[user_id]
INNER JOIN sac_role R ON R.role_id=sac_user_role.role_id
WHERE org_id=@org_id
GO
