USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[RoleRightDel]    Script Date: 05/14/2013 14:58:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RoleRightDel]
@role_id int
AS
DELETE FROM sac_role_right WHERE role_id=@role_id
GO
