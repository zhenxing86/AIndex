USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[right_DeleteRole]    Script Date: 2014/11/24 23:34:44 ******/
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
