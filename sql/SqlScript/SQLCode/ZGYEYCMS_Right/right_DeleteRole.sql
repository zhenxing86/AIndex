USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[right_DeleteRole]    Script Date: 05/14/2013 14:58:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-6
-- Description:	删除角色
-- =============================================
CREATE PROCEDURE [dbo].[right_DeleteRole]
@role_id int
AS
IF EXISTS(SELECT * FROM sac_role WHERE role_id=@role_id)
BEGIN
DELETE FROM sac_role WHERE role_id=@role_id
RETURN @@ROWCOUNT
END
GO
