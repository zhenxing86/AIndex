USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[right_CreateUserRole]    Script Date: 05/14/2013 14:58:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-6
-- Description:	用户角色分配
-- =============================================
CREATE PROCEDURE [dbo].[right_CreateUserRole]
@user_id int,
@role_id int
AS
IF NOT EXISTS(SELECT * FROM sac_user_role WHERE [user_id]=@user_id AND role_id=@role_id)
BEGIN
INSERT INTO sac_user_role([user_id],role_id) VALUES(@user_id,@role_id)
RETURN @@IDENTITY
END
ELSE
RETURN 0
GO
