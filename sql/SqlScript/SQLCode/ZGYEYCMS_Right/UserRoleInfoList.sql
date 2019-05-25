USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[UserRoleInfoList]    Script Date: 05/14/2013 14:58:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UserRoleInfoList]
@user_id int
AS
SELECT role_id,account,username,sac_user.org_id,org_name
FROM sac_user
INNER JOIN sac_user_role ON sac_user.[user_id]=sac_user_role.[user_id]
INNER JOIN sac_org ON sac_user.org_id=sac_org.org_id
WHERE sac_user.[user_id]=@user_id
GO
