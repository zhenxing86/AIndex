USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[right_EditRole]    Script Date: 05/14/2013 14:58:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-6
-- Description:	编辑角色
-- =============================================
CREATE PROCEDURE [dbo].[right_EditRole]
@role_id int,
@role_name nvarchar(30)
AS
UPDATE sac_role
SET role_name=@role_name
WHERE role_id=@role_id
RETURN @@ROWCOUNT
GO
