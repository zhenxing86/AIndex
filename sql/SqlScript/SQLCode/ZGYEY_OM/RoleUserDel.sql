USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[RoleUserDel]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RoleUserDel] 
@roleid int
AS
DELETE FROM sac_user_role WHERE role_id=@roleid



GO
