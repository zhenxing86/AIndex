USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[UserGetModel]    Script Date: 05/14/2013 14:58:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		高老
-- Create date: 2010-9-25
-- Description:	获得管理员实体
-- =============================================
CREATE PROCEDURE [dbo].[UserGetModel]
@user_id int
AS
BEGIN    
	SELECT [user_id],[account],[password],
     [username],[createdatetime],sac_user.org_id,[org_name],[status]
    FROM sac_user
    INNER JOIN sac_org ON sac_user.org_id=sac_org.org_id
    WHERE [user_id]=@user_id
END
GO
