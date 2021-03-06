USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[right_GetCurrentUserRightList]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--=============================================
-- Author:		张启平
-- Create date: 2010-8-6
-- Description:	获取用户拥有的权限列表
-- =============================================
CREATE PROCEDURE [dbo].[right_GetCurrentUserRightList] 
@user_id int
AS
SELECT DISTINCT sac_right.right_id,right_code
FROM sac_user_role 
INNER JOIN sac_role_right ON sac_user_role.role_id=sac_role_right.role_id
INNER JOIN sac_right ON sac_role_right.right_id=sac_right.right_id
WHERE [user_id]=@user_id
GO
