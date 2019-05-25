USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[right_CreateRole]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-6
-- Description:	创建角色
-- =============================================
CREATE PROCEDURE [dbo].[right_CreateRole]
@site_id int,
@site_instance_id int,
@role_name nvarchar(30)
AS
INSERT INTO sac_role(site_id,site_instance_id,role_name)
VALUES(@site_id,@site_instance_id,@role_name)
RETURN @@IDENTITY



GO
